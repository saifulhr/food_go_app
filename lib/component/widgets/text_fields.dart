import 'package:flutter/material.dart';

class TextFields extends StatelessWidget {
  final String hintText;
  final IconData? icon;
  final bool isPassword;
  final TextEditingController controller;
  final TextInputType inputType;
  final int maxLines;

  const TextFields({
    super.key,
    required this.hintText,
    this.icon,
    this.isPassword = false,
    required this.controller,
    this.inputType = TextInputType.text,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        keyboardType: inputType,
        maxLines: maxLines,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[100],
          hintText: hintText,
          prefixIcon: icon != null
              ? Icon(icon, color: const Color(0XFFef2a39))
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 3,
            vertical: 10,
          ),
        ),
      ),
    );
  }
}
