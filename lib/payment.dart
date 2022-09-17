import 'package:flutter/material.dart';
import 'home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class Payment extends StatefulWidget {
  const Payment({super.key, required this.receiverID});
  final String receiverID;
  @override
  State<Payment> createState() => _Payment();
}

class _Payment extends State<Payment> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  int Amount=0;

  void _submit() {
    showDialog<void>(
      context: context,
      barrierDismissible: true, // user can tap anywhere to close the pop up
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Balance: " + (Amount / 100).toStringAsFixed(2),
            textAlign: TextAlign.center,
            style:
            const TextStyle(fontSize: 30, color: Colors.cyan),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const Align(
                    alignment: Alignment.topLeft,
                    child: Text("Full name:",
                        style: TextStyle(fontWeight: FontWeight.w700))),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.grey,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  child: const Text('Go to profile'),
                  onPressed: () async {
                    FocusScope.of(context)
                        .unfocus(); // unfocus last selected input field
                    Navigator.pop(context);
                    await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Home())) // Open my profile
                        .then((_) => _formKey.currentState
                            ?.reset()); // Empty the form fields
                    setState(() {});
                  }, // so the alert dialog is closed when navigating back to main page
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.blue,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                    FocusScope.of(context)
                        .unfocus(); // Unfocus the last selected input field
                    _formKey.currentState?.reset(); // Empty the form fields
                  },
                )
              ],
            )
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
        title: Text(
          'Send Cowries',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 30, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
        child: Column(children: <Widget>[
          const Align(
            alignment: Alignment.center,
            child: Text("How much would you like to send?",
                style: TextStyle(
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
                margin: EdgeInsets.only(left:30,right:30),
               child: TextFormField(
                 keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      labelText: 'Amount',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(color: Colors.grey, width: 0.0),
                      ),
                      border: OutlineInputBorder()),
                  onFieldSubmitted: (value) {
                    setState(() {
                      Amount = int.parse(value);
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                      Amount = int.parse(value);
                    });
                  },
                  validator: (value) {
                   // if (value == Null) {
                   //   return 'Please enter amount.';
                   // } else if (value.contains(RegExp(r'[^0-9]+'))) {
                   //    return 'Amount must only consist of numbers.';
                   //  }
                  },
                )
            ),

                // DropdownButtonFormField(
                //     decoration: const InputDecoration(
                //         enabledBorder: OutlineInputBorder(
                //           borderRadius: BorderRadius.all(Radius.circular(20.0)),
                //           borderSide:
                //               BorderSide(color: Colors.grey, width: 0.0),
                //         ),
                //         border: OutlineInputBorder()),
                //     items: [
                //       const DropdownMenuItem(
                //         child: Text("ºC"),
                //         value: 1,
                //       ),
                //       const DropdownMenuItem(
                //         child: Text("ºF"),
                //         value: 2,
                //       )
                //     ],
                //     hint: const Text("Select item"),
                //     onChanged: (value) {
                //       setState(() {
                //         measure = value;
                //         // measureList.add(measure);
                //       });
                //     },
                //     onSaved: (value) {
                //       setState(() {
                //         measure = value;
                //       });
                //     }),
                const SizedBox(
                  height: 200,
                ),
                Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
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
