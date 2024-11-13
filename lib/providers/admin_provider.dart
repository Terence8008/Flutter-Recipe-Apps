import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminProvider with ChangeNotifier {
  // Method to update the admin profile in Firestore
  Future<void> updateAdminProfile({
    required String username,
    required String email,
  }) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Update Firestore document for Admin
      await FirebaseFirestore.instance.collection('Admin').doc(user.uid).update({
        'username': username,
        'email': email,
      });

    }
  }
}

