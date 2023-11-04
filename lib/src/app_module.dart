import 'package:flutter_modular/flutter_modular.dart';
import 'package:homesec_app/src/modules/auth/auth_module.dart';
import 'package:homesec_app/src/shared/ui/pages/startup_page.dart';

import 'shared/utils.dart';

class AppModule extends Module {
  @override
  void routes(r) {
    r.child(Routes.startupPage(false), child: (context) {
      return const StartupPage();
    });
    r.module(Routes.authModule(false), module: AuthModule());
  }
}
