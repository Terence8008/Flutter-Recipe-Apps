import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:cook_n_go/const/collection.dart';


class AuthRepository {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

   // Stream to listen for auth state changes (login/logout)
  Stream<auth.User?> get authStateChanges => _firebaseAuth.authStateChanges();
  
  // Get the current user
  auth.User? get currentUser => _firebaseAuth.currentUser;
  
  // Sign up with email and password and save user info in Firestore
  Future<auth.User?> signUpWithEmail(String email, String password, String position, String username) async {
    try {
      final auth.UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password, 
      );
      final auth.User? user = userCredential.user;

      if (user != null) {
        // Determine the collection based on the user's role
        CollectionReference targetCollection;
        switch (position) {
          case 'Admin':
            targetCollection = adminCollection;
            break;
          case 'Vendor':
            targetCollection = venderCollection;
            break;
          default:
            targetCollection = userCollection;
        }

        // Save user info in the appropriate Firestore collection
        await targetCollection.doc(user.uid).set({
          'username': username,
          'email': email,
          'position': position,
          'uid': user.uid,
        });
      }

      return user;
    } catch (e) {
      print('Error signing up with email: $e');
      return null;
    }
  }


  // Sign in with email and password
  Future<auth.User?> signInWithEmail(String email, String password) async {
    try {
      final auth.UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
        print('Error signing in with email: $e');
      return null;
    }
  }

  // Sign out
  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  // Get currently signed-in user
  auth.User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  Future<String?> getUserRole(String uid) async {
  // Check 'Users' collection for 'User' role
  DocumentSnapshot userDoc = await userCollection.doc(uid).get();
  if (userDoc.exists) return userDoc['position'];

  // Check 'Admin' collection for 'Admin' role
  DocumentSnapshot adminDoc = await adminCollection.doc(uid).get();
  if (adminDoc.exists) return adminDoc['position'];

  // Check 'Vendor' collection for 'Vendor' role
  DocumentSnapshot vendorDoc = await venderCollection.doc(uid).get();
  if (vendorDoc.exists) return vendorDoc['position'];

  // Return null if no role found
  return null;
}
}