import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_qr/scanner/qrscanner.dart';
import 'package:url_launcher/url_launcher.dart';

class updateQr extends StatefulWidget {
  const updateQr({super.key});

  @override
  State<updateQr> createState() => _updateQrState();
}

void signOut() {
  FirebaseAuth.instance.signOut();
}

void _showSignOutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop(); // Dismiss the dialog
            },
          ),
          TextButton(
            child: const Text('Sign Out'),
            onPressed: () {
              Navigator.of(context).pop(); // Dismiss the dialog
              signOut(); // Perform sign-out operation
            },
          ),
        ],
      );
    },
  );
}

class _updateQrState extends State<updateQr> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              _showSignOutDialog(context);
            },
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            _showSignOutDialog(context);
          },
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.6,
              child: Center(
                child: SizedBox(
                  width: 400,
                  height: 400,
                  child: Image.asset(
                    'lib/images/google.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  const Icon(
                    Icons.lock_clock,
                    size: 100,
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "WELCOME TO UiTM CHECK IN SYSTEM",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const QRScanner()),
                      );
                    },
                    icon: const Icon(Icons.qr_code),
                    label: const Text('QR SCANNER'),
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          side: const BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextButton.icon(
                    onPressed: () async {
                      var url = Uri.parse('https://forms.gle/J2GeUKo9Sb9D2naj8');
                      print('Attempting to launch URL: $url');
                      if (await canLaunchUrl(url)) {
                        print('URL can be launched');
                        await launchUrl(url);
                        print('URL launched successfully');
                      } else {
                        print('Could not launch URL: $url');
                        throw 'Could not launch $url';
                      }
                    },
                    icon: const Icon(Icons.update),
                    label: const Text('KEMASKINI NOMBOR KENDERAAN'),
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          side: const BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
