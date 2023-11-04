import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../shared/ui/components/text_field.dart';
import '../../../../shared/utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Widget _buildForm() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
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
          const AppTextFormField(
            label: "E-mail",
            hint: "name@example.com",
          ),
          const SizedBox(height: 12),
          const AppTextFormField(
            label: "Senha",
            hint: "*************",
            obscureText: true,
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {},
                child: const Text("esqueci minha senha"),
              ),
              ElevatedButton(
                onPressed: () {},
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

  Widget _buildPage() {
    return SafeArea(
      bottom: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: _buildHeader()),
          _buildForm(),
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
