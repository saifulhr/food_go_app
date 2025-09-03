import 'package:flutter/material.dart';

class TextFeilds extends StatelessWidget {
  final String hintText;
  final IconData? icon;
  final bool isPassword;
  final TextEditingController controller;

  const TextFeilds({
    super.key,
    required this.hintText,
    this.icon,
    this.isPassword = false,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[100],
          hintText: hintText,
          prefixIcon: Icon(icon, color: const Color(0XFFef2a39)),
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
