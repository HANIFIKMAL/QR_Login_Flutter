import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class userIc extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  const userIc({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    });

  @override
  Widget build(BuildContext context) {
    return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: TextField(
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
               ],
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
          ),
          );
  }
}