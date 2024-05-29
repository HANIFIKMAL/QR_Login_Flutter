// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_qr/components/loginOrRegister.dart';
// ignore: unused_import
import '/loginpage.dart'; // Import your LoginPage widget
import 'package:login_qr/components/updateOrqr.dart'; // Import your UpdateQR widget

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
          // Check if the user is logged in
          if (snapshot.hasData) {
            // Navigate to UpdateQR page
            return updateQr();
          } else {
            // Navigate to LoginPage
            return loginRegister();
        }
      },
    );
  }
}
