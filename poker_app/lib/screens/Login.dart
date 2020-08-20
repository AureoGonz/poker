import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:poker_app/entity/User.dart';
import 'package:poker_app/service/PreferenciasCompartidas.dart';

class Login extends StatefulWidget {
  @override
  _Login createState() => _Login();
}

class _Login extends State<Login> {
  User user = User.instance;
  String host = '';
  int counter = 0;
  List<DropdownMenuItem<String>> devicesMenu =
      new List<DropdownMenuItem<String>>();

  @override
  void initState() {
    testConnected();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(32),
        child: Form(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButtonFormField(
                value: this.user.ip,
                items: this.devicesMenu,
                onChanged: (value) {
                  setState(() {
                    this.host = value;
                  });
                },
                onTap: testConnected,
                decoration: InputDecoration(
                    hintText: '192.168.0.13',
                    labelText: 'Servidor',
                    filled: true,
                    border: const UnderlineInputBorder())),
            SizedBox(
              height: 16,
            ),
            TextFormField(
                initialValue: user.name,
                onChanged: (value) => user.name = value,
                decoration: InputDecoration(
                    hintText: 'Tu nombre',
                    labelText: 'Nombre',
                    filled: true,
                    border: const UnderlineInputBorder())),
            SizedBox(
              height: 16,
            ),
            ButtonBar(
              buttonPadding: EdgeInsets.zero,
              alignment: MainAxisAlignment.end,
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    if (user.name != '' || user.name != null) {
                      Preferencias.setUserName(user.name);
                      // Navigator.of(context).push(
                      //     MaterialPageRoute(builder: (context) => TestMDNS()));
                    }
                  },
                  child: Text('Unirse'),
                )
              ],
            )
          ],
        )),
      ),
    );
  }

  void testConnected() async {
    String ip = this.user.ip;
    final String subnet = ip.substring(0, ip.lastIndexOf('.'));
    devicesMenu.clear();
    devicesMenu.add(DropdownMenuItem<String>(
                child: Text(ip), value: ip));

    for (int i = 1; i < 255; i++)
      //ping -c 1 -W 1 $ip
      await Process.start('ping', ['-c', '1', '-W', '1', '$subnet.$i']).then((arp) {
        arp.stdout.transform(utf8.decoder).listen((data) {
          if (data.contains('1 received')&&this.user.ip!='$subnet.$i') {
            devicesMenu.add(DropdownMenuItem<String>(
                child: Text('$subnet.$i'), value: '$subnet.$i'));
          }
        });
      });
    setState(() {});
  }
}
