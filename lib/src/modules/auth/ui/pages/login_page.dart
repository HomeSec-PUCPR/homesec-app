import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:homesec_app/src/modules/auth/interactor/stores/login_store.dart';

import '../../../../shared/ui/components/text_field.dart';
import '../../../../shared/utils.dart';
import '../../interactor/state/login_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final store = Modular.get<LoginStore>();

  Widget _buildForm() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 0),
            blurRadius: 12,
            color: Colors.black.withOpacity(0.5),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16)
          .copyWith(bottom: 16 + MediaQuery.viewPaddingOf(context).bottom),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "ENTRAR",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          AppTextFormField(
            label: "E-mail",
            hint: "name@example.com",
            keyboardType: TextInputType.emailAddress,
            onChanged: (v) {
              store.setEmail(v);
            },
          ),
          const SizedBox(height: 12),
          AppTextFormField(
            label: "Senha",
            hint: "*************",
            onChanged: (v) {
              store.setPassword(v);
            },
            obscureText: true,
          ),
          if (store.state.error != null) ...[
            const SizedBox(height: 8),
            Text(
              store.state.error!.message,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w300,
                color: Colors.red,
              ),
            )
          ],
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {},
                child: const Text("esqueci minha senha"),
              ),
              ElevatedButton(
                onPressed: () {
                  store.signIn();
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Theme.of(context).primaryColor,
                  ),
                  overlayColor: MaterialStateProperty.all(
                    Colors.white.withOpacity(0.15),
                  ),
                ),
                child: Text(
                  "ENTRAR",
                  style: TextStyle(color: AppColors.white),
                ),
              ),
            ],
          ),
          const Divider(),
          Center(
            child: TextButton(
              onPressed: () {},
              child: const Text("CRIE SUA CONTA"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32),
        child: Column(
          children: [
            Image.asset(AppIcons.logo),
            const SizedBox(height: 24),
            Expanded(child: SvgPicture.asset(AppIcons.mobile)),
            const SizedBox(height: 24),
            Text(
              "SEGURANÇA NA PALMA DA MÃO",
              style: TextStyle(
                fontSize: 20,
                color: AppColors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return Container(
      height: 390,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 0),
            blurRadius: 12,
            color: Colors.black.withOpacity(0.5),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildPage() {
    return SafeArea(
      bottom: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: _buildHeader()),
          ScopedBuilder<LoginStore, LoginState>(
            store: Modular.get<LoginStore>(),
            onState: (context, state) {
              return AnimatedCrossFade(
                firstChild: _buildForm(),
                secondChild: _buildLoading(),
                crossFadeState: state.loading
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: kThemeAnimationDuration,
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: _buildPage(),
    );
  }
}
