import 'dart:collection';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

setInfo(String host, String token) async {
  var prefs = await SharedPreferences.getInstance();

  await prefs.setString('host', host);
  await prefs.setString('token', token);
}

getInfo() async {
  var prefs = await SharedPreferences.getInstance();

  if (prefs.containsKey('host') && prefs.containsKey('token')) {
    return {
      'host': prefs.getString('host')!,
      'token': prefs.getString('token')!,
    };
  } else {
    return null;
  }
}

removeInfo() async {
  var prefs = await SharedPreferences.getInstance();

  await prefs.remove('host');
  await prefs.remove('token');
}

Future<bool> hasInfo() async {
  var prefs = await SharedPreferences.getInstance();

  return prefs.containsKey('host') && prefs.containsKey('token');
}
