import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final double? height;
  final double? width;
  final Color color;
  final IconData? icon;
  final Text? text;

  const CustomTextButton({
    super.key,
    required this.height,
    required this.width,
    required this.color,
    this.icon,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        color: color,
      ),
      child: Center(
        child: text,
      ),
    );
  }
}
