import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/bloc/states/sign_in_state.dart';
import 'package:pokedex/firebase_functions.dart';
import 'package:pokedex/shared_preferences.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInState());

  void emailChanged(String? value) {
    emit(state.copyWith(email: value!));
  }

  void passwordChanged(String? value) {
    emit(state.copyWith(password: value!));
  }

  void onPress() async {
    emit(SignInLoading(email: state.email, password: state.password));
    if (await signIn(state.email, state.password)) {
      storeUserSignIn(state.email, state.password);
      emit(SignInSuccess());
    } else {
      emit(SignInError());
    }
  }
}
