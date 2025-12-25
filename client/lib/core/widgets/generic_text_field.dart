import 'package:flutter/material.dart';

class GenericTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController? controller;
  final bool readOnly;
  final VoidCallback? onTap;
  const GenericTextField({
    super.key,
    required this.hintText,
    this.obscureText = false,
    this.controller,
    this.readOnly = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(hintText: hintText),
      obscureText: obscureText,
      controller: controller,
      readOnly: readOnly,
      onTap: onTap,
      validator: (value) {
        if (value!.trim().isEmpty) {
          return "$hintText is missing";
        } else {
          return null;
        }
      },
    );
  }
}
