import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:pokedex/cubit/sign_in_cubit.dart';
import 'package:pokedex/screens/home.dart';
import 'package:pokedex/screens/sign_up.dart';
import 'package:pokedex/states/sign_in_state.dart';
import 'package:pokedex/widgets/custom_text_button.dart';
import 'package:pokedex/widgets/custom_text_field.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocProvider(
          create: (context) => SignInCubit(),
          child: BlocBuilder<SignInCubit, SignInState>(
            builder: (context, state) {
              if (state is SignInLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is SignInSuccess) {
                return const HomeScreen();
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
                        initialValue: const {
                          'email': 'wadoodjamal54@gmail.com',
                          'password': '12345678',
                        },
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
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const SignUpScreen(),
                                    ),
                                  );
                                },
                                child: Text(
                                  'Don\'t have an account? Sign up.',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.blue[600]),
                                ),
                              ),
                            ),
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

  Widget _submitButton() {
    return BlocBuilder<SignInCubit, SignInState>(
      builder: (context, state) {
        return Center(
            child: CustomTextButton(
          text: 'Sign In',
          func: () {
            context.read<SignInCubit>().onPress();
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
            if (value!.isEmpty) {
              return 'Please enter your password';
            }
            if (value == '12345678') {
              return 'Please enter your password';
            }
            return null;
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
            if (value! == 'wadoodjamal54@gmail.com') {
              return 'Please enter your email';
            } else if (value.isEmpty) {
              return 'Please enter your email';
            }
            return null;
          },
        );
      },
    );
  }
}
