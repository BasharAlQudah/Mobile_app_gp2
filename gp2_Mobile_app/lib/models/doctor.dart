import 'package:cloud_firestore/cloud_firestore.dart';

class Doctor {
  final String name;
  final String email;
  final String role;
  final String? id;

  const Doctor({
    this.id,
    required this.name,
    required this.role,
    required this.email,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'role': role,
      };

  static Doctor fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Doctor(
      role: snapshot['role'],
      name: snapshot['name'],
      email: snapshot['email'],
      id: snap.id,
    );
  }
}
