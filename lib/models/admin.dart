import 'package:cloud_firestore/cloud_firestore.dart';

class Admin {
  final String username;
  final String position;
  final String email;

  Admin ({
    required this.username,
    required this.position,
    required this.email,
  });

  factory Admin.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Admin(
      username: data['username'],
      position: data['position'],
      email: data['email'],
    );
  }
}