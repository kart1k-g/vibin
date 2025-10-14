import 'package:client/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

class NavigationText extends StatelessWidget {
  final String label1;
  final String label2;
  const NavigationText({required this.label1, required this.label2, super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: label1,
        children: [TextSpan(text: label2, style: TextStyle(color: Pallete.gradient2))],
      ),
    );
  }
}
