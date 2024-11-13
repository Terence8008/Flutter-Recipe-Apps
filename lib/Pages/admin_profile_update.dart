import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cook_n_go/providers/admin_provider.dart';

class AdminProfileUpdatePage extends StatelessWidget {
  AdminProfileUpdatePage({super.key});

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

   // Method to update admin profile via AdminProvider
  Future<void> updateAdminProfile(BuildContext context) async {
    await Provider.of<AdminProvider>(context, listen: false).updateAdminProfile(
      username: usernameController.text,
      email: emailController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Admin Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await updateAdminProfile(context);
                Navigator.pop(context);
              },
              child: const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
