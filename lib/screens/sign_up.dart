import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:pokedex/screens/home.dart';
import 'package:pokedex/screens/sign_in.dart';
import 'package:pokedex/shared_preferences.dart';
import 'package:pokedex/widgets/custom_text_button.dart';
import 'package:pokedex/widgets/custom_text_field.dart';
import 'package:pokedex/widgets/firebase_functions.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  String name = '';
  String email = '';
  String password = '';

  void _name(String? value) {
    setState(() {
      name = value!;
    });
  }

  void _email(String? value) {
    setState(() {
      email = value!;
    });
  }

  void _password(String? value) {
    setState(() {
      password = value!;
    });
  }

  void _onPress() async {
    var check = _fbKey.currentState!.validate();
    if (check) {
      var checkSignUp = await signUp(email, password);
      if (checkSignUp) {
        storeUserSignUp(name, email, password);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      } else {
        print('Sign Up failed');
      }
    } else {
      print('Form is invalid');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
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
                  key: _fbKey,
                  initialValue: const {
                    'name': 'Wadood',
                    'email': '',
                    'password': ''
                  },
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
                      CustomTextField(
                        name: 'name',
                        type: TextInputType.name,
                        icon: const Icon(Icons.person),
                        onChanged: _name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
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
                      CustomTextField(
                        name: 'email',
                        type: TextInputType.emailAddress,
                        onChanged: _email,
                        icon: const Icon(Icons.email),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
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
                      CustomTextField(
                        name: 'password',
                        onChanged: _password,
                        type: TextInputType.number,
                        icon: const Icon(Icons.password),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 60),
                      Center(
                          child: CustomTextButton(
                        text: 'Sign Up',
                        func: _onPress,
                      )),
                      const SizedBox(height: 10),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignInScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'Already have an account? Sign In.',
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
        ),
      ),
    );
  }
}
