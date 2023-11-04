import 'package:flutter_modular/flutter_modular.dart';
import 'package:homesec_app/src/modules/auth/ui/pages/login_page.dart';
import 'package:homesec_app/src/shared/utils.dart';

class AuthModule extends Module {
  @override
  void routes(r) {
    r.child(Routes.loginPage(false), child: (context) {
      return const LoginPage();
    });
  }
}
