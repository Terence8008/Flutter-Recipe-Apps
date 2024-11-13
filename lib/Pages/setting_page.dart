import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'user_profile_update.dart';
import 'vendor_profile_update.dart';
import 'admin_profile_update.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  Future<String?> getUserRole() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Check the role by checking the different collections
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(user.uid)
          .get();

      if (userDoc.exists) {
        return 'User';
      }

      DocumentSnapshot vendorDoc = await FirebaseFirestore.instance
          .collection('Vendor')
          .doc(user.uid)
          .get();

      if (vendorDoc.exists) {
        return 'Vendor';
      }

      DocumentSnapshot adminDoc = await FirebaseFirestore.instance
          .collection('Admin')
          .doc(user.uid)
          .get();

      if (adminDoc.exists) {
        return 'Admin';
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            String? role = await getUserRole();

            if (role == 'User') {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UserProfileUpdatePage()),
              );
            } else if (role == 'Vendor') {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => VendorProfileUpdatePage()),
              );
            } else if (role == 'Admin') {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AdminProfileUpdatePage()),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('User role not found')),
              );
            }
          },
          child: const Text('Profile Update'),
        ),
      ),
    );
  }
}
