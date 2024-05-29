// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:login_qr/components/loginOrRegister.dart';
// ignore: unused_import
import 'package:login_qr/components/updateOrQr.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options:  DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Login());
}

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          appBarTheme:  AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      )),
      home:  loginRegister(),
      debugShowCheckedModeBanner: false,
      title: 'QR Scanner',
    );
  }
}
