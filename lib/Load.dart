import 'package:flutter/material.dart';
import 'home.dart';
class Load extends StatefulWidget {
  const Load({super.key});

  @override
  State<Load> createState() => _Load();
}
class _Load extends State<Load> {
  var uid='';
  @override
  void initState() {
    super.initState();
    final ref = FirebaseDatabase.instance.ref();
    final tuid = FirebaseAuth.instance.currentUser?.uid;
    if (tuid == Null) {
      Navigator.pop(
        context,
        MaterialPageRoute(builder: (context) => MyApp()),
      );
    }
    final snapshot =
    ref.child('Identifier/$tuid/balance').get().then((snapshot) => {
      if (snapshot.exists)
        {
          setState(() {
            uid = tuid;
          })
        }
      else
        {print('No data available.')}
    });
  }

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
            style:
            const TextStyle(fontSize: 30, color: Colors.cyan),
          ),
          Padding(padding: EdgeInsets.all(30)),
          SizedBox(
          width : 200,
          child : TextField(
            decoration: InputDecoration(
              hintText: '123456789',
              border: OutlineInputBorder(),
            ),
            onSubmitted: (String value) async {
              final ref = FirebaseDatabase.instance.ref();
              final snapshot =
              ref.child('Identifier/$uid/balance').get().then((snapshot) => {
                if (snapshot.exists)
                  {
                    setState(() {
                      int Balance = int.parse(snapshot.value.toString());
                      Balance+= amount;
                      ref.child('Identifier/$uid/balance').set(Balance);
                    })
                  }
                else
                  {print('No data available.')}
              });

              Navigator.pop(
                context,
                MaterialPageRoute(
                    builder: (context) => Home()),
              );
            },
          )
          ),
        ]),
      )
      );

  }
}