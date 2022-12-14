import 'package:flutter/material.dart';
import 'home.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'main.dart';

class Payment extends StatefulWidget {
  const Payment({super.key, required this.receiverID});
  final String receiverID;
  @override
  State<Payment> createState() => _Payment();
}

class _Payment extends State<Payment> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  int amount = 0;
  var rid;
  String rName = '';

  @override
  void initState() {
    super.initState();
    rid = widget.receiverID;
    final ref = FirebaseDatabase.instance.ref();
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      Navigator.pop(
        context,
        MaterialPageRoute(builder: (context) => MyApp()),
      );
    }

    ref.child('Identifier/$rid/name').get().then((snapshot) => {
      if (snapshot.exists)
        {
          setState(() {
            rName = snapshot.value.toString();
          })
        }
      else
        {print('No data available.')}
    });
  }

  void _submit() {
    showDialog<void>(
      context: context,
      barrierDismissible: true, // user can tap anywhere to close the pop up
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Pay ${(amount / 100).toStringAsFixed(2)} to $rName?",
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 30, color: Colors.cyan),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: const <Widget>[
                Align(
                    alignment: Alignment.topLeft,
                    child: Text("Full name:",
                        style: TextStyle(fontWeight: FontWeight.w700))),
              ],
            ),
          ),
          actions: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.grey,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  child: const Text('Yes!'),
                  onPressed: () async {
                    final ref = FirebaseDatabase.instance.ref();
                    final uid = FirebaseAuth.instance.currentUser?.uid;

                    if (uid == null) {
                      return;
                    }

                    ref.child('Identifier/$uid/balance').get().then((currBalance) => {
                      if (currBalance.exists && int.parse(currBalance.value.toString()) > amount) {
                        ref.child('Identifier/$rid/balance').get().then((recBalance) => {
                      if (recBalance.exists)
                        {
                            setState(() {
                            int Balance = int.parse(recBalance.value.toString());
                            Balance+= amount;
                            ref.child('Identifier/$rid/balance').set(Balance);
                          })
                        }
                      else
                        {print('No data available.')}
                    })}
                      }
                    );

                    FocusScope.of(context)
                        .unfocus(); // unfocus last selected input field
                    Navigator.pop(context);
                    await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const Home())) // Open my profile
                        .then((_) => _formKey.currentState
                            ?.reset()); // Empty the form fields
                    setState(() {});
                  }, // so the alert dialog is closed when navigating back to main page
                ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text(
          'Send Cowries',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
        child: Column(children: <Widget>[
           Align(
            alignment: Alignment.center,
            child: Text("How much would you like to send to $rName?",
                style: const TextStyle(
                  fontSize: 24,
                )),
          ),
          const SizedBox(
            height: 100,
          ),
          Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                    margin: const EdgeInsets.only(left: 30, right: 30),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          labelText: 'Amount',
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 0.0),
                          ),
                          border: OutlineInputBorder()),
                      onFieldSubmitted: (value) {
                        setState(() {
                          amount = (double.parse(value)*100).round();
                        });
                      },
                      onChanged: (value) {
                        setState(() {
                          amount = (double.parse(value)*100).round();
                        });
                      },
                    )),
                const SizedBox(
                  height: 200,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        minimumSize: const Size.fromHeight(100)),
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState!.validate()) {
                        _submit();
                      }
                    },
                    child: const Text("Pay"),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
