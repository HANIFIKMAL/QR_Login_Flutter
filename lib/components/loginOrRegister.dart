// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:login_qr/components/registerPage.dart';
import 'package:login_qr/loginpage.dart';
// import '../details/details.dart';

class loginRegister extends StatefulWidget {
   // ignore: prefer_const_constructors_in_immutables
  loginRegister({super.key});

  @override
  State<loginRegister> createState() => _loginRegisterState();
}

class _loginRegisterState extends State<loginRegister>
{
  bool showLoginPage = true;

  void togglePages(){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context){
    if (showLoginPage){
      return LoginPage(
        onTap: togglePages,
      );
    }
    else{
      return RegisterPage(onTap: togglePages,);
    }
  }
}