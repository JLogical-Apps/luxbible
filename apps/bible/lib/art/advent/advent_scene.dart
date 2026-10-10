import 'dart:math';

import 'package:bible/art/hooks/ambient_time.dart';
import 'package:bible/art/advent/advent_silhouettes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// Isaiah 9:2. A night sky over the hills that warms toward dawn as progress goes from 0 to 1, with the sun rising at 1.
// Each day pans the camera right, until the stable arrives under the guiding star where the sun rises.
class AdventScene extends HookWidget {
  final double progress;

  const AdventScene({super.key, required this.progress});

  @override
  // The sun starts below the hills, so the scene has to clip what it paints outside its box.
  Widget build(BuildContext context) => ClipRect(
    child: CustomPaint(
      painter: AdventScenePainter(progress: progress, time: useAmbientTime()),
      child: SizedBox.expand(),
    ),
  );
}

// Horizontal positions are in scene widths and silhouette sizes are in fractions of the scene's shorter side.
enum AdventHill {
  far,
  near;

  // How far the layer scrolls over the whole plan. The nearer layer scrolls further for parallax.
  double get pan => switch (this) {
    .far => 1.5,
    .near => 3,
  };

  double getHeight(double x) => switch (this) {
    .far => 0.8 + 0.05 * (0.65 * sin(x * 7 + 0.4) + 0.35 * sin(x * 12.7 + 0.8)),
    .near => 0.9 + 0.04 * (0.65 * sin(x * 6 + 2.1) + 0.35 * sin(x * 11.3 + 4)),
  };

  Color getColor(double progress) => switch (this) {
    .far => AdventScenePainter.ramp([
      (0, Color(0xFF1E1B4B)),
      (0.7, Color(0xFF581C87)),
      (1, Color(0xFF9A3412)),
    ], progress),
    .near => AdventScenePainter.getGroundColor(progress),
  };

  List<({double x, AdventSilhouette shape, double size})> get silhouettes => switch (this) {
    .far => [
      (x: 0.14, shape: .olive, size: 0.13),
      (x: 0.24, shape: .olive, size: 0.1),
      (x: 1.15, shape: .olive, size: 0.12),
      (x: 1.27, shape: .olive, size: 0.14),
      (x: 2.02, shape: .olive, size: 0.12),
      // Lands under the sun on the final day.
      (x: AdventScenePainter.sunX + pan, shape: .stable, size: 0.21),
    ],
    .near => [
      (x: 0.08, shape: .olive, size: 0.2),
      (x: 0.9, shape: .olive, size: 0.22),
      (x: 1.04, shape: .olive, size: 0.17),
      (x: 2.1, shape: .olive, size: 0.2),
      (x: 3.3, shape: .olive, size: 0.19),
    ],
  };
}

class AdventScenePainter extends CustomPainter {
  static const sunX = 0.75;
  static const starPan = 0.2;
  static const cloudPan = 0.6;

  final double progress;
  final double time;

  AdventScenePainter({required this.progress, required this.time});

  static Color getGroundColor(double progress) =>
      ramp([(0, Color(0xFF0B0A1A)), (0.7, Color(0xFF2E1065)), (1, Color(0xFF451A03))], progress);

  static Color ramp(List<(double, Color)> stops, double value) {
    final upperIndex = stops.indexWhere((stop) => stop.$1 >= value).clamp(1, stops.length - 1);
    final (lowerStop, lowerColor) = stops[upperIndex - 1];
    final (upperStop, upperColor) = stops[upperIndex];
    return Color.lerp(lowerColor, upperColor, ((value - lowerStop) / (upperStop - lowerStop)).clamp(0, 1))!;
  }

  static double fade(double value, double from, double to) => ((value - from) / (to - from)).clamp(0, 1);

  static double wave(double time, double period, [double phase = 0]) => sin((time / period + phase) * 2 * pi);

  static double lerp(double a, double b, double t) => a + (b - a) * t;

  // The four-pointed star from the Lux logo.
  static Path getLuxStarPath(Offset center, double radius) =>
      Iterable.generate(4, (turn) => turn * pi / 2).fold(Path()..moveTo(center.dx + radius, center.dy), (path, angle) {
        final [first, second, end] = [Offset(0.5367, 0.1714), Offset(0.1714, 0.5367), Offset(0, 1)]
            .map(
              (point) =>
                  center +
                  Offset(point.dx * cos(angle) - point.dy * sin(angle), point.dx * sin(angle) + point.dy * cos(angle)) *
                      radius,
            )
            .toList();
        return path..cubicTo(first.dx, first.dy, second.dx, second.dy, end.dx, end.dy);
      })..close();

