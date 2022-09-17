import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'firebase_options.dart';
import 'Sync.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'signup.dart';


// class Home extends StatelessWidget {
//   Home({this.uid});
//   final String? uid;
//   final String title = "Home";
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text(title),
//           actions: <Widget>[
//             IconButton(
//               icon: Icon(
//                 Icons.exit_to_app,
//                 color: Colors.white,
//               ),
//               onPressed: () {
//                 FirebaseAuth auth = FirebaseAuth.instance;
//                 auth.signOut().then((res) {
//                   Navigator.pushAndRemoveUntil(
//                       context,
//                       MaterialPageRoute(builder: (context) => SignUp()),
//                           (Route<dynamic> route) => false);
//                 });
//               },
//             )
//           ],
//         ),
//         body: Center(child: Text('Welcome!')),
//         drawer: NavigateDrawer(uid: this.uid));
//   }
// }
//
// class NavigateDrawer extends StatefulWidget {
//   final String? uid;
//   NavigateDrawer({Key? key, this.uid}) : super(key: key);
//   @override
//   _NavigateDrawerState createState() => _NavigateDrawerState();
// }
//
// class _NavigateDrawerState extends State<NavigateDrawer> {
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: <Widget>[
//           UserAccountsDrawerHeader(
//             accountEmail: FutureBuilder(
//                 future: FirebaseDatabase.instance
//                     .reference()
//                     .child("Users")
//                     .child(widget.uid!)
//                     .once(),
//                 builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
//                   if (snapshot.hasData) {
//                     return Text(snapshot.data!.value['email']);
//                   } else {
//                     return CircularProgressIndicator();
//                   }
//                 }),
//             accountName: FutureBuilder(
//                 future: FirebaseDatabase.instance
//                     .reference()
//                     .child("Users")
//                     .child(widget.uid!)
//                     .once(),
//                 builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
//                   if (snapshot.hasData) {
//                     return Text(snapshot.data!.value['name']);
//                   } else {
//                     return CircularProgressIndicator();
//                   }
//                 }),
//             decoration: BoxDecoration(
//               color: Colors.blue,
//             ),
//           ),
//           ListTile(
//             leading: new IconButton(
//               icon: new Icon(Icons.home, color: Colors.black),
//               onPressed: () => null,
//             ),
//             title: Text('Home'),
//             onTap: () {
//               print(widget.uid);
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => Home(uid: widget.uid)),
//               );
//             },
//           ),
//           ListTile(
//             leading: new IconButton(
//               icon: new Icon(Icons.settings, color: Colors.black),
//               onPressed: () => null,
//             ),
//             title: Text('Settings'),
//             onTap: () {
//               print(widget.uid);
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Hackathon 2022',
//       theme: ThemeData(
//         primarySwatch: Colors.cyan,
//       ),
//       home: const Home(title: 'Cowrie Cash'),
//     );
//   }
// }

class Send extends StatefulWidget {
  const Send({super.key});

  @override
  State<Send> createState() => _Send();
}


class Load extends StatefulWidget {
  const Load({super.key});

  @override
  State<Load> createState() => _Load();
}

class _Send extends State<Send> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Center(
            child: Text(
          'Send Cowries',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 30, color: Colors.white),
        )),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
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
          )
        ],
      ),
      body: Center(
        child: Column(children: [
          // ElevatedButton(
          //   child: const Text('Open route'),
          //   onPressed: () {
          //     Navigator.pop(
          //       context,
          //       MaterialPageRoute(
          //           builder: (context) => const Home(title: 'Cowrie Cash')),
          //     );
          //   },
          // ),
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
            TextField(
            onSubmitted: (String value) async {
            Navigator.pop(
            context,
            MaterialPageRoute(
            builder: (context) => const Home()),
            );
            },

          ),
        ]),
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({this.uid,super.key});
  final String? uid;
  final title = "Cowrie Cash";

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

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

  void _buttonTest() {

  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    syncData s = syncData();
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Center(
            child: Text(
          widget.title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 30, color: Colors.white),
        )),
      ),
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
                                onPressed: _buttonTest,
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
