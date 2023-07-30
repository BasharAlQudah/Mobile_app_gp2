import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/doctor.dart' as doctor;
import '../models/user.dart' as model;

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  // sign up user

  Future<String> signUpUser({
    required String name,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    String res = 'Some error occured';
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        // register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        // add user to the database
        model.User user = model.User(name: name, email: email, role: 'user');

        print(cred.user!.uid);
        await _fireStore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());

        res = 'success';
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        res = 'The email is badly formatted';
      } else if (e.code == 'weak-password') {
        res = 'Password should be at least 6 characters';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

// sign up Doctor
  Future<String> signUpDoctor({
    required String email,
    required String name,
    required String password,
    required BuildContext context,
  }) async {
    String res = 'Some error occured';
    try {
      if (email.isNotEmpty || password.isNotEmpty || name.isNotEmpty) {
        // register Doctor
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        // add Doctor to the database
        doctor.Doctor doctorRole = doctor.Doctor(
          email: email,
          name: name,
          role: 'Doctor',
        );

        print(cred.user!.uid);
        await _fireStore
            .collection('users')
            .doc(cred.user!.uid)
            .set(doctorRole.toJson());
        res = 'success';
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        res = 'The email is badly formatted';
      } else if (e.code == 'weak-password') {
        res = 'Password should be at least 6 characters';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  //logging in user
  Future<String> loginUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    String res = 'Some error occured';

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        User user = userCredential.user!;

        res = 'Success';
      } else {
        res = 'Please enter all the fields';
      }
      Navigator.pushReplacementNamed(context, 'homepage');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        res = 'No user found';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future passwordReset(
      {required String email, required BuildContext context}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      if (e.toString() ==
          '[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.') {
      } else {
        print(e.message);
      }
    }
  }
}
