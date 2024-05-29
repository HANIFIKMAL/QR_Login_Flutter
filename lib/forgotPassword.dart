import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_qr/components/button.dart';
import 'package:login_qr/components/my_email.dart';
// import 'package:login_qr/components/my_password.dart';
// import 'package:login_qr/details/update.dart';

class ForgotPass extends StatefulWidget {
  const ForgotPass({super.key});

  @override
  State<ForgotPass> createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {

  final emailController = TextEditingController();

  @override
  void dispose(){
    emailController.dispose();
    super.dispose();
  }

  Future resetPass() async{
    try{
      await FirebaseAuth.instance
    .sendPasswordResetEmail(email: emailController.text.trim());
    showDialog(
        // ignore: use_build_context_synchronously
        context: context, 
        builder: (context){
        return const AlertDialog(
          content: Text("Your Password Reset Link Has been Sent to your email",
          style: TextStyle(color: Colors.black,
                fontSize: 16,),
          ),
        );
      });
    }
    on FirebaseAuthException catch (e){
      showDialog(
        // ignore: use_build_context_synchronously
        context: context, 
        builder: (context){
        return AlertDialog(
          content: Text(e.message.toString()),
        );
      });
    }

  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
      ),
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            
            children: [
              const SizedBox(height: 10,),
          
              const Icon(
                Icons.change_circle_outlined,
                size:100,
               ),
          
               const SizedBox(height: 15,),
          
               Text(
                "Change Password",
                style: TextStyle(color: Colors.grey[700],
                fontSize: 16,
                fontWeight: FontWeight.bold,
                ),
               ),
          
               const SizedBox(height: 15,),
          
               Text(
                "Put in Your Email to reset your Password",
                style: TextStyle(color: Colors.grey[700],
                fontSize: 16,
                fontWeight: FontWeight.bold,
                ),
               ),

              const SizedBox(height: 30,),
            
              Email(
              controller: emailController,
              hintText: 'Your email',
              obscureText: false,
            ),

              const SizedBox(height: 20,),
          Button(
            text: 'Reset Password', // This is reset password Button
            onTap: resetPass,
            )
            ],
          ),
        )
      )
    );
  }
  

  }
  
