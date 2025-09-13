import 'package:flutter/material.dart';

class CustomThumbShape extends SliderComponentShape {
  const CustomThumbShape();

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) => const Size(16, 30);

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final canvas = context.canvas;

    final shiftedCenter = Offset(center.dx + 7, center.dy);
    final paint = Paint()
      ..color = sliderTheme.thumbColor!
      ..style = PaintingStyle.fill;

    final thumbRect = Rect.fromCenter(
      center: shiftedCenter,
      width: 9,
      height: 14,
    );
    final thumbRRect = RRect.fromRectAndRadius(
      thumbRect,
      const Radius.circular(3),
    );

    canvas.drawRRect(thumbRRect, paint);
  }
}
