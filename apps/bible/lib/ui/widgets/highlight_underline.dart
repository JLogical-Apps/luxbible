import 'dart:math';

import 'package:flutter/material.dart';

class HighlightUnderline extends StatelessWidget {
  final Color color;
  final bool wavy;
  final double thickness;

  const HighlightUnderline({super.key, required this.color, required this.wavy, this.thickness = 4});

  @override
  Widget build(BuildContext context) => TweenAnimationBuilder(
    duration: Duration(milliseconds: 300),
    curve: Curves.easeInOutCubic,
    tween: ColorTween(begin: color, end: color),
    builder: (context, color, child) => CustomPaint(
      size: .infinite,
      painter: _HighlightUnderlinePainter(color: color ?? this.color, wavy: wavy, thickness: thickness),
    ),
  );
}

class _HighlightUnderlinePainter extends CustomPainter {
  final Color color;
  final bool wavy;
  final double thickness;

  const _HighlightUnderlinePainter({required this.color, required this.wavy, required this.thickness});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = thickness
      ..strokeCap = .round
      ..strokeJoin = .round
      ..style = .stroke;

    if (!wavy) {
      final y = size.height - thickness / 2;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
      return;
    }

    final amplitude = thickness * 0.55;
    final wavelength = thickness * 3;
    final centerY = size.height - amplitude;
    final path = Path()..moveTo(0, centerY - amplitude * cos(2 * pi * 6 / wavelength));
    for (var x = 0.0; x <= size.width; x += 1) {
      path.lineTo(x, centerY - amplitude * cos(2 * pi * (x + 6) / wavelength));
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_HighlightUnderlinePainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.wavy != wavy || oldDelegate.thickness != thickness;
}
