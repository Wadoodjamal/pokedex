class SignInState {
  final String password;
  final String email;

  SignInState({
    this.password = '',
    this.email = '',
  });

  SignInState copyWith({
    String? password,
    String? email,
  }) {
    return SignInState(
      password: password ?? this.password,
      email: email ?? this.email,
    );
  }
}

class SignInLoading extends SignInState {
  SignInLoading() : super();
}

class SignInSuccess extends SignInState {}

class SignInError extends SignInState {}
