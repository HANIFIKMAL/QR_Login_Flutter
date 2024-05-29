import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:login_qr/components/loginOrRegister.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'result.dart';
import 'package:qr_scanner_overlay/qr_scanner_overlay.dart';
import 'package:firebase_auth/firebase_auth.dart';


//ignore: must_be_immutable
class QRScanner extends StatefulWidget {
   const QRScanner({super.key});
 
  @override
  State<QRScanner> createState() => _QRScannerState();

  void signOut(){
    FirebaseAuth.instance.signOut();
  }
}

class _QRScannerState extends State<QRScanner> {
  bool isScanCompleted = false;
  bool isFlashOn = false;
  bool isCamera = false;
  MobileScannerController controller = MobileScannerController();
  final String link = "https://forms.gle/Euxbnwu6njLCSbgp8";

  void closeScreen() {
    setState(() {
      isScanCompleted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: (){
            setState(() {
              isFlashOn = !isFlashOn;
            });
            
            controller.toggleTorch();
          }, 
          icon: Icon(Icons.flash_on, color:isFlashOn ? Colors.blue: Colors.black)),
          IconButton(onPressed: (){
            setState(() {
              isCamera = !isCamera;
            });
            
            controller.switchCamera();
            }, 
            icon: Icon(Icons.camera_front, color:isCamera ? Colors.blue: Colors.black)),
        ],
        iconTheme: const IconThemeData(color: Colors.black87),
        centerTitle: true,
        title: const Text(
          "QR SCANNER",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ),
      body: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Place the QR code in the area",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Scanning are done automatically",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: Stack(children: [
                  MobileScanner(
                    controller: controller,
                    allowDuplicates: false,
                      onDetect: (barcode, args) async {
                          if(!isScanCompleted)
                          {
                            String code = barcode.rawValue ?? '---';
                            if (code == link) {
                            setState(() {
                              isScanCompleted = true;
                            });
                              Object userId = await getCurrentUserId();
                              // ignore: unnecessary_null_comparison
                              if (userId != null) {
                                recordCheckInTime(context, userId.toString());
                              } else {
                                showSnackbar(context, 'User not authenticated');
                              }
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ResultScreen
                              (closeScreen: closeScreen,
                              code: code,)
                              )
                            );
                          }else{
                            showSnackbar(context, 'Scanned QR code is not recognized');
                          }
                        }
                      }
                  ),
                 QRScannerOverlay(overlayColor : Colors.grey[300]),
                ],)
              ),
              Expanded(
                  child: Container(
                      alignment: Alignment.center,
                      child: const Text(
                        "Develop by Hanifr ",
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                          letterSpacing: 1,
                        ),
                      )))
            ],
          )),
    );
  }

  Future<Object> getCurrentUserId() async {
    // Get the current user from Firebase Authentication
    User? user = FirebaseAuth.instance.currentUser;
    
    if (user != null) {
      // User is signed in
      return user.uid; // Return the user's ID
    } else {
      // No user is signed in
      return loginRegister();
    }
  }

void recordCheckInTime(BuildContext context, String userId) async {
  String? email = FirebaseAuth.instance.currentUser?.email;

  if (email == null) {
    showSnackbar(context, 'User email is not available');
    return;
  }

  try {
    // Reference to the main collection
    // Reference to the 'Qr_Check_in' collection
    CollectionReference mainCollection = FirebaseFirestore.instance.collection('Qr_Check_in');

    // Query the collection for the document with the matching email
    QuerySnapshot querySnapshot = await mainCollection.where('email', isEqualTo: email).limit(1).get();


      if (querySnapshot.docs.isNotEmpty) {
        // User document found
        DocumentSnapshot userDocSnapshot = querySnapshot.docs.first;

        // Append the new check-in time to the 'checkInTimes' array field
       await userDocSnapshot.reference.update({
        'checkInTimes': FieldValue.arrayUnion([DateTime.now().toString()]),
      });

    }
  } catch (e) {
    print('Error recording check-in: $e');
    showSnackbar(context, 'Error recording check-in: $e');
  }
}

void showSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 3), // Adjust as needed
    ),
  );
}


}

