import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../../../shared/interactor/services/auth_service.dart';
import '../../../../shared/utils.dart';
import '../state/login_state.dart';

class LoginStore extends Store<LoginState> {
  final AuthService _authService;
  LoginStore(this._authService) : super(LoginState.init());

  void setEmail(String email) {
    update(state.setEmail(email));
  }

  void setPassword(String password) {
    update(state.setPassword(password));
  }

  Future<void> signIn() async {
    update(state.setLoading());
    final result = await _authService.signIn(
      email: state.email,
      password: state.password,
    );
    result.fold((l) {
      update(state.setError(l));
    }, (r) {
      update(state.setEmail(state.email));
      if (r) {
        Modular.to.navigate(Routes.homePage());
      }
    });
  }
}
