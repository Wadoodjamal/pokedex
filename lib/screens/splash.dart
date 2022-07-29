import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/bloc/cubit/splash_cubit.dart';
import 'package:pokedex/bloc/states/splash_sate.dart';
import 'package:pokedex/screens/home.dart';
import 'package:pokedex/screens/sign_in.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  void _listener(state, context) async {
    if (state is SplashStateSuccess) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    }
    if (state is SplashStateFailure) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SignInScreen(),
        ),
      );
    }
  }

  void _builder(BuildContext context, SplashState state) {
    if (state is SplashStateInitial) {
      context.read<SplashCubit>().waitForScreenLoad();
    } else if (state is SplashStateLoading) {
      context.read<SplashCubit>().checkForUser();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<SplashCubit, SplashState>(
          listener: (context, state) {
            _listener(state, context);
          },
          builder: (context, state) {
            _builder(context, state);
            return Center(
              child: Image.asset(
                'assets/images/logo.JPG',
                width: 200,
                height: 250,
                fit: BoxFit.cover,
              ),
            );
          },
        ),
      ),
    );
  }
}
