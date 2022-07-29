import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/bloc/states/sign_up_state.dart';
import 'package:pokedex/firebase_functions.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpStateInitial());

  String getName() => state.name;

  String getPassword() => state.password;

  String getEmail() => state.email;

  void switchToSignIn() {
    emit(SignUpStateSwitchToSignIn());
  }

  void nameChanged(String? value) {
    emit(state.copyWith(name: value));
  }

  void emailChanged(String? value) {
    emit(state.copyWith(email: value));
  }

  void passwordChanged(String? value) {
    emit(state.copyWith(password: value));
  }

  void onPress() async {
    emit(SignUpStateLoading(
        email: state.email, password: state.password, name: state.name));
    var check = await signUp(state.email, state.password);
    if (check) {
      emit(SignUpStateSuccess());
    } else {
      emit(SignUpStateFailure());
    }
  }
}

  // void _onPress() async {
  //   var check = _fbKey.currentState!.validate();
  //   if (check) {
  //     var checkSignUp = await signUp(email, password);
  //     if (checkSignUp) {
  //       storeUserSignUp(name, email, password);
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => const HomeScreen(),
  //         ),
  //       );
  //     } else {
  //       print('Sign Up failed');
  //     }
  //   } else {
  //     print('Form is invalid');
  //   }
  // }