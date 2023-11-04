import '../../data/error/login_error.dart';

class LoginState {
  final String email;
  final String password;
  final bool loading;
  final LoginError? error;

  LoginState({
    required this.email,
    required this.password,
    this.loading = false,
    this.error,
  });

  factory LoginState.init() {
    return InitialLoginState();
  }

  LoginState setEmail(String email) {
    return UpdateLoginState(email: email, password: password);
  }

  LoginState setPassword(String password) {
    return UpdateLoginState(email: email, password: password);
  }

  LoginState setLoading() {
    return LoadingLoginState(email: email, password: password);
  }

  LoginState setError(LoginError error) {
    return ErrorLoginState(email: email, password: password, error: error);
  }
}

class InitialLoginState extends LoginState {
  InitialLoginState() : super(email: "", password: "");
}

class UpdateLoginState extends LoginState {
  UpdateLoginState({required super.email, required super.password});
}

class LoadingLoginState extends LoginState {
  LoadingLoginState({required super.email, required super.password})
      : super(loading: true);
}

class ErrorLoginState extends LoginState {
  ErrorLoginState({
    required super.email,
    required super.password,
    required super.error,
  });
}
