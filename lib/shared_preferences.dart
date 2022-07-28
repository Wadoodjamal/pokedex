import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

void storeUserSignIn(email, password) async {
  var user = {
    'email': email,
    'password': password,
  };
  final prefs = await SharedPreferences.getInstance();
  const key = 'user';
  final value = json.encode(user);
  prefs.setString(key, value);
}

Future<bool> getUser() async {
  bool check = false;
  final prefs = await SharedPreferences.getInstance();
  final user = prefs.getString('user');
  if (user != null) {
    check = true;
  }
  return check;
}

void storeUserSignUp(name, email, password) async {
  var user = {
    'name': name,
    'email': email,
    'password': password,
  };
  final prefs = await SharedPreferences.getInstance();
  const key = 'user';
  final value = json.encode(user);
  prefs.setString(key, value);
}
