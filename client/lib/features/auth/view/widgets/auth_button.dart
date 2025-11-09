import 'package:client/core/theme/app_palette.dart';
import 'package:client/features/auth/view/widgets/var_text.dart';
import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final VoidCallback onTap;
  final String label;
  const AuthButton({required this.onTap, required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Pallete.gradient2, Pallete.gradient1],
          begin: Alignment.bottomLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(40),
      ),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(500, 48),
          backgroundColor: Pallete.transparentColor,
          shadowColor: Pallete.transparentColor,
        ),

        child: VarText(text: label, size: 18, fontWeight: FontWeight.w600),
      ),
    );
  }
}
