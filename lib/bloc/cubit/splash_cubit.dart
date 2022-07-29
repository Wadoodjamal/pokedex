import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/bloc/states/splash_sate.dart';
import 'package:pokedex/shared_preferences.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashStateInitial());

  Future<void> waitForScreenLoad() async {
    await Future.delayed(const Duration(seconds: 4));
    emit(SplashStateLoading());
  }

  void checkForUser() async {
    var check = await getUser();
    if (check) {
      onSuccess();
    } else {
      onFailure();
    }
  }

  void onSuccess() {
    emit(SplashStateSuccess());
  }

  void onFailure() {
    emit(SplashStateFailure());
  }
}
