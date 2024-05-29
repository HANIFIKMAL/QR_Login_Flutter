import 'package:flutter/material.dart';

class Password extends StatelessWidget {
  final TextEditingController controller; // Specify the type of controller
  final String hintText;
  final bool obscureText;
  final Widget suffixIcon;

  const Password({
    super.key, // Correct the key parameter
    required this.controller,
    required this.hintText,
    required this.obscureText, 
    required this.suffixIcon,
  }); // Pass the key parameter to super

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText, // Apply the obscureText property
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[600]),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
