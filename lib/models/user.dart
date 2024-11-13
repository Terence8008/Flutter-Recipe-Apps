import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String position;
  final String username;

  User({
    required this.email,
    required this.position,
    required this.username,
  });

  factory User.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return User(
      email: data['email'],
      position: data['position'],
      username: data['username'],
    );
  }
}
