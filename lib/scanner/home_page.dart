// import 'package:login_qr/qr_scanner.dart';
import 'package:flutter/material.dart';
import 'qrscanner.dart';

void main() {
  runApp(const HomePage());
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      )),
      home: const QRScanner(),
      debugShowCheckedModeBanner: false,
      title: 'QR Scanner',
    );
  }
}
