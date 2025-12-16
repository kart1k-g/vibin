
import 'package:flutter/material.dart';

class GenericTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  const GenericTextField({
    super.key,
    required this.hintText,
    this.obscureText = false,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(hintText: hintText),
      obscureText: obscureText,
      controller: controller,
      validator: (value) {
        if (value!.trim().isEmpty) {
          print("1");
          return "$hintText is missing";
        } else {
          print("2");
          return null;
        }
      },
    );
  }
}
