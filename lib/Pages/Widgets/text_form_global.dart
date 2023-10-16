import 'package:flutter/material.dart';


class TextFormGlobal extends StatelessWidget {
  const TextFormGlobal({Key? key, required this.controller, required this.text, required this.textInputType, required this.obscure}) : super(key: key);
  final TextEditingController controller;
  final String text;
  final TextInputType textInputType;
  final bool obscure;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: TextFormField(
        controller: controller,
        keyboardType: textInputType,
        obscureText: obscure,
        decoration:  InputDecoration(
          hintText: text,
          
        ),
      ),
    );
  }
}