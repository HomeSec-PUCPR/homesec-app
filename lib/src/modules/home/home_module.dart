import 'package:flutter_modular/flutter_modular.dart';
import 'package:homesec_app/src/app_module.dart';
import 'package:homesec_app/src/modules/home/interactor/stores/home_store.dart';
import 'package:homesec_app/src/modules/home/ui/pages/home_page.dart';

import '../../shared/utils.dart';

class HomeModule extends Module {
  @override
  void binds(i) {
    i.addLazySingleton(HomeStore.new);
  }

  @override
  List<Module> get imports => [
        AppModule(),
      ];

  @override
  void routes(r) {
    r.child(Routes.homePage(false), child: (context) => const HomePage());
  }
}
