// import 'package:login_qr/qrscanner.dart';
import 'package:flutter/material.dart';
import 'package:login_qr/components/button.dart';
import 'package:login_qr/components/updateOrQr.dart';
import 'package:qr_flutter/qr_flutter.dart';

void Back(BuildContext context){

    Navigator.push(
      context,
          MaterialPageRoute(builder: (context) => const updateQr()), // Navigate to the updateQr screen
    );
 }

class ResultScreen extends StatelessWidget {
  final String code;
  final Function() closeScreen;
  final String link = "https://forms.gle/Euxbnwu6njLCSbgp8";

  const ResultScreen(
      {super.key, required this.closeScreen, required this.code});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              closeScreen();
              Navigator.pop(context);
            },
            icon:
                const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black87)),
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
        alignment: Alignment.center,
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            QrImageView(
              data: code,
              size: 150,
              version: QrVersions.auto,
            ),
           
            const Text(
              "Scanned Is Successful",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black45,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
             Button(
              text: 'Back',
              onTap: () {
                Back(context);
              },
            )      
          ],
        ),
      ),
    );
  }
}