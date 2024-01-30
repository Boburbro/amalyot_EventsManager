// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: file_names

import 'dart:async';

import 'package:amalyot_uchun/service/my_errors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AppProvider with ChangeNotifier {
  String? token;

  Future<void> logIn(String username, String password) async {
    Uri url = Uri.parse("https://backend.emg.abdurakhman.uz/admin/login");
    var forBody = jsonEncode({"email": username, "password": password});
    try {
      final r = await http.post(
        url,
        body: forBody,
        headers: {'Content-Type': 'application/json'},
      );
      final data = jsonDecode(r.body);
      if (data['status'] == 200) {
        token = data['token'];
        final prefs = await SharedPreferences.getInstance();
        prefs.setString("token", token!);
      } else {
        throw MyException(message: "Invalid email or password");
      }
      return;
    } catch (e) {
      throw MyException(message: "Not Internet");
    }
  }

  Future<bool> checkToken() async {
    Uri url = Uri.parse("https://backend.emg.abdurakhman.uz/admin/checkToken");
    final r = await http.get(
      url,
      headers: {'Content-Type': 'application/json', 'token': token!},
    );
    final data = jsonDecode(r.body);
    if (data['status'] == 200) {
      return true;
    }
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    return false;
  }

  Future<Map> getUser(String userId) async {
    Uri url =
        Uri.parse("https://backend.emg.abdurakhman.uz/admin/userinfo/$userId");
    final r = await http.get(
      url,
      headers: {'Content-Type': 'application/json', 'token': token!},
    );
    return {"a": r.body};
  }

  Future<bool> isAuth() async {
    print("=== $token");
    if (token == null) {
      return false;
    }
    var check = await checkToken();
    if (check) {
      return true;
    }
    return true;
  }

  Future<void> autoLogIn() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("token")) {
      token = prefs.getString("token");
    }
  }

  Future<void> logOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    token = null;
  }
}
