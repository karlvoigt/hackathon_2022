import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hackathon_2022/main.dart';
import 'firebase_options.dart';
import 'dart:html';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:wave/wave.dart';
import 'package:wave/config.dart';
import 'dart:math' as math;

import 'signup.dart';
import 'send.dart';
import 'Load.dart';
import 'receive.dart';
import 'voucherGenerator.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  final title = "Cowrie Cash";
  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  int _counter = 0;
  int _balance = 0;

  @override
  void initState() {
    super.initState();
    final ref = FirebaseDatabase.instance.ref();
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == Null) {
      Navigator.pop(
        context,
        MaterialPageRoute(builder: (context) => MyApp()),
      );
    }
    final snapshot =
        ref.child('Identifier/$uid/balance').get().then((snapshot) => {
              if (snapshot.exists)
                {
                  setState(() {
                    _balance = int.parse(snapshot.value.toString());
                  })
                }
              else
                {print('No data available.')}
            });
  }

  @override
  void updateBalance() {
    final ref = FirebaseDatabase.instance.ref();
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == Null) {
      Navigator.pop(
        context,
        MaterialPageRoute(builder: (context) => MyApp()),
      );
    }
    final snapshot =
        ref.child('Identifier/$uid/balance').get().then((snapshot) => {
              if (snapshot.exists)
                {
                  setState(() {
                    _balance = int.parse(snapshot.value.toString());
                  })
                }
              else
                {print('No data available.')}
            });
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      updateBalance();
    });
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: Color.fromARGB(100, 255, 183, 77),
      appBar: AppBar(
          backgroundColor: Colors.cyan,
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
      body: Stack(children: <Widget>[
        FractionallySizedBox(
          heightFactor: 0.35,
          alignment: FractionalOffset.topCenter,
          child: Transform.rotate(
            angle: -math.pi,
            child: Card(
              child: WaveWidget(
                //user Stack() widget to overlap content and waves
                config: CustomConfig(
                  colors: [
                    Colors.cyan.withOpacity(0.3),
                    Colors.tealAccent.withOpacity(0.3),
                    Colors.lightBlueAccent.withOpacity(0.3),
                    //the more colors here, the more wave will be
                  ],
                  durations: [4000, 5000, 7000],
                  //durations of animations for each colors,
                  // make numbers equal to numbers of colors
                  heightPercentages: [0.02, 0.05, 0.03],
                  //height percentage for each colors.
                  blur: MaskFilter.blur(BlurStyle.solid, 20),
                  //blur intensity for waves
                ),
                waveAmplitude: 5.00, //depth of curves
                waveFrequency: 5, //number of curves in waves
                backgroundColor:
                    Color.fromARGB(100, 255, 183, 77), //background colors
                // heightPercentage: 0.7,
                size: Size(
                  double.infinity,
                  double.infinity,
                ),
              ),
            ),
          ),
        ),
        Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                  child: Column(
                children: [
                  Container(
                      margin: const EdgeInsets.only(top: 10),
                      height: 150,
                      child: FractionallySizedBox(
                          heightFactor: 0.7,
                          alignment: FractionalOffset.center,
                          child: AspectRatio(
                              aspectRatio: 1 / 1,
                              child: Image.asset('CowrieCoin.png')))),
                  Container(
                      margin: const EdgeInsets.only(top: 5),
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            size: 30,
                            Icons.account_balance_wallet_outlined,
                            color: Colors.white,
                          ),
                          Text(
                            " Balance: R" + (_balance / 100).toStringAsFixed(2),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 30, color: Colors.white),
                          )
                        ],
                      )),
                ],
              )),
              Container(
                  margin: const EdgeInsets.all(30),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                              fontSize: 20,
                                              color: Colors.white),
                                        )
                                      ])))),
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
                                          builder: (context) =>
                                              const Receive()),
                                    );
                                  },
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                              fontSize: 20,
                                              color: Colors.white),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          size: 50,
                                          Icons.account_balance_outlined,
                                          color: Colors.white,
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(top: 10)),
                                        const Text(
                                          'Load Voucher',
                                          style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.white),
                                        )
                                      ])))),
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
                                          builder: (context) => const Create()),
                                    );
                                  },
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          size: 50,
                                          Icons.add_card_outlined,
                                          color: Colors.white,
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(top: 10)),
                                        const Text(
                                          'Create Voucher',
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.white),
                                        )
                                      ])))),
                    ],
                  )),
            ],
          ),
        ),
      ]), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
