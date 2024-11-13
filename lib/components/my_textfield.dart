import 'package:flutter/material.dart';

class MyTextfield extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;

  const MyTextfield(
      {super.key,
      required this.hintText,
      required this.obscureText,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      cursorColor: Colors.grey,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.shade200,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.grey[600]!,
            width: 1.5,
          ),
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey[500],
        ),
        prefixIcon: Icon(
          Icons.person,
          color: Colors.grey[600],
        ),
      ),
      obscureText: obscureText,
    );
  }
}
