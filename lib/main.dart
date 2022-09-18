import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import  'package:firebase_database/firebase_database.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';
import 'signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cowrie Cash',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: IntroScreen(),
    );
  }
}

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? result = FirebaseAuth.instance.currentUser;
    return new SplashScreen(
        useLoader: true,
        loadingText: Text("Connecting to the server"),
        navigateAfterSeconds: result != null ? Home() : SignUp(),
        seconds: 1,
        title: new Text(
          'Cowrie Cash',
          style: new TextStyle(fontWeight: FontWeight.normal, fontSize: 30.0),
        ),
        image: Image.asset('CowrieCoin.png', height: 100,scale: 10,),
        backgroundColor: Color.fromARGB(100,255, 167, 38),
        styleTextUnderTheLoader: new TextStyle(),
        onClick: () => print("flutter"),
        loaderColor: Colors.cyan);
  }
}
