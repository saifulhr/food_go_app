import 'package:flutter/material.dart';

class CustomProductButoon extends StatelessWidget {
  final double? height;
  final double? width;
  final Color color;
  final IconData icon;
  final VoidCallback onTap;

  const CustomProductButoon({
    super.key,
    this.height = 40.0,
    this.width = 40.0,
    required this.color,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          color: color,
        ),
        child: Icon(
          icon,
          color: Colors.white,
          fontWeight: FontWeight.bold,
          size: 20,
        ),
      ),
    );
  }
}
