import 'package:cook_n_go/Pages/user_mainpage.dart';
import 'package:cook_n_go/Pages/vendor_mainpage.dart';
import 'package:cook_n_go/Pages/admin_mainpage.dart';
import 'package:cook_n_go/auth/login_or_register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // Show loading spinner while waiting for Firebase to return auth state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // If the user is logged in
          if (snapshot.hasData && snapshot.data != null) {
            User user = snapshot.data!;

            // Retrieve the user role from Firestore
            return FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection(
                      'Users') // Adjust collection based on your structure
                  .doc(user.uid)
                  .get(),
              builder: (context, userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (userSnapshot.hasData && userSnapshot.data!.exists) {
                  String? position = userSnapshot.data!['position'];

                  if (position == 'Admin') {
                    return const AdminMainpage();
                  } else if (position == 'User') {
                    return UserMainpage();
                  } else if (position == 'Vendor') {
                    return const VendorMainpage();
                  } else {
                    return const Center(child: Text('Unauthorized access'));
                  }
                } else {
                  return const Center(child: Text('User not found'));
                }
              },
            );
          } else {
            // User is not logged in, show the Login or Register page
            return const LoginOrRegister();
          }
        },
      ),
    );
  }
}
