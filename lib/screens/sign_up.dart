import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:pokedex/bloc/cubit/nav_cubit.dart';
import 'package:pokedex/bloc/cubit/sign_up_cubit.dart';
import 'package:pokedex/bloc/states/nav_state.dart';
import 'package:pokedex/bloc/states/sign_up_state.dart';
import 'package:pokedex/screens/home.dart';
import 'package:pokedex/screens/sign_in.dart';
import 'package:pokedex/widgets/custom_text_button.dart';
import 'package:pokedex/widgets/custom_text_field.dart';

class SignUpScreen extends StatelessWidget {
  static final GlobalKey<FormBuilderState> _fbKey2 =
      GlobalKey<FormBuilderState>();

  const SignUpScreen({Key? key}) : super(key: key);

  void _listeners(state, context) {
    if (state is SignUpStateSuccess) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<SignUpCubit, SignUpState>(
          listener: (context, state) {
            _listeners(state, context);
          },
          builder: (context, state) {
            if (state is SignUpStateLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
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
                    const SizedBox(height: 50),
                    FormBuilder(
                      key: _fbKey2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Name',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          const SizedBox(height: 6),
                          _nameTextField(),
                          const SizedBox(height: 20),
                          Text(
                            'Email',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          const SizedBox(height: 6),
                          _emailTextField(),
                          const SizedBox(height: 20),
                          Text(
                            'Password',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          const SizedBox(height: 6),
                          _passwordTextField(),
                          const SizedBox(height: 60),
                          _signUpButton(),
                          const SizedBox(height: 10),
                          _signInText(),
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
    );
  }

  Widget _signInText() {
    return BlocConsumer<NavCubit, NavState>(listener: (context, state) {
      if (state is NavStateSignIn) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const SignInScreen()));
      }
    }, builder: (context, state) {
      return Center(
        child: GestureDetector(
          onTap: () => {
            context.read<NavCubit>().goToSignIn(),
          },
          child: Text(
            'Already have an account? Sign In.',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.blue[600],
            ),
          ),
        ),
      );
    });
  }

  Widget _signUpButton() {
    return BlocBuilder<SignUpCubit, SignUpState>(builder: (context, state) {
      return Center(
          child: CustomTextButton(
        text: 'Sign Up',
        func: () => context.read<SignUpCubit>().onPress(),
      ));
    });
  }

  Widget _passwordTextField() {
    return BlocBuilder<SignUpCubit, SignUpState>(builder: (context, state) {
      return CustomTextField(
        isObscure: true,
        name: 'password',
        type: TextInputType.number,
        icon: const Icon(Icons.password),
        onChanged: (value) =>
            context.read<SignUpCubit>().passwordChanged(value),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter your password';
          }
          return null;
        },
      );
    });
  }

  Widget _emailTextField() {
    return BlocBuilder<SignUpCubit, SignUpState>(builder: (context, state) {
      return CustomTextField(
        name: 'email',
        type: TextInputType.emailAddress,
        icon: const Icon(Icons.email),
        onChanged: (value) => context.read<SignUpCubit>().emailChanged(value),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter your email';
          }
          return null;
        },
      );
    });
  }

  Widget _nameTextField() {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return CustomTextField(
          name: 'name',
          type: TextInputType.name,
          icon: const Icon(Icons.person),
          onChanged: (value) => context.read<SignUpCubit>().nameChanged(value),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter your name';
            }
            return null;
          },
        );
      },
    );
  }
}
