import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:homesec_app/src/shared/utils.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'HOMESEC',
      theme: AppTheme.theme(),
      routerConfig: Modular.routerConfig,
    );
  }
}
