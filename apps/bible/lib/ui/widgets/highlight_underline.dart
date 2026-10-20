import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lux/lux.dart';

enum HighlightUnderlineType { straight, dashed, double, wavy }

class HighlightUnderline extends StatelessWidget {
  final Color color;
  final HighlightUnderlineType type;
  final double thickness;

  const HighlightUnderline({super.key, required this.color, required this.type, this.thickness = 4});

  @override
  Widget build(BuildContext context) => TweenAnimationBuilder(
    duration: Duration(milliseconds: 300),
    curve: Curves.easeInOutCubic,
    tween: ColorTween(begin: color, end: color),
    builder: (context, color, child) => CustomPaint(
      size: .infinite,
      painter: _HighlightUnderlinePainter(color: color ?? this.color, type: type, thickness: thickness),
    ),
  );
}

class _HighlightUnderlinePainter extends CustomPainter {
  final Color color;
  final HighlightUnderlineType type;
  final double thickness;

  const _HighlightUnderlinePainter({required this.color, required this.type, required this.thickness});

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = type == .double ? thickness * 0.6 : thickness;
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = .round
      ..strokeJoin = .round
      ..style = .stroke;
    final bottomY = size.height - strokeWidth / 2;

    switch (type) {
      case .straight:
        canvas.drawLine(Offset(0, bottomY), Offset(size.width, bottomY), paint);
      case .dashed:
        // Dashes stretch to fit so the line starts and ends on a full dash at any width.
        final dashCount = max(1, ((size.width + thickness) / (thickness * 2.5)).round());
        final period = size.width / (dashCount - 0.4);
        final dashLength = period * 0.6;
        for (final startX in Range.generate(0, dashCount - 1).map((index) => index * period)) {
          // Round caps extend past each end by half the stroke, so inset the segment to keep the dash in bounds.
          canvas.drawLine(
            Offset(startX + strokeWidth / 2, bottomY),
            Offset(startX + dashLength - strokeWidth / 2, bottomY),
            paint,
          );
        }
      case .double:
        // Starts where a straight underline starts, so the second line hangs below instead of crowding the text.
        final topY = size.height - thickness + strokeWidth / 2;
        for (final y in [topY, topY + strokeWidth * 2]) {
          canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
        }
      case .wavy:
        final amplitude = thickness * 0.55;
        final wavelength = thickness * 3;
        final centerY = size.height - amplitude;
        final path = Path()..moveTo(0, centerY - amplitude * cos(2 * pi * 6 / wavelength));
        for (var x = 0.0; x <= size.width; x += 1) {
          path.lineTo(x, centerY - amplitude * cos(2 * pi * (x + 6) / wavelength));
        }
        canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(_HighlightUnderlinePainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.type != type || oldDelegate.thickness != thickness;
}
