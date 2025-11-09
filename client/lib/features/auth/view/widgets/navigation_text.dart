import 'package:client/core/theme/app_palette.dart';
import 'package:client/features/auth/view/pages/login_page.dart';
import 'package:client/features/auth/view/pages/signup_page.dart';
import 'package:flutter/material.dart';

class NavigationText extends StatelessWidget {
  final String label1;
  final String label2;
  const NavigationText({required this.label1, required this.label2, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (label2 == "Login") {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
            (Route<dynamic> r)=>false,
          );
        } else {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const SignupPage()),
            (Route<dynamic> r)=>false,
          );
        }
      },
      child: RichText(
        text: TextSpan(
          text: label1,
          children: [
            TextSpan(
              text: label2,
              style: TextStyle(color: Pallete.gradient2),
            ),
          ],
        ),
      ),
    );
  }
}
