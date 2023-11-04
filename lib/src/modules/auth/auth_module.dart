import 'package:flutter_modular/flutter_modular.dart';
import 'package:homesec_app/src/modules/auth/interactor/stores/login_store.dart';
import 'package:homesec_app/src/modules/auth/ui/pages/login_page.dart';
import 'package:homesec_app/src/shared/utils.dart';

import '../../app_module.dart';

class AuthModule extends Module {
  @override
  void binds(i) {
    i.addLazySingleton(LoginStore.new);
  }

  @override
  List<Module> get imports => [
        AppModule(),
      ];

  @override
  void routes(r) {
    r.child(Routes.loginPage(false), child: (context) {
      return const LoginPage();
    });
  }
}
