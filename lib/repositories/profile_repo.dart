import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<Map<String, dynamic>?> getUserData() async {
    String? uid = _auth.currentUser?.uid;
    if (uid == null) {
      return null;
    }

    DocumentSnapshot? userDoc;
    String? collectionFound;
    List<String> collections = ['Users', 'Admin', 'Vendor'];

    for (String collection in collections) {
      userDoc = await _firestore.collection(collection).doc(uid).get();
      if (userDoc.exists) {
        collectionFound = collection;
        break;
      }
    }

    if (userDoc != null && userDoc.exists) {
      return {
        'data': userDoc.data() as Map<String, dynamic>,
        'collection': collectionFound
      };
    }

    return null;
  }
}