import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/bloc/cubit/sign_in_cubit.dart';
import 'package:pokedex/bloc/cubit/sign_up_cubit.dart';
import 'package:pokedex/bloc/cubit/splash_cubit.dart';
import 'package:pokedex/screens/sign_up.dart';
import 'package:pokedex/screens/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    const BlocProviders(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 93, 95, 125),
      ),
      home: const SignUpScreen(),
    );
  }
}

class BlocProviders extends StatelessWidget {
  const BlocProviders({
    Key? key,
    this.child,
  }) : super(key: key);

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SignInCubit>(
          create: (_) => SignInCubit(),
        ),
        BlocProvider<SplashCubit>(
          create: (_) => SplashCubit(),
          child: const SplashScreen(),
        ),
        BlocProvider<SignUpCubit>(
          create: (_) => SignUpCubit(),
          child: const SignUpScreen(),
        ),
      ],
      child: child!,
    );
  }
}
