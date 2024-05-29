import 'package:flutter/material.dart';

class userPlate extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final TextCapitalization textCapitalization;

  const userPlate({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.textCapitalization,
    });

  @override
  Widget build(BuildContext context) {
    return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  
              ),
              fillColor: Colors.grey.shade200,
                  filled:true,
                  hintText: hintText,
                  hintStyle: TextStyle(color: Colors.grey[600]),
             ),
             textCapitalization: textCapitalization,
          ),
          );
  }
}