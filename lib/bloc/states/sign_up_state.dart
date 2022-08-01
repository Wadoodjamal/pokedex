class SignUpState {
  final String name;
  bool get isNameValid => name.length > 3;
  final String password;
  bool get isPasswordValid => password.length > 7;
  final String email;
  bool get isEmailValid => email.contains('@');

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
