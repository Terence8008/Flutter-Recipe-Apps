import 'package:cook_n_go/Pages/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cook_n_go/providers/profile_provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: Consumer<ProfileProvider>(
          builder: (context, profileProvider, child) {
            if (profileProvider.userData == null) {
              profileProvider.fetchUserData();
              return const Center(child: CircularProgressIndicator());
            }
        
            Map<String, dynamic> userData = profileProvider.userData!['data'];
            String collectionName = profileProvider.userData!['collection'] ?? 'Unknown';
        
            String username = userData['username'] ?? 'Unknown';
            String email = userData['email'] ?? 'Unknown';
            String position = collectionName;
        
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
        
                  // Profile Icon
                  const Center(
                    child: Icon(
                      Icons.person,
                      size: 100,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 20),
        
                  // Username
                  const Text(
                    'Username:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 10.0),
                    child: Text(
                      username,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 15),
        
                  // Email
                  const Text(
                    'Email:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 10.0),
                    child: Text(
                      email,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 15),
        
                  // Position/Role
                  const Text(
                    'Role:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 10.0),
                    child: Text(
                      position,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 15),
        
                  // Specific data for Users, Vendors, or Admins
                  if (position == 'Users') ...[
                    const Text(
                      'Allergy:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 10.0),
                      child: Text(
                        userData['allergy'] ?? 'Not specified',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Vegan:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 10.0),
                      child: Text(
                        userData['vegan'] == true ? 'Yes' : 'No',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 15),
                  ] else if (position == 'Vendor') ...[
                    const Text(
                      'Restaurant:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 10.0),
                      child: Text(
                        userData['restaurant'] ?? 'Not specified',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Address:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 10.0),
                      child: Text(
                        userData['address'] ?? 'Not specified',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 15),
                  ],
        
                  const Spacer(),
        
                  // Edit Button
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 176, 141, 225),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SettingPage()),
                        );
                      },
                      child: const Text(
                        'Setting',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}