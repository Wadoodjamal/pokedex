import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/bloc/states/sign_in_state.dart';
import 'package:pokedex/firebase_functions.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInState());

  void emailChanged(String? value) {
    emit(state.copyWith(email: value!));
  }

  void passwordChanged(String? value) {
    emit(state.copyWith(password: value!));
  }

  void onPress() async {
    print(state.email);
    print(state.password);
    if (state.email.isEmpty || state.password.isEmpty) {
      emit(SignInError());
    } else {
      if (await signIn(state.email, state.password)) {
        emit(SignInSuccess());
      } else {
        emit(SignInError());
      }
    }
  }
}
