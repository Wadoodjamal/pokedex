import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/bloc/cubit/favourite_cubit.dart';
import 'package:pokedex/bloc/cubit/home_cubit.dart';
import 'package:pokedex/bloc/cubit/nav_cubit.dart';
import 'package:pokedex/bloc/cubit/sign_in_cubit.dart';
import 'package:pokedex/bloc/cubit/sign_up_cubit.dart';
import 'package:pokedex/bloc/cubit/splash_cubit.dart';
import 'package:pokedex/screens/favourites.dart';
import 'package:pokedex/screens/sign_up.dart';
import 'package:pokedex/screens/splash.dart';

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
          child: SignUpScreen(),
        ),
        BlocProvider<HomeCubit>(
          create: (_) => HomeCubit(),
        ),
        BlocProvider<FavouriteCubit>(
          create: (_) => FavouriteCubit(),
          child: const FavouritesScreen(),
        ),
        BlocProvider<NavCubit>(
          create: (_) => NavCubit(),
        )
      ],
      child: child!,
    );
  }
}
