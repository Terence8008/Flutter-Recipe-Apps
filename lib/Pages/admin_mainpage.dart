import 'package:cook_n_go/auth/login_or_register.dart';
import 'package:flutter/material.dart';
import 'package:cook_n_go/Pages/profile_page.dart'; // Import the ProfilePage

class AdminMainpage extends StatelessWidget {
  const AdminMainpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Custom Back Arrow Icon
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, size: 30),
                    onPressed: () {
                      // Navigate specifically to the LoginOrRegister page
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginOrRegister()),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
        
                // Logo
                Image.asset(
                  'asset/logoCleared.jpg',
                  width: 150,
                  height: 150,
                ),
                const SizedBox(height: 20),
        
                // "COOK N' GO" Title
                const Text(
                  "COOK N' GO",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 40),
                const Text(
                  "Welcome Admin!",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 40),
        
                // Profile Button
                GestureDetector(
                  onTap: () {
                    // Navigate to ProfilePage
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfilePage()),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 176, 141, 225),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Center(
                      child: Text(
                        "PROFILE",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
        
                // Recipe Button
                GestureDetector(
                  onTap: () {
                    // Handle Recipe button tap (you can add navigation here)
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 176, 141, 225),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Center(
                      child: Text(
                        "DATA ANALYZE",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
        
                // Delivery Button
                GestureDetector(
                  onTap: () {
                    // Handle Delivery button tap (you can add navigation here)
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 176, 141, 225),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Center(
                      child: Text(
                        "FEEDBACK",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
