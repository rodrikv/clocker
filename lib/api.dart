import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LockerApi {
  final String host;
  final String token;
  static const String scheme = "http";

  const LockerApi({
    required this.host,
    required this.token,
  });

  Future<ResponseData> suspend() async {
    var url = Uri(
        scheme: scheme,
        host: host.split(":")[0],
        path: "/$token/suspend/",
        port: host.split(":").length > 1 ? int.parse(host.split(":")[1]) : 80);
    var r = await http.post(url);
    return ResponseData.fromJson(jsonDecode(r.body));
  }
}

class ResponseData {
  final int data;
  final int msg;
  final String code;

  const ResponseData({
    required this.data,
    required this.msg,
    required this.code,
  });

  factory ResponseData.fromJson(Map<String, dynamic> json) {
    return ResponseData(
      data: json['data'],
      msg: json['msg'],
      code: json['code'],
    );
  }
}
