import 'package:flutter/material.dart';

class TextFormGlobal extends StatelessWidget {
  const TextFormGlobal({
    Key? key,
    required this.controller,
    required this.text,
    required this.textInputType,
    required this.obscure,
    this.maxLength,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? text;
  final TextInputType? textInputType;
  final bool? obscure;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 55,
      child: TextFormField(
        controller: controller,
        keyboardType: textInputType,
        obscureText: obscure ?? false, // Mengatur nilai default untuk obscure
        maxLength: maxLength, // Mengatur panjang maksimum jika diberikan
        decoration: InputDecoration(
          hintText: text,
          border: InputBorder.none
        ),
      ),
    );
  }
}
