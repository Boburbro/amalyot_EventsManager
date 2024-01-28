// ignore: file_names
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AppProvider with ChangeNotifier {
  String token = "";

  Future<void> logIn(String username, String password) async {
    Uri url = Uri.parse("https://backend.emg.abdurakhman.uz/admin/login");
    var forBody = jsonEncode({"email": username, "password": password});
    final r = await http.post(
      url,
      body: forBody,
      headers: {'Content-Type': 'application/json'},
    );
    final data = jsonDecode(r.body);
    if (data['status'] == 200) {
      token = data['token'];
    }
    return;
  }

  Future<void> checkToken() async {
    Uri url = Uri.parse("https://backend.emg.abdurakhman.uz/admin/checkToken");
    final r = await http.get(
      url,
      headers: {'Content-Type': 'application/json', 'token': token},
    );
    final data = jsonDecode(r.body);
    print(data);
    if (data['status'] == 200) {
      
    }
    return;
  }
}
