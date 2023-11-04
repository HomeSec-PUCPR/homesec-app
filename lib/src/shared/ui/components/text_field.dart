import 'package:flutter/material.dart';

class AppTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? initialValue;
  final String? label;
  final String? hint;
  final bool obscureText;
  const AppTextFormField({
    super.key,
    this.controller,
    this.initialValue,
    this.label,
    this.hint,
    this.obscureText = false,
  });

  InputDecoration get _decoration {
    return InputDecoration(
      contentPadding: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
      fillColor: Colors.white,
      filled: true,
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      hintText: hint,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: 8),
        ],
        TextFormField(
          initialValue: initialValue,
          decoration: _decoration,
          obscureText: obscureText,
        ),
      ],
    );
  }
}
