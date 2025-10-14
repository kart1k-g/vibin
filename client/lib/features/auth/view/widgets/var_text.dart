import 'package:flutter/material.dart';

class VarText extends StatelessWidget {
  final String text;
  final double size;
  final FontWeight fontWeight;
  const VarText({this.fontWeight=FontWeight.bold,required this.text, required this.size,super.key});
  

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        fontWeight: fontWeight,
        
      ),
    );
  }
}