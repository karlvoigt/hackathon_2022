import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hackathon 2022',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: const MyHomePage(title: 'Cowrie Cash'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

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
        title: Center(
            child: Text(
                widget.title,
                textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 30, color: Colors.white),
            )
        ),
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
                    margin: const EdgeInsets.all(10),
                    height: 200,
                    child: FractionallySizedBox(
                        heightFactor: 0.4,
                        alignment: FractionalOffset.center,
                        child: AspectRatio(
                            aspectRatio: 1 / 1,
                            child: Placeholder(
                              color: Colors.tealAccent,
                            )))),
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
                                onPressed: _buttonTest,
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
                        margin: EdgeInsets.only(top:20,left: 10,right:10),
                        child: AspectRatio(
                            aspectRatio: 5/4,
                            child: ElevatedButton(
                                onPressed: _buttonTest,
                                child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        size:50,
                                        Icons.account_balance_outlined,
                                        color: Colors.white,
                                      ),
                                      Padding(padding: EdgeInsets.only(top:10)),
                                      const Text(
                                        'Load',
                                        style: const TextStyle(fontSize: 20, color: Colors.white),
                                      )
                                    ])))),
                    Container(
                        margin: EdgeInsets.only(top:20,left: 10,right:10),
                        child: AspectRatio(
                            aspectRatio: 5/4,
                            child: ElevatedButton(
                                onPressed: _buttonTest,
                                child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        size:50,
                                        Icons.account_box_outlined,
                                        color: Colors.white,
                                      ),
                                      Padding(padding: EdgeInsets.only(top:10)),
                                      const Text(
                                        'Account',
                                        style: const TextStyle(fontSize: 20, color: Colors.white),
                                      )
                                    ])))),
                  ],
                )),
          ],
        ),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
