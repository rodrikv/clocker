import 'package:flutter/material.dart';
import 'db.dart';
import 'pages/credentials.dart';
import 'package:clocker/pages/controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clocker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PreLoginCheckPage(),
    );
  }
}

class PreLoginCheckPage extends StatefulWidget {
  const PreLoginCheckPage({super.key});

  @override
  State<PreLoginCheckPage> createState() => _PreLoginCheckPageState();
}

class _PreLoginCheckPageState extends State<PreLoginCheckPage> {
  @override
  void initState() {
    getInfo().then((info) {
      if (info != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ControllerPage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CredentialsPage();
  }
}