  @override
  void paint(Canvas canvas, Size size) {
    final unit = min(size.width, size.height);
    final sunCenter = Offset(size.width * sunX, lerp(size.height * 1.25, size.height * 0.78, fade(progress, 0.75, 1)));

    paintSky(canvas, size);
    paintStars(canvas, size);
    paintGuidingStar(canvas, size, unit: unit);
    paintHorizonGlow(canvas, size, x: sunCenter.dx);
    paintRays(canvas, sunCenter, length: size.longestSide * 2, opacity: 0.2 * fade(progress, 0.63, 0.85));
    if (progress > 0.6) paintSun(canvas, sunCenter, unit: unit);
    paintClouds(canvas, size);
    for (final hill in AdventHill.values) {
      paintHill(canvas, size, hill, unit: unit);
    }
  }

  void paintSky(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    canvas.drawRect(
      rect,
      Paint()
        ..shader = LinearGradient(
          begin: .topCenter,
          end: .bottomCenter,
          colors: [
            ramp([
              (0, Color(0xFF020617)),
              (0.5, Color(0xFF1E1B4B)),
              (0.82, Color(0xFF4C1D95)),
              (1, Color(0xFF9A3412)),
            ], progress),
            ramp([
              (0, Color(0xFF1E1B4B)),
              (0.5, Color(0xFF3B0764)),
              (0.82, Color(0xFFC2410C)),
              (1, Color(0xFFFBBF24)),
            ], progress),
          ],
        ).createShader(rect),
    );
  }

  // Every fourth star is a small Lux star that swells as it twinkles. The rest are dots.
  void paintStars(Canvas canvas, Size size) {
    final visibility = 1 - fade(progress, 0.3, 0.95);
    if (visibility == 0) return;

    final random = Random(7);
    final radiusScale = (size.width / 200).clamp(1.0, 1.2);
    for (final index in Iterable.generate(max(12, size.width ~/ 8))) {
      final position = Offset(
        ((random.nextDouble() - progress * starPan) % 1) * size.width,
        random.nextDouble() * size.height * 0.7,
      );
      final twinkle = pow(0.5 + 0.5 * wave(time, 1.5 + random.nextDouble() * 3, random.nextDouble()), 2).toDouble();
      final paint = Paint()..color = Colors.white.withValues(alpha: visibility * lerp(0.15, 1, twinkle));
      if (index % 4 == 0) {
        canvas.drawPath(
          getLuxStarPath(position, (1.6 + random.nextDouble()) * radiusScale * lerp(0.55, 1.15, twinkle)),
          paint,
        );
      } else {
        canvas.drawCircle(position, (0.4 + random.nextDouble() * 0.7) * radiusScale, paint);
      }
    }
  }

  // Matthew 2:9. Hangs over where the stable will be and fades as the sun rises behind it.
  void paintGuidingStar(Canvas canvas, Size size, {required double unit}) {
    final visibility = 1 - fade(progress, 0.8, 0.97);
    if (visibility == 0) return;

    final center = Offset(size.width * sunX, size.height * 0.18);
    final pulse = 1 + 0.06 * wave(time, 3);
    final glowRadius = unit * 0.3 * pulse;
    canvas.drawCircle(
      center,
      glowRadius,
      Paint()
        ..shader = RadialGradient(
          colors: [
            Color(0xFFFEF3C7).withValues(alpha: 0.45 * visibility),
            Color(0x00FEF3C7),
          ],
        ).createShader(Rect.fromCircle(center: center, radius: glowRadius)),
    );
    canvas.drawPath(
      getLuxStarPath(center, unit * 0.09 * pulse),
      Paint()..color = Colors.white.withValues(alpha: visibility),
    );
  }

  // A soft elliptical glow, so the warmth fades into the sky instead of ending at a hard edge.
  void paintHorizonGlow(Canvas canvas, Size size, {required double x}) {
    final radius = size.width;
    final color = Color(0xFFF97316).withValues(alpha: 0.55 * fade(progress, 0.05, 0.9) * (1 + 0.15 * wave(time, 7)));
    canvas.save();
    canvas.translate(x, size.height * 0.85);
    canvas.scale(1, size.height * 0.55 / radius);
    canvas.drawCircle(
      Offset.zero,
      radius,
      Paint()
        ..shader = RadialGradient(
          colors: [color, color.withValues(alpha: 0)],
        ).createShader(Rect.fromCircle(center: Offset.zero, radius: radius)),
    );
    canvas.restore();
  }

