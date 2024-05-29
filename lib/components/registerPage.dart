import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'my_email.dart';
import 'my_password.dart';
import 'button.dart';
import '../details/userIcNum.dart';
import '../details/userName.dart';
import '../details/userPlateNum.dart';
import 'package:login_qr/loginpage.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final icController = TextEditingController();
  final nameController = TextEditingController();
  final plateController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool seccurePass = true;

  @override
        // ignore: unused_element
        void dispose(){
          emailController.dispose();
          icController.dispose();
          nameController.dispose();
          plateController.dispose();
          super.dispose();
        }

 void signUserUp() async {
  showDialog(
    context: context,
    builder: (context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    },
  );

    Future<void> addUser(String email, String fullName, String icNum, String pNum) async {
    try {
      // Reference to the 'Qr_Check_in' collection
      CollectionReference mainCollection = FirebaseFirestore.instance.collection('Qr_Check_in');

      // Add a new document to the 'Qr_Check_in' collection
      await mainCollection.add({
        'email': email,
        'full name': fullName,
        'IC Number': icNum,
        'Plate Number': pNum,
      });

      print('User added successfully');
    } catch (e) {
      print('Error adding user: $e');
    }
  }

          addUser(
            emailController.text.trim(),
            nameController.text.trim(), 
            icController.text.trim(),
            plateController.text.trim(),
          );

  try {
    if (passwordController.text == confirmPasswordController.text) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      Navigator.pop(context); // Dismiss the loading dialog
      // Show success message
      showSuccessMessage("Account created successfully!");
      // Navigate to login page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage(onTap: widget.onTap)),
      );
    } else {
      Navigator.pop(context); // Dismiss the loading dialog
      showErrorMessage("Passwords do not match");
    }
  } on FirebaseAuthException catch (e) {
    Navigator.pop(context); // Dismiss the loading dialog
    if (e.code == 'weak-password') {
      showErrorMessage('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      showErrorMessage('The account already exists for that email.');
    }
  }
}
  
      
void showSuccessMessage(String message) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text(
          "Success",
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'OK',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      );
    },
  );
}
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            
            children: [
               const SizedBox(height: 50,),
          
               Text(
                "Please Create an Account and Enter Your Details",
                style: TextStyle(color: Colors.grey[700],
                fontSize: 16,
                fontWeight: FontWeight.bold,
                ),
               ),
          
               const SizedBox(height: 30,),
          
            Email(
              controller: emailController,
              hintText: 'Email',
              obscureText: false,
            ),
             const SizedBox(height: 30,),
             
             userName(
              controller: nameController,
              hintText: 'Full Name',
              obscureText: false,
              textCapitalization: TextCapitalization.characters,
            ),
          
            const SizedBox(height: 20,),

            userIc(
              controller: icController,
              hintText: 'IC Number Without ( - )',
              obscureText: false,
            ),
          
            const SizedBox(height: 20,),
            
            userPlate(
              controller: plateController,
              hintText: 'Vehicle Plate ',
              obscureText: false,
              textCapitalization: TextCapitalization.characters,

            ),
          
            const SizedBox(height: 20,),
  
            Password(
              controller: passwordController,
              hintText: 'Password',
              obscureText: seccurePass,
              suffixIcon : togglePassword(),
            ),
            
            const SizedBox(height: 20,),
            
            Password(
              controller: confirmPasswordController,
              hintText: 'Confirm Password',
              obscureText: seccurePass,
              suffixIcon : togglePassword(),
            ),
          
          const SizedBox(height: 20,),
          
          const SizedBox(height: 20,),
          
          Button( 
            text: 'Sign Up',  // This is sign in Button
            onTap: signUserUp,
          ),
          
          
          const SizedBox(height: 20,),
          
           Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already Have an Account?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Login Now',
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
        )
      )
    );
  }
  
  void showErrorMessage(String message) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text(
          "Error",
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'OK',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      );
    },
  );
}
 Widget togglePassword(){
      return IconButton(
        onPressed: (){
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
