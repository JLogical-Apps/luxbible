import 'package:flutter/material.dart';

class TouchIndicator {
  final Offset position;
  final double scale;
  final double opacity;

  const TouchIndicator({required this.position, required this.scale, required this.opacity});
}

// Matches RocketSim's touch indicator: a translucent gray dot that grows in on touch down and fades out on release.
// Keep in step with tools/reels/lib/src/ffmpeg/touches.dart, which draws the same dot onto real recordings.
class TouchIndicatorOverlay extends StatelessWidget {
  final ValueNotifier<TouchIndicator?> indicator;

  const TouchIndicatorOverlay({super.key, required this.indicator});

  @override
  Widget build(BuildContext context) => IgnorePointer(
    child: ValueListenableBuilder(
      valueListenable: indicator,
      builder: (context, indicator, _) => CustomPaint(painter: TouchIndicatorPainter(indicator: indicator)),
    ),
  );
}

class TouchIndicatorPainter extends CustomPainter {
  static const diameter = 44.0;

  final TouchIndicator? indicator;

  TouchIndicatorPainter({required this.indicator});

  @override
  void paint(Canvas canvas, Size size) {
    if (indicator case final indicator?) {
      canvas.drawCircle(
        indicator.position,
        diameter / 2 * indicator.scale,
        Paint()..color = Color.fromRGBO(180, 180, 180, 0.8 * indicator.opacity),
      );
    }
  }

  @override
  bool shouldRepaint(TouchIndicatorPainter oldDelegate) => true;
}
