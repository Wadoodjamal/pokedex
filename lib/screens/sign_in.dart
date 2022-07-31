import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:pokedex/bloc/cubit/nav_cubit.dart';
import 'package:pokedex/bloc/cubit/sign_in_cubit.dart';
import 'package:pokedex/bloc/states/nav_state.dart';
import 'package:pokedex/bloc/states/sign_in_state.dart';
import 'package:pokedex/screens/home.dart';
import 'package:pokedex/screens/sign_up.dart';
import 'package:pokedex/widgets/custom_text_button.dart';
import 'package:pokedex/widgets/custom_text_field.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);
  static final GlobalKey<FormBuilderState> _fbKey =
      GlobalKey<FormBuilderState>();

  void _listeners(context, state) {
    if (state is SignInError) {
      _showErrorDialog(context);
    }
  }

  void _showErrorDialog(context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: const Text('Email or password is incorrect'),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocListener<NavCubit, NavState>(
          listener: (context, state) {
            if (state is NavStateSignUp) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SignUpScreen()));
            }
            if (state is NavStateHome) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()));
            }
          },
          child: BlocConsumer<SignInCubit, SignInState>(
            listener: (context, state) {
              _listeners(context, state);
            },
            builder: (context, state) {
              if (state is SignInLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is SignInSuccess) {
                context.read<NavCubit>().goToHome();
              }
              return Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/logo.JPG',
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 70),
                      FormBuilder(
                        key: _fbKey,
                        onChanged: () {
                          _fbKey.currentState!.save();
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Email',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            const SizedBox(height: 6),
                            _emailField(),
                            const SizedBox(height: 30),
                            Text(
                              'Password',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            const SizedBox(height: 6),
                            _passwordField(),
                            const SizedBox(height: 80),
                            _submitButton(),
                            const SizedBox(height: 10),
                            _signUpText(context),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _signUpText(BuildContext context) {
    return BlocBuilder<NavCubit, NavState>(
      builder: (context, state) {
        return Center(
          child: GestureDetector(
            onTap: () => {
              context.read<NavCubit>().goToSignUp(),
            },
            child: Text(
              'Don\'t have an account? Sign up.',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue[600]),
            ),
          ),
        );
      },
    );
  }

  Widget _submitButton() {
    return BlocBuilder<SignInCubit, SignInState>(
      builder: (context, state) {
        return Center(
            child: CustomTextButton(
          text: 'Sign In',
          func: () {
            if (_fbKey.currentState!.validate()) {
              context.read<SignInCubit>().onPress();
            }
          },
        ));
      },
    );
  }

  Widget _passwordField() {
    return BlocBuilder<SignInCubit, SignInState>(
      builder: (context, state) {
        return CustomTextField(
          isObscure: true,
          icon: const Icon(Icons.password),
          type: TextInputType.number,
          name: 'password',
          onChanged: context.read<SignInCubit>().passwordChanged,
          validator: (value) {
            return context.read<SignInCubit>().state.passwordIsValid
                ? null
                : 'Password must be at least 8 characters long';
          },
        );
      },
    );
  }

  Widget _emailField() {
    return BlocBuilder<SignInCubit, SignInState>(
      builder: (context, state) {
        return CustomTextField(
          icon: const Icon(Icons.email),
          type: TextInputType.emailAddress,
          name: 'email',
          onChanged: context.read<SignInCubit>().emailChanged,
          validator: (value) {
            return context.read<SignInCubit>().state.emailIsValid
                ? null
                : 'Email must contain @ and .';
          },
        );
      },
    );
  }
}
