import 'package:clocker/pages/controller.dart';
import 'package:flutter/material.dart';
import 'package:clocker/db.dart';
import 'package:clocker/main.dart';

class CredentialsPage extends StatefulWidget {
  @override
  _CredentialsPage createState() => _CredentialsPage();
}

class _CredentialsPage extends State<CredentialsPage> {
  final controllerUsername = TextEditingController();
  final controllerPassword = TextEditingController();
  bool isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: const Text('CLOCKER',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: 16,
            ),
            Center(
              child: const Text('', style: TextStyle(fontSize: 16)),
            ),
            SizedBox(
              height: 16,
            ),
            TextField(
              controller: controllerUsername,
              enabled: !isLoggedIn,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.none,
              autocorrect: false,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  labelText: 'Host'),
            ),
            SizedBox(
              height: 8,
            ),
            TextField(
              controller: controllerPassword,
              enabled: !isLoggedIn,
              obscureText: true,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.none,
              autocorrect: false,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  labelText: 'Token'),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              height: 50,
              child: TextButton(
                child: const Text('Set'),
                onPressed: isLoggedIn ? null : () => doUserLogin(),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  void showSuccess(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Success!"),
          content: Text(message),
          actions: <Widget>[
            new TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void showError(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error!"),
          content: Text(errorMessage),
          actions: <Widget>[
            new TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void doUserLogin() async {
    setInfo(controllerUsername.text, controllerPassword.text);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ControllerPage()),
    );
  }
}
