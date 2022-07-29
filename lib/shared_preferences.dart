import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

Future<bool> storeUserSignIn(email, password) async {
  bool check = false;

  var user = {
    'email': email,
    'password': password,
  };
  final prefs = await SharedPreferences.getInstance();
  const key = 'user';
  final value = json.encode(user);
  await prefs.setString(key, value).then((value) {
    check = true;
  });
  return check;
}

Future<bool> storeUserSignUp(name, email, password) async {
  bool check = false;

  var user = {
    'name': name,
    'email': email,
    'password': password,
  };
  final prefs = await SharedPreferences.getInstance();
  const key = 'user';
  final value = json.encode(user);
  prefs.setString(key, value).then((value) {
    check = true;
  });
  return check;
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

Future getFavouriteList() async {
  final prefs = await SharedPreferences.getInstance();
  var favouriteList = prefs.getString('favouriteList');
  if (favouriteList != null) {
    return json.decode(favouriteList);
  } else {
    return [];
  }
}
