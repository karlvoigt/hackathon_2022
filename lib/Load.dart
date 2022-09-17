import 'package:flutter/material.dart';
import 'home.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'main.dart';
import 'send.dart';

class Load extends StatefulWidget {
  const Load({super.key});

  @override
  State<Load> createState() => _Load();
}

class _Load extends State<Load> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(
            'Load Cowries',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 30, color: Colors.white),
          ),
        ),
        body: Center(
          child: Column(children: [
            Padding(padding: EdgeInsets.all(30)),
            Text(
              "Enter voucher code!",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 30, color: Colors.cyan),
            ),
            Padding(padding: EdgeInsets.all(30)),
            SizedBox(
                width: 200,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: '',
                    border: OutlineInputBorder(),
                  ),
                  onSubmitted: (String value) async {
                    final ref = FirebaseDatabase.instance.ref();
                    final uid = FirebaseAuth.instance.currentUser?.uid;

                    if (uid == null) {
                      return;
                    }

                    ref
                        .child('Identifier/$uid/balance')
                        .get()
                        .then((currBalance) => {
                              if (currBalance.exists)
                                {
                                  setState(() {
                                    int myBal =
                                        int.parse(currBalance.value.toString());
                                    int amount = 0;
                                    switch (value) {
                                      case '1234':
                                        amount = 5000;
                                        break;
                                      case '12345':
                                        amount = 10000;
                                        break;
                                      case '123456789':
                                        amount = 50000;
                                        break;
                                      default:
                                        amount = 0;
                                        break;
                                    }
                                    ;
                                    myBal += amount;
                                    ref
                                        .child('Identifier/$uid/balance')
                                        .set(myBal);
                                  })
                                }
                              else
                                {print('No data available.')}
                            });

                    Navigator.pop(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                    );
                  },
                )),
          ]),
        ));
  }
}
