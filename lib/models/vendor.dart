import 'package:cloud_firestore/cloud_firestore.dart';

class Vendor {
  final String username;
  final String position;
  final String email; 

  Vendor ({
    required this.username,
    required this.position,
    required this.email,
  });

  factory Vendor.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Vendor(
      username: data['username'],
      position: data['position'],
      email: data['email'],
    );
  }
}