// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_qr/components/auth_page.dart';
import 'package:login_qr/forgotPassword.dart';
import 'components/my_email.dart';
import 'components/my_password.dart';
import 'components/button.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool showLoginPage = true;
  bool seccurePass = true;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  Future signIn() async {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      final user = credential.user;
      if (user != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AuthPage()),
        );
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      String message = 'An error occurred';
      if (e.code == 'invalid-email') {
        message = 'Incorrect Email';
      } else if (e.code == 'wrong-password') {
        message = 'Incorrect Password';
      } else if (e.code == 'user-not-found') {
        message = 'User not found';
      }
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(message, style: TextStyle(color: Colors.black)),
          );
        },
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.6,
            child: Center(
                child: SizedBox(
                  width: 400, // Set the desired width
                  height: 400, // Set the desired height
                  child: Image.asset(
                    'lib/images/google.png',
                    fit: BoxFit.contain,
                  ),
                ),
            ),
          ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  const Icon(
                    Icons.lock,
                    size: 100,
                  ),
                  const SizedBox(height: 40),
                  Text(
                    "Please Log In",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Email(
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false,
                  ),
                  const SizedBox(height: 20),
                  Password(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: seccurePass,
                    suffixIcon: togglePassword(),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const ForgotPass();
                                },
                              ),
                            );
                          },
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Button(
                    text: 'Log In',
                    onTap: signIn,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Not a member?',
                        style: TextStyle(color: Colors.black),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          'Register Now',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget togglePassword() {
    return IconButton(
      onPressed: () {
        setState(() {
          seccurePass = !seccurePass;
        });
      },
      icon: Icon(
        seccurePass ? Icons.visibility : Icons.visibility_off,
      ),
      color: Colors.grey,
    );
  }
}
