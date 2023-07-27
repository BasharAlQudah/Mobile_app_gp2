import 'package:flutter/material.dart';
import 'package:gp2_mobile_app/homePage.dart';
import 'package:gp2_mobile_app/login.dart';
import 'package:gp2_mobile_app/register.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: 'login',
        routes: {
          'login': (context) => const MyLogin(),
          'register': (context) => const MyRegister(),
          'homepage': (context) => HomePage()
        }),
  );
}
