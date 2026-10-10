import 'dart:math';

import 'package:bible/models/advent_stage.dart';
import 'package:bible/art/hooks/ambient_time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AdventCandles extends HookWidget {
  final double litCandles;
  final bool isComplete;

  const AdventCandles({super.key, required this.litCandles, required this.isComplete});

  @override
  Widget build(BuildContext context) => CustomPaint(
    painter: AdventCandlesPainter(litCandles: litCandles, isComplete: isComplete, time: useAmbientTime()),
    child: SizedBox.expand(),
  );
}

// Flames rise above the top of the box, so the parent shouldn't clip them.
class AdventCandlesPainter extends CustomPainter {
  final double litCandles;
  final bool isComplete;
  final double time;

  AdventCandlesPainter({required this.litCandles, required this.isComplete, required this.time});

  @override
  void paint(Canvas canvas, Size size) {
    final candleWidth = size.width / (AdventStage.candleCount * 2 - 1);
    final top = size.height * 0.35;
    final flameHeight = size.height * 0.32;

    for (final index in Iterable.generate(AdventStage.candleCount)) {
      final lit = isComplete ? 1.0 : (litCandles - index).clamp(0.0, 1.0);
      final centerX = index * candleWidth * 2 + candleWidth / 2;

      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(centerX - candleWidth / 2, top, candleWidth, size.height - top),
          Radius.circular(candleWidth * 0.25),
        ),
        Paint()..color = Color.lerp(Color(0xFFD6D3D1), Color(0xFFFEF3C7), lit)!.withValues(alpha: 0.4 + 0.6 * lit),
      );
      if (lit > 0) {
        paintFlame(
          canvas,
          centerX: centerX,
          top: top,
          candleWidth: candleWidth,
          height: flameHeight,
          index: index,
          lit: lit,
          time: time,
        );
      }
    }

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          -candleWidth * 0.6,
          size.height - candleWidth * 0.3,
          size.width + candleWidth * 1.2,
          candleWidth * 0.7,
        ),
        Radius.circular(candleWidth * 0.35),
      ),
      Paint()
        ..color = Color.lerp(
          Color(0xFF57534E),
          Color(0xFFCA8A04),
          isComplete ? 1 : litCandles / AdventStage.candleCount,
        )!,
    );
  }

  void paintFlame(
    Canvas canvas, {
    required double centerX,
    required double top,
    required double candleWidth,
    required double height,
    required int index,
    required double lit,
    required double time,
  }) {
    final flicker = 1 + 0.04 * sin(time * 3.1 + index * 1.7) + 0.02 * sin(time * 7.3 + index * 4.1);
    final sway = 0.025 * sin(time * 1.9 + index * 2.3);
    final glowCenter = Offset(centerX, top - height * 0.45);
    final glowRadius = height * 1.3 * (0.95 + 0.05 * flicker);

    canvas.drawCircle(
      glowCenter,
      glowRadius,
      Paint()
        ..shader = RadialGradient(
          colors: [
            Color(0xFFFCD34D).withValues(alpha: (0.5 + 0.05 * sin(time * 2.3 + index)) * lit),
            Color(0x00FCD34D),
          ],
        ).createShader(Rect.fromCircle(center: glowCenter, radius: glowRadius)),
    );

    // Heights are fractions of the flame height above the wick, and widths are fractions of the candle width.
    Path getFlamePath({
      required double tip,
      required double shoulder,
      required double hip,
      required double base,
      required double shoulderWidth,
      required double hipWidth,
    }) => Path()
      ..moveTo(centerX, top - height * tip)
      ..cubicTo(
        centerX + candleWidth * shoulderWidth,
        top - height * shoulder,
        centerX + candleWidth * hipWidth,
        top - height * hip,
        centerX,
        top - height * base,
      )
      ..cubicTo(
        centerX - candleWidth * hipWidth,
        top - height * hip,
        centerX - candleWidth * shoulderWidth,
        top - height * shoulder,
        centerX,
        top - height * tip,
      )
      ..close();

    canvas.save();
    canvas.translate(centerX, top);
    canvas.scale(1 + sway, flicker);
    canvas.skew(tan(sway * 60 * pi / 180), 0);
    canvas.translate(-centerX, -top);
    canvas.drawPath(
      getFlamePath(tip: 1, shoulder: 0.5, hip: 0.1, base: 0.08, shoulderWidth: 0.6, hipWidth: 0.45),
      Paint()..color = Color(0xFFFACC15).withValues(alpha: lit),
    );
    canvas.drawPath(
      getFlamePath(tip: 0.6, shoulder: 0.4, hip: 0.15, base: 0.12, shoulderWidth: 0.25, hipWidth: 0.2),
      Paint()..color = Color(0xFFFFF7ED).withValues(alpha: lit),
    );
    canvas.restore();
  }

  @override
  bool shouldRepaint(AdventCandlesPainter oldDelegate) =>
      oldDelegate.litCandles != litCandles || oldDelegate.isComplete != isComplete || oldDelegate.time != time;
}