  void paintRays(Canvas canvas, Offset center, {required double length, required double opacity}) {
    if (opacity == 0) return;

    const rayCount = 14;
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(time * 4 * pi / 180);
    for (final index in Iterable.generate(rayCount)) {
      final angle = index / rayCount * 2 * pi;
      final spread = (index.isOdd ? 0.045 : 0.07) * (1 + 0.15 * wave(time, 5, index / rayCount));
      canvas.drawPath(
        Path()
          ..moveTo(0, 0)
          ..lineTo(cos(angle - spread) * length, sin(angle - spread) * length)
          ..lineTo(cos(angle + spread) * length, sin(angle + spread) * length)
          ..close(),
        Paint()..color = Color(0xFFFFFBEB).withValues(alpha: opacity * (0.7 + 0.3 * wave(time, 4, index / 3))),
      );
    }
    canvas.restore();
  }

  void paintSun(Canvas canvas, Offset center, {required double unit}) {
    final breathe = 1 + 0.04 * wave(time, 6);
    final haloOpacity = fade(progress, 0.7, 1);
    canvas.drawCircle(
      center,
      unit * 0.75 * breathe,
      Paint()..color = Color(0xFFFACC14).withValues(alpha: 0.18 * haloOpacity),
    );
    canvas.drawCircle(
      center,
      unit * 0.5 * breathe,
      Paint()..color = Color(0xFFFACC14).withValues(alpha: 0.25 * haloOpacity),
    );
    canvas.drawCircle(
      center,
      unit * 0.28,
      Paint()..color = Color.lerp(Color(0xFFEA580C), Color(0xFFFDE047), fade(progress, 0.8, 1))!,
    );
  }

  // Each cloud is three overlapping ovals in one path, so the overlaps don't double up the opacity. Clouds drift and
  // bob over time, and their puffs shift against each other so the shapes slowly change.
  void paintClouds(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = ramp([
        (0, Color(0xFF6366F1)),
        (0.6, Color(0xFFA78BFA)),
        (0.85, Color(0xFFFDBA74)),
        (1, Color(0xFFFEF3C7)),
      ], progress).withValues(alpha: 0.2 + 0.2 * progress);

    for (final (start, y, width, speed) in [
      (0.1, 0.6, 0.22, 0.024),
      (0.6, 0.68, 0.3, 0.016),
      (1.1, 0.54, 0.18, 0.032),
    ]) {
      final x = ((start + time * speed - progress * cloudPan) % 1.6 - 0.3) * size.width;
      final radius = size.width * width;
      final centerY = size.height * (y + 0.012 * wave(time, 11, start));
      final shift = radius * 0.06 * wave(time, 8, start);
      canvas.drawPath(
        Path()
          ..addOval(Rect.fromCenter(center: Offset(x, centerY), width: radius * 2, height: size.height * 0.036))
          ..addOval(
            Rect.fromCenter(
              center: Offset(x - radius * 0.3 + shift, centerY - size.height * 0.015),
              width: radius * 0.7,
              height: size.height * 0.06,
            ),
          )
          ..addOval(
            Rect.fromCenter(
              center: Offset(x + radius * 0.12 - shift, centerY - size.height * 0.025),
              width: radius * 0.6,
              height: size.height * 0.08,
            ),
          ),
        paint,
      );
    }
  }

  void paintHill(Canvas canvas, Size size, AdventHill hill, {required double unit}) {
    final offset = progress * hill.pan;
    double getGroundY(double screenX) => hill.getHeight(screenX / size.width + offset) * size.height;
    final paint = Paint()..color = hill.getColor(progress);

    canvas.drawPath(
      Iterable.generate(
          65,
          (index) => index / 64 * size.width,
        ).fold(Path()..moveTo(0, size.height), (path, x) => path..lineTo(x, getGroundY(x)))
        ..lineTo(size.width, size.height)
        ..close(),
      paint,
    );
    for (final silhouette in hill.silhouettes) {
      final x = (silhouette.x - offset) * size.width;
      for (final path in silhouette.shape.getPaths(
        Offset(x, getGroundY(x)),
        silhouette.size * unit,
        Random((silhouette.x * 1000).round()),
      )) {
        canvas.drawPath(path, paint);
      }
    }
  }

  @override
  bool shouldRepaint(AdventScenePainter oldDelegate) => oldDelegate.progress != progress || oldDelegate.time != time;
}
