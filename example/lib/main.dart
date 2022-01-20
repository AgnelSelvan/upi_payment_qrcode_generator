import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:upi_payment_qrcode_generator/upi_payment_qrcode_generator.dart';

void main() {
  runApp(MyApp());
}

/// Creates The UPI Payment QRCode
class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final upiDetails = UPIDetails(upiID: "UPI ID Here eg. 73641234@paytm", payeeName: "Payee Name Here", amount: 1, transactionNote: "Hello World");
  final upiDetailsWithoutAmount = UPIDetails(upiID: "UPI ID Here eg. 73641234@paytm", payeeName: "Payee Name Here", transactionNote: "Hello World");

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('UPI Payment QRCode Generator'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("UPI Payment QRCode without Amount", style: TextStyle(fontWeight: FontWeight.bold)),
              UPIPaymentQRCode(upiDetails: upiDetailsWithoutAmount, size: 200,),
              Text("Scan QR to Pay", style: TextStyle(color: Colors.grey[600], letterSpacing: 1.2), ),
              const SizedBox(height: 20,),
              const Text("UPI Payment QRCode with Amount", style: TextStyle(fontWeight: FontWeight.bold)),
              UPIPaymentQRCode(upiDetails: upiDetails, size: 200,),
              Text("Scan QR to Pay", style: TextStyle(color: Colors.grey[600], letterSpacing: 1.2), )
            ],
          ),
        ),
      ),
    );
  }
}
