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
                    final uid = await FirebaseAuth.instance.currentUser?.uid;
                    if (uid == Null) {
                      Navigator.pop(
                        context,
                        MaterialPageRoute(builder: (context) => MyApp()),
                      );
                    }
                    print(uid);
                    final snapshot = ref
                        .child('Identifier/$uid/balance')
                        .get()
                        .then((snapshot) => {
                              if (snapshot.exists)
                                {
                                  setState(() {
                                    int Balance =
                                        int.parse(snapshot.value.toString());
                                    print(Balance);
                                    Balance += 500;
                                    ref
                                        .child('Identifier/$uid/balance')
                                        .set(Balance);
                                  })
                                }
                              else
                                {print('No data available.')}
                            });

                    // final uid = FirebaseAuth.instance.currentUser?.uid;
                    // if (uid == null) {
                    //   // TODO display error
                    // } ;
                    // final ref = FirebaseDatabase.instance.ref();
                    // final currentBalance = ref
                    //     .child('Identifier/$uid/balance')
                    //     .get()
                    //     .then((balance) => {
                    //   if (balance.exists)
                    //     {
                    //       setState(() {
                    //         int myBal = int.parse(balance.value.toString());
                    //         final snapshot = ref
                    //             .child('$value/value')
                    //             .get()
                    //             .then((snapshot) => {
                    //           if (snapshot.exists)
                    //             {
                    //               setState(() {
                    //                 int amount = int.parse(
                    //                     snapshot.value.toString());
                    //                 myBal += amount;
                    //                 print(myBal);
                    //                 ref
                    //                     .child(
                    //                     '$value/value')
                    //                     .set("0");
                    //                 ref
                    //                     .child(
                    //                     'Identifier/$uid/balance')
                    //                     .set(myBal);
                    //               })
                    //             }
                    //           else
                    //             {print('No data available.')}
                    //         });
                    //       })
                    //     }
                    // });

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
