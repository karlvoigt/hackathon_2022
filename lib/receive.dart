import 'package:qr/qr.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'main.dart';

class Receive extends StatefulWidget {
  const Receive({super.key});

  @override
  State<Receive> createState() => _Receive();
}

class _Receive extends State<Receive> {
  String uid = '';

  @override
  void initState() {
    super.initState();
    final ref = FirebaseDatabase.instance.ref();
    var tuid = FirebaseAuth.instance.currentUser?.uid;
    if (tuid == Null) {
      Navigator.pop(
        context,
        MaterialPageRoute(builder: (context) => MyApp()),
      );
    }
    final snapshot =
        ref.child('Identifier/$tuid/name').get().then((snapshot) => {
              if (snapshot.exists)
                {
                  setState(() {
                    uid = tuid!;
                  })
                }
              else
                {print('No data available.')}
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(
          'Receive Cowries',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 30, color: Colors.white),
        ),
      ),
      body: Center(
        child: QrImage(
          data: uid,
          version: QrVersions.auto,
          size: 400.0,
        ),
      ),
    );
  }
}
