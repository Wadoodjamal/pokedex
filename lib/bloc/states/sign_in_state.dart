class SignInState {
  final String password;
  bool get passwordIsValid => password.length > 7;

  final String email;
  bool get emailIsValid => email.contains('@');

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
  SignInLoading({String? email, String? password})
      : super(email: email!, password: password!);
}

class SignInSuccess extends SignInState {}

class SignInError extends SignInState {}
