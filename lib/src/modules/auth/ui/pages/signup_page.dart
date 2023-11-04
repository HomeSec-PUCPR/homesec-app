import 'package:flutter/material.dart';
import 'package:homesec_app/src/shared/ui/components/text_field.dart';
import 'package:homesec_app/src/shared/utils.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 1,
      title: const Text("Criar conta"),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          AppTextFormField(
            label: "Nome completo",
            onChanged: (v) {},
          ),
          const SizedBox(height: 16),
          AppTextFormField(
            label: "E-mail",
            keyboardType: TextInputType.emailAddress,
            onChanged: (v) {},
          ),
          const SizedBox(height: 16),
          AppTextFormField(
            label: "Data de Nascimento",
            onChanged: (v) {},
          ),
          const SizedBox(height: 16),
          AppTextFormField(
            label: "Senha",
            onChanged: (v) {},
            obscureText: true,
          ),
          const SizedBox(height: 16),
          AppTextFormField(
            label: "Confirmar senha",
            onChanged: (v) {},
            obscureText: true,
          ),
        ],
      ),
    );
  }

  Widget _buildCreate() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 2),
            blurRadius: 4,
            color: Colors.black.withOpacity(0.15),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16)
          .copyWith(bottom: MediaQuery.viewPaddingOf(context).bottom),
      child: ElevatedButton(
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
          "Criar conta",
          style: TextStyle(color: AppColors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: _buildCreate(),
    );
  }
}
