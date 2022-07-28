import 'package:flutter/material.dart';
import 'package:pokedex/screens/home.dart';
import 'package:pokedex/screens/sign_in.dart';
import 'package:pokedex/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void _nextScreen() {
    Future.delayed(const Duration(seconds: 4), () async {
      var check = await getUser();
      if (check) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SignInScreen(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _nextScreen();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Image.asset(
            'assets/images/logo.JPG',
            width: 200,
            height: 250,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
