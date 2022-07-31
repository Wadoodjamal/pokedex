import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/bloc/states/nav_state.dart';

class NavCubit extends Cubit<NavState> {
  NavCubit() : super(NavStateHome());

  void goToHome() => emit(NavStateHome());

  void goToFavourite() => emit(NavStateFavourite());

  void goToSplash() => emit(NavStateSplash());

  void goToSignIn() => emit(NavStateSignIn());

  void goToSignUp() => emit(NavStateSignUp());

  void pop() => emit(NavStatePop());
}
