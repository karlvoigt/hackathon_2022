import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class Send extends StatefulWidget {
  const Send({super.key});

  @override
  State<Send> createState() => _Send();
}

class _Send extends State<Send> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(
          'Send Cowries',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 30, color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(children: [
          Container(
              child: MobileScanner(
                  allowDuplicates: false,
                  onDetect: (barcode, args) {
                    if (barcode.rawValue == null) {
                      debugPrint('Failed to scan Barcode');
                    } else {
                      final String code = barcode.rawValue!;
                      debugPrint('Barcode found! $code');
                    }
                  })),
        ]),
      ),
    );
  }
}