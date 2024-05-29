import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login_qr/components/button.dart';
import 'userPlateNum.dart';

// ignore: camel_case_types
class details extends StatefulWidget {
  const details({Key? key}) : super(key: key);

  @override
  State<details> createState() => _detailsState();
}

// ignore: camel_case_types
class _detailsState extends State<details> {
  final plateController = TextEditingController();

  @override
  void dispose() {
    plateController.dispose();
    super.dispose();
  }

  Future<void> updateUser(String pNum) async {
    String? email = FirebaseAuth.instance.currentUser?.email;

    try {
      // Reference to the main collection
      CollectionReference mainCollection = FirebaseFirestore.instance.collection('Qr_Check_in');

      // Get all documents in the main collection
      QuerySnapshot querySnapshot = await mainCollection.where('email', isEqualTo: email).limit(1).get();


         if (querySnapshot.docs.isNotEmpty) {
      // Get the first document
      DocumentSnapshot userDocSnapshot = querySnapshot.docs.first;

      // Update the document in the 'Qr_Check_in' collection
      await userDocSnapshot.reference.update({
        'Plate Number': pNum,
      });

      print('Update Success');
      showSnackbar(context, 'Plate number updated successfully');
      Navigator.pop(context);
    } else {
      // No matching document found
      showSnackbar(context, 'No matching document found');
    }
      } catch (e) {
    // Error occurred
    print('Error updating document: $e');
    showSnackbar(context, 'Error updating plate number');
  }
}

  void Update() {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    updateUser(plateController.text.trim());
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

  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3), // Adjust as needed
      ),
    );
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
              const SizedBox(height: 10),
              const Icon(
                Icons.update,
                size: 100,
              ),
              const SizedBox(height: 15),
              Text(
                "Update Vehicle Plate Number",
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              userPlate(
                controller: plateController,
                hintText: 'Enter Your Vehicle Plate Number',
                obscureText: false,
                textCapitalization: TextCapitalization.characters,
              ),
              const SizedBox(height: 20),
              Button(
                text: 'Update', // This is update in Button
                onTap: Update,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
