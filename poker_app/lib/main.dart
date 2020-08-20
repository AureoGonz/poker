import 'package:flutter/material.dart';
import 'package:poker_app/screens/Login.dart';

import 'entity/User.dart';
import 'service/PreferenciasCompartidas.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Poker',
      theme: ThemeData.dark(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePage createState() => _MyHomePage();
}

class _MyHomePage extends State<MyHomePage> {
  User user = User.instance;

  @override
  void initState() {
    Preferencias.loadUserName().then((value) {
      this.user.name = value[0];
      this.user.ip = value[1];
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (build) => Login()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Poker',
              style:
                  TextStyle(color: Theme.of(context).accentColor, fontSize: 35),
            ),
            SizedBox(
              height: 40,
            ),
            CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}