import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../utils.dart';

class StartupPage extends StatefulWidget {
  const StartupPage({super.key});

  @override
  State<StartupPage> createState() => _StartupPageState();
}

class _StartupPageState extends State<StartupPage> {
  @override
  void initState() {
    super.initState();
    pageFuture();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Image.asset(
          AppIcons.logo,
        ),
      ),
    );
  }

  Future<void> pageFuture() async {
    await Future.delayed(const Duration(seconds: 1), () {
      Modular.to.navigate(Routes.loginPage());
    });
  }
}
