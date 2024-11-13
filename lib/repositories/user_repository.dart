import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> updateUserProfile({
    required String username,
    required String allergy,
    required String address,
    required String? gender,
    required bool isVegan,
  }) async {
    User? user = _firebaseAuth.currentUser;

    if (user != null) {
      await _firestore.collection('Users').doc(user.uid).update({
        'username': username,
        'allergy': allergy,
        'address': address,
        'gender': gender,
        'vegan': isVegan,
      });
    }
  }
}