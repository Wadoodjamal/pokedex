import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/bloc/states/sign_up_state.dart';
import 'package:pokedex/firebase_functions.dart';
import 'package:pokedex/shared_preferences.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpStateInitial());

  String getName() => state.name;

  String getPassword() => state.password;

  String getEmail() => state.email;

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
    if (await signUp(state.email, state.password)) {
      storeUserSignUp(state.name, state.email, state.password);
      emit(SignUpStateSuccess());
    } else {
      emit(SignUpStateFailure());
    }
  }
}
