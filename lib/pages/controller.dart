import 'dart:async';

import 'package:flutter/material.dart';
import 'package:clocker/api.dart';
import 'package:clocker/db.dart';
import 'package:clocker/pages/credentials.dart';

class ControllerPage extends StatefulWidget {
  const ControllerPage({super.key});

  @override
  State<ControllerPage> createState() => _ControllerPageState();
}

class _ControllerPageState extends State<ControllerPage> {
  String host = "";
  String token = "";
  late LockerApi api;
  String _status = "Loading...";

  @override
  void initState() {
    getInfo().then((info) {
      if (info != null) {
        setState(() {
          host = info['host']!;
          token = info['token']!;
          api = LockerApi(host: host, token: token);
        });
      }
    });
    _startPing();
  }

  void _Lock() async {
    await api.suspend();
  }

  void _startPing() async {
    Timer.periodic(Duration(seconds: 1), _Ping);
  }

  void _Ping(Timer timer) async {
    ResponseData r = await api.ping();

    if (r.code == 200) {
      setState(() {
        _status = "Online";
      });
    } else {
      setState(() {
        _status = "Offline";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: _Lock,
              icon: const Icon(Icons.lock),
            ),
            Text(
              _status,
              style: const TextStyle(fontSize: 20, fontFamily: "Roboto"),
            ),
          ],
        ),
      ),
      floatingActionButton: IconButton(
        onPressed: () async {
          await _showMyDialog();
        },
        icon: const Icon(Icons.logout),
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Do you want to really logout?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Logout'),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => CredentialsPage()),
                );
              },
            ),
            TextButton(
              child: const Text('close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
