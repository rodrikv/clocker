import 'dart:async';
import 'dart:convert';

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

    try {
      var r = await http.post(url);
      return ResponseData.fromJson(jsonDecode(r.body));
    } catch (e) {
      return ResponseData.connectionRefused;
    }
  }

  Future<ResponseData> ping() async {
    var url = Uri(
        scheme: scheme,
        host: host.split(":")[0],
        path: "/ping",
        port: host.split(":").length > 1 ? int.parse(host.split(":")[1]) : 80);

    try {
      var r = await http.get(url);
      return ResponseData.fromJson(jsonDecode(r.body));
    } catch (e) {
      return ResponseData.connectionRefused;
    }
  }
}

class ResponseData {
  final String data;
  final String msg;
  final int code;

  const ResponseData({
    required this.data,
    required this.msg,
    required this.code,
  });

  factory ResponseData.fromJson(json) {
    return ResponseData(
      data: json['data'],
      msg: json['msg'],
      code: json['code'],
    );
  }

  static const ResponseData connectionRefused = ResponseData(
    data: "",
    msg: "Connection Refused",
    code: 500,
  );
}
