import 'package:flutter/material.dart';
import 'Sync.dart';
import 'home.dart';
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