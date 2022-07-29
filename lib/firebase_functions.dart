import 'package:firebase_auth/firebase_auth.dart';

Future<bool> signIn(String email, String password) async {
  var check = false;
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
          email: email,
          password: password,
        )
        .then((value) => check = true);
  } catch (e) {
    print(e.toString());
  }
  return check;
}

Future<bool> signUp(String email, String password) async {
  var check = false;
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
          email: email,
          password: password,
        )
        .then((value) => check = true);
  } catch (e) {
    print(e.toString());
  }
  return check;
}
