import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'dart:html';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'signup.dart';
import 'send.dart';
import'Load.dart';






class _Load extends State<Load> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Center(
            child: Text(
          'Load Cowries',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 30, color: Colors.white),
        )),
      ),
      body: Center(
        child: Column(children: [
          ElevatedButton(
            child: const Text('Open route'),
            onPressed: () {
              Navigator.pop(
                context,
                MaterialPageRoute(builder: (context) => const Home()),
              );
            },
          ),
        ]),
      ),
    );
  }
}


class Home extends StatefulWidget {
  const Home({this.uid, super.key});
  final String? uid;
  final title = "Cowrie Cash";

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  int _counter = 0;
  int Balance = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  void _buttonTest() {}

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(
            widget.title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 30, color: Colors.white),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: () {
              FirebaseAuth auth = FirebaseAuth.instance;
              auth.signOut().then((res) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => SignUp()),
                    (Route<dynamic> route) => false);
              });
            },
          )),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
                child: Column(
              children: [
                Container(
                    margin: const EdgeInsets.only(top: 20),
                    height: 150,
                    child: FractionallySizedBox(
                        heightFactor: 0.6,
                        alignment: FractionalOffset.center,
                        child: AspectRatio(
                            aspectRatio: 1 / 1,
                            child: Placeholder(
                              color: Colors.tealAccent,
                            )))),
                Container(
                    margin: const EdgeInsets.only(top: 10),
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          size: 30,
                          Icons.account_balance_wallet_outlined,
                          color: Colors.cyan,
                        ),
                        Text(
                          "Balance: " + (Balance / 100).toStringAsFixed(2),
                          textAlign: TextAlign.center,
                          style:
                              const TextStyle(fontSize: 30, color: Colors.cyan),
                        )
                      ],
                    )),
              ],
            )),
            Container(
                margin: const EdgeInsets.all(10),
                height: 150,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        margin: EdgeInsets.only(top: 20, left: 10, right: 10),
                        child: AspectRatio(
                            aspectRatio: 5 / 4,
                            child: ElevatedButton(
                                onPressed: () {
                                  window.navigator.getUserMedia(video: true);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Send()),
                                  );
                                },
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        size: 50,
                                        Icons.camera_alt_outlined,
                                        color: Colors.white,
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(top: 10)),
                                      const Text(
                                        'Send',
                                        style: const TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      )
                                    ])))),
                    Container(
                        margin: EdgeInsets.only(top: 20, left: 10, right: 10),
                        child: AspectRatio(
                            aspectRatio: 5 / 4,
                            child: ElevatedButton(
                                onPressed: _buttonTest ,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        size: 50,
                                        Icons.qr_code_2_rounded,
                                        color: Colors.white,
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(top: 10)),
                                      const Text(
                                        'Receive',
                                        style: const TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      )
                                    ])))),
                  ],
                )),
            Container(
                margin: const EdgeInsets.all(10),
                height: 150,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        margin: EdgeInsets.only(top: 20, left: 10, right: 10),
                        child: AspectRatio(
                            aspectRatio: 5 / 4,
                            child: ElevatedButton(
                                onPressed: () {
                                  window.navigator.getUserMedia(video: true);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Load()),
                                  );
                                },
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        size: 50,
                                        Icons.account_balance_outlined,
                                        color: Colors.white,
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(top: 10)),
                                      const Text(
                                        'Load',
                                        style: const TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      )
                                    ])))),
                    Container(
                        margin: EdgeInsets.only(top: 20, left: 10, right: 10),
                        child: AspectRatio(
                            aspectRatio: 5 / 4,
                            child: ElevatedButton(
                                onPressed: _buttonTest,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        size: 50,
                                        Icons.account_box_outlined,
                                        color: Colors.white,
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(top: 10)),
                                      const Text(
                                        'Account',
                                        style: const TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      )
                                    ])))),
                  ],
                )),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
