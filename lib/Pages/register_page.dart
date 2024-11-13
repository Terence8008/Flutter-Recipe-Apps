import 'package:cook_n_go/components/my_button.dart';
import 'package:cook_n_go/components/my_comfirmpstextfield.dart';
import 'package:cook_n_go/components/my_emailtextfield.dart';
import 'package:cook_n_go/components/my_passwordtextfield.dart';
import 'package:cook_n_go/components/my_textfield.dart';
import 'package:cook_n_go/components/dropdown_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cook_n_go/providers/auth_provider.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();
  final ValueNotifier<String?> selectedPositionNotifier = ValueNotifier<String?>(null);

  bool _isLoading = false;
  String? _errorMessage;

  void _register() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    if (passwordController.text != confirmController.text) {
      setState(() {
        _isLoading = false;
        _errorMessage = "Passwords do not match!";
      });
      return;
    }

    final isSuccess = await authProvider.signUp(
      emailController.text.trim(),
      passwordController.text.trim(),
      selectedPositionNotifier.value ?? '',
      usernameController.text.trim(),
    );

    setState(() {
      _isLoading = false;
      if (!isSuccess) _errorMessage = "Registration failed. Please try again.";
    });

    if (isSuccess) Navigator.pop(context); // Close on success
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register Page"),
        centerTitle: true,
        backgroundColor: Colors.red[600],
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'asset/logoCleared.jpg',
                    width: 150,
                    height: 150,
                  ),
                  const SizedBox(width: 20),
                  const Text(
                    "Register",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Dropdown for position selection
              ValueListenableBuilder<String?>(
                valueListenable: selectedPositionNotifier,
                builder: (context, selectedPosition, child) {
                  return MyDropdownMenu(
                    positions: const ['Admin', 'User', 'Vendor'],
                    selectedPosition: selectedPosition,
                    onChanged: (String? newValue) {
                      selectedPositionNotifier.value = newValue;
                    },
                  );
                },
              ),
              const SizedBox(height: 10),

              // Username
              MyTextfield(
                hintText: "Username",
                obscureText: false,
                controller: usernameController,
              ),
              const SizedBox(height: 10),

              // Email
              MyEmailtextfield(
                hintText: "Email",
                obscureText: false,
                controller: emailController,
              ),
              const SizedBox(height: 10),

              // Password
              MyPasswordtextfield(
                hintText: "New Password",
                obscureText: true,
                controller: passwordController,
              ),
              const SizedBox(height: 10),

              // Confirm Password
              MyComfirmpwtextfield(
                hintText: "Confirm Password",
                obscureText: false,
                controller: confirmController,
              ),

              const SizedBox(height: 25),

              // Display error message if any
              if (_errorMessage != null)
                Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red, fontSize: 14),
                ),
              
              const SizedBox(height: 10),

              // Register Button
              MyButton(
                text: _isLoading ? "Registering..." : "Register",
                onTap: _isLoading ? null : _register,
              ),

              const SizedBox(height: 5),

              // Already have an account
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      "Login Here!",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}