import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VendorRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> updateVendorProfile({
    required String username,
    required String restaurant,
    required String address,
  }) async {
    User? user = _firebaseAuth.currentUser;

    if (user != null) {
      await _firestore.collection('Vendor').doc(user.uid).update({
        'username': username,
        'restaurant': restaurant,
        'address': address,
      });
    }
  }
}