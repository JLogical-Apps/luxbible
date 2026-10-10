import 'dart:math';

import 'package:flutter/material.dart';

enum AdventSilhouette {
  olive,
  stable;

  // Shapes extend below the base so they stay grounded on a slope. Overlapping pieces are separate paths so their
  // windings can't cancel out into holes. The random source varies each olive tree so a grove doesn't look
  // stamped out.
  List<Path> getPaths(Offset base, double size, Random random) => switch (this) {
    .olive => getOlivePaths(base, size, random),
    .stable => getStablePaths(base, size),
  };

  static List<Path> getOlivePaths(Offset base, double height, Random random) {
    final lean = (random.nextDouble() - 0.5) * height * 0.3;
    final spread = 0.85 + random.nextDouble() * 0.4;
    final crown = base + Offset(lean, -height * 0.5);
    final side = random.nextBool() ? 1 : -1;
    return [
      Path()
        ..moveTo(base.dx - height * 0.07, base.dy + height * 0.1)
        ..quadraticBezierTo(base.dx - lean * 0.4, base.dy - height * 0.25, crown.dx - height * 0.04, crown.dy)
        ..lineTo(crown.dx + height * 0.04, crown.dy)
        ..quadraticBezierTo(
          base.dx - lean * 0.4 + height * 0.1,
          base.dy - height * 0.25,
          base.dx + height * 0.07,
          base.dy + height * 0.1,
        )
        ..close(),
      [(-0.22, 0.0, 0.5, 0.4), (0.22, 0.02, 0.5, 0.38), (0.0, -0.22, 0.6, 0.5), (side * 0.32, -0.1, 0.34, 0.3)].fold(
        Path(),
        (path, puff) {
          final (x, y, width, puffHeight) = puff;
          return path..addOval(
            Rect.fromCenter(
              center: crown + Offset(x * spread, y + (random.nextDouble() - 0.5) * 0.06) * height,
              width: width * spread * height * (0.9 + random.nextDouble() * 0.2),
              height: puffHeight * height,
            ),
          );
        },
      ),
    ];
  }

  // A gabled shed with its roof beams crossed above the peak, like a nativity stable.
  static List<Path> getStablePaths(Offset base, double width) {
    final eaveY = base.dy - width * 0.38;
    final peak = Offset(base.dx, eaveY - width * 0.36);
    final slope = (width * 0.4) / (width * 0.62);
    return [
      Path()..addRect(Rect.fromLTRB(base.dx - width / 2, eaveY, base.dx + width / 2, base.dy + width * 0.3)),
      Path()
        ..moveTo(base.dx - width * 0.62, eaveY + width * 0.04)
        ..lineTo(peak.dx, peak.dy)
        ..lineTo(base.dx + width * 0.62, eaveY + width * 0.04)
        ..close(),
      ...[-1, 1].map(
        (side) => getBeamPath(
          peak + Offset(side * width * 0.3, width * 0.3 * slope),
          peak + Offset(-side * width * 0.12, -width * 0.12 * slope),
          thickness: width * 0.035,
        ),
      ),
    ];
  }

  static Path getBeamPath(Offset from, Offset to, {required double thickness}) {
    final direction = to - from;
    final normal = Offset(-direction.dy, direction.dx) / direction.distance * thickness / 2;
    return Path()..addPolygon([from + normal, to + normal, to - normal, from - normal], true);
  }
}
