import 'package:cook_n_go/Pages/admin_mainpage.dart';
import 'package:cook_n_go/Pages/user_mainpage.dart';
import 'package:cook_n_go/Pages/vendor_mainpage.dart';
import 'package:cook_n_go/components/my_button.dart';
import 'package:cook_n_go/components/my_passwordtextfield.dart';
import 'package:cook_n_go/components/my_textfield.dart';
import 'package:cook_n_go/components/dropdown_menu.dart';
import 'package:cook_n_go/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controllers for the email and password text fields
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final ValueNotifier<String?> selectedPositionNotifier =
      ValueNotifier<String?>(null);

  //login method
  void login() async {
    // Show loading circle
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissal of loading
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      print("Break point 1");
      // Access AuthProvider
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      
      print("Break point 2");

      // Attempt sign-in via AuthProvider
      bool isSignedIn = await authProvider.signIn(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      // Debugging print to check if signIn succeeded
      print("Sign-in successful: $isSignedIn");

      // If sign-in is successful
      if (isSignedIn) {
        if (context.mounted) Navigator.pop(context);

        // Debugging print to see userRole value
        print("Retrieved user role: ${authProvider.userRole}"); 

        if (authProvider.userRole == 'User') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => UserMainpage()),
          );
        } else if (authProvider.userRole == 'Admin') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const AdminMainpage()),
          );
        } else if (authProvider.userRole == 'Vendor') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const VendorMainpage()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('User document not found')),
          );
        }
      } else {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login failed. Please try again.')),
        );
      }
    } catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Something went wrong. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Page"),
        centerTitle: true,
        backgroundColor: Colors.red[600],
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo and Login text side by side
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Logo
                  Image.asset(
                    'asset/logoCleared.jpg',
                    width: 150,
                    height: 150,
                  ),
                  const SizedBox(width: 20), // Spacing between logo and text

                  // Login text
                  const Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Dropdownbutton
              // Dropdown for position selection
              ValueListenableBuilder<String?>(
                valueListenable: selectedPositionNotifier,
                builder: (context, selectedPosition, child) {
                  return MyDropdownMenu(
                    positions: const [
                      'Admin',
                      'User',
                      'Vendor'
                    ], // List of dropdown options
                    selectedPosition:
                        selectedPosition, // Current selected value
                    onChanged: (String? newValue) {
                      selectedPositionNotifier.value =
                          newValue; // Update dropdown value
                    },
                  );
                },
              ),
              const SizedBox(height: 10),

              //username
              MyTextfield(
                hintText: "Email",
                obscureText: false,
                controller: emailController,
              ),

              const SizedBox(height: 10),

              //password
              MyPasswordtextfield(
                hintText: "Password",
                obscureText: true,
                controller: passwordController,
              ),
              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Forgot Password?",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              //login button
              MyButton(text: "Login", onTap: login),

              const SizedBox(height: 5),

              //Dont have account
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Dont have account?",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      "Register Here!",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
