import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const InputBarcodePage(),
    );
  }
}

class InputBarcodePage extends StatefulWidget {
  const InputBarcodePage({Key? key}) : super(key: key);

  @override
  _InputBarcodePageState createState() => _InputBarcodePageState();
}

class _InputBarcodePageState extends State<InputBarcodePage> {
  String _barcodeText = "Unknown";

  Future<void> _getBarcodeData() async {
    try {
      String code = await FlutterBarcodeScanner.scanBarcode(
          "##6666", "キャンセル", false, ScanMode.BARCODE);

      if (!mounted) return;

      setState(() {
        _barcodeText = code;
      });
    } on PlatformException {
      setState(() {
        _barcodeText = "カメラ機能が許可されていないためスキャンできません";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          //mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _barcodeText,
              style: const TextStyle(fontSize: 30),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: _getBarcodeData,
              child: const Text(
                "スキャン",
                style: TextStyle(fontSize: 20),
              ),
            )
          ],
        ),
      ),
    );
  }
}
