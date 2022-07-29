class SignUpState {
  final String name;
  final String password;
  final String email;

  SignUpState({
    this.name = '',
    this.password = '',
    this.email = '',
  });

  SignUpState copyWith({
    String? name,
    String? password,
    String? email,
  }) {
    return SignUpState(
      name: name ?? this.name,
      password: password ?? this.password,
      email: email ?? this.email,
    );
  }
}

class SignUpStateInitial extends SignUpState {
  SignUpStateInitial() : super();
}

class SignUpStateLoading extends SignUpState {
  SignUpStateLoading({String? email, String? password, String? name})
      : super(email: email!, password: password!, name: name!);
}

class SignUpStateSuccess extends SignUpState {
  SignUpStateSuccess() : super();
}

class SignUpStateFailure extends SignUpState {
  SignUpStateFailure() : super();
}

class SignUpStateSwitchToSignIn extends SignUpState {
  SignUpStateSwitchToSignIn() : super();
}
