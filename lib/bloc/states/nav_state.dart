enum Screens {
  home,
  favourites,
  splash,
  signIn,
  signUp,
}

class NavState {
  final List<Screens> screens;
  final Screens currentScreen;
  NavState({this.currentScreen = Screens.splash, this.screens = const []});

  NavState copyWith({List<Screens>? screens}) {
    return NavState(screens: screens ?? this.screens);
  }
}

class NavStateHome extends NavState {
  NavStateHome();
}

class NavStateFavourite extends NavState {
  NavStateFavourite();
}

class NavStateSplash extends NavState {
  NavStateSplash();
}

class NavStateSignIn extends NavState {
  NavStateSignIn();
}

class NavStateSignUp extends NavState {
  NavStateSignUp();
}

class NavStatePop extends NavState {
  NavStatePop();
}
