import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lux/lux.dart';

final statusBarPaint = Paint()..color = Colors.white;
final dimmedStatusBarPaint = Paint()..color = Colors.white.withValues(alpha: 0.4);

TextPainter layoutStatusText(String text, {required double fontSize, bool isApple = true}) => TextPainter(
  text: TextSpan(
    text: text,
    style: TextStyle(
      // Apple's SF Pro license only allows it in mock-ups of apps for Apple platforms.
      fontFamily: isApple ? 'SF Pro Text' : 'Inter',
      fontFamilyFallback: ['Inter'],
      fontSize: fontSize,
      fontWeight: .w600,
      color: Colors.white,
      letterSpacing: isApple ? -0.4 : 0,
    ),
  ),
  textDirection: .ltr,
)..layout();

final iosSignalWidth = 18.0;
final iosWifiWidth = 16.0;
final iosBatteryWidth = 27.5;

void paintIosSignal(Canvas canvas, double left, double centerY) {
  final barWidth = 3.0;
  final barGap = (iosSignalWidth - barWidth * 4) / 3;
  for (final index in Range.generate(0, 3)) {
    final barHeight = 4.5 + index * 2.5;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(left + index * (barWidth + barGap), centerY + 6 - barHeight, barWidth, barHeight),
        Radius.circular(1),
      ),
      statusBarPaint,
    );
  }
}

void paintIosWifi(Canvas canvas, double left, double centerY) {
  final center = Offset(left + iosWifiWidth / 2, centerY + 5.5);
  canvas.drawPath(
    Path()
      ..moveTo(center.dx, center.dy)
      ..arcTo(Rect.fromCircle(center: center, radius: 3.8), -pi * 3 / 4, pi / 2, false)
      ..close(),
    statusBarPaint,
  );
  final arcPaint = Paint()
    ..color = Colors.white
    ..style = .stroke
    ..strokeWidth = 2.3
    ..strokeCap = .round;
  for (final radius in [7.6, 11.4]) {
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi * 0.72, pi * 0.44, false, arcPaint);
  }
}

void paintIosBattery(Canvas canvas, double left, double centerY) {
  final battery = RRect.fromRectAndRadius(Rect.fromLTWH(left, centerY - 6.5, 25, 13), Radius.circular(4.2));
  canvas.drawRRect(
    battery,
    Paint()
      ..color = Colors.white.withValues(alpha: 0.4)
      ..style = .stroke
      ..strokeWidth = 1,
  );
  canvas.drawRRect(battery.deflate(2), statusBarPaint);
  canvas.drawRRect(
    RRect.fromRectAndCorners(
      Rect.fromLTWH(left + 26, centerY - 2.25, 1.5, 4.5),
      topRight: Radius.circular(1),
      bottomRight: Radius.circular(1),
    ),
    dimmedStatusBarPaint,
  );
}

class IphoneStatusBarPainter extends CustomPainter {
  final Rect island;

  IphoneStatusBarPainter({required this.island});

  @override
  void paint(Canvas canvas, Size size) {
    final centerY = island.center.dy;

    final time = layoutStatusText('3:16', fontSize: 17);
    time.paint(canvas, Offset(island.left / 2 - time.width / 2, centerY - time.height / 2));

    final spacing = 6.0;
    final iconsWidth = iosSignalWidth + iosWifiWidth + iosBatteryWidth + spacing * 2;
    final left = island.right + (size.width - island.right) / 2 - iconsWidth / 2;
    paintIosSignal(canvas, left, centerY);
    paintIosWifi(canvas, left + iosSignalWidth + spacing, centerY);
    paintIosBattery(canvas, left + iosSignalWidth + iosWifiWidth + spacing * 2, centerY);
  }

  @override
  bool shouldRepaint(IphoneStatusBarPainter oldDelegate) => oldDelegate.island != island;
}

class IpadStatusBarPainter extends CustomPainter {
  final double height;

  IpadStatusBarPainter({required this.height});

  @override
  void paint(Canvas canvas, Size size) {
    final centerY = height / 2 + 2;
    final horizontalPadding = 24.0;
    final spacing = 6.0;

    final time = layoutStatusText('3:16 AM   Thu Jul 16', fontSize: 13);
    time.paint(canvas, Offset(horizontalPadding, centerY - time.height / 2));

    final percent = layoutStatusText('100%', fontSize: 13);
    final batteryLeft = size.width - horizontalPadding - iosBatteryWidth;
    final percentLeft = batteryLeft - spacing - percent.width;
    paintIosBattery(canvas, batteryLeft, centerY);
    percent.paint(canvas, Offset(percentLeft, centerY - percent.height / 2));
    paintIosWifi(canvas, percentLeft - spacing - iosWifiWidth, centerY);
  }

  @override
  bool shouldRepaint(IpadStatusBarPainter oldDelegate) => oldDelegate.height != height;
}

class AndroidStatusBarPainter extends CustomPainter {
  final double height;

  AndroidStatusBarPainter({required this.height});

  @override
  void paint(Canvas canvas, Size size) {
    final centerY = height / 2;
    final horizontalPadding = 26.0;
    final spacing = 7.0;

    final time = layoutStatusText('3:16', fontSize: 15, isApple: false);
    time.paint(canvas, Offset(horizontalPadding, centerY - time.height / 2));

    final batteryWidth = 9.0;
    final batteryLeft = size.width - horizontalPadding - batteryWidth;
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(batteryLeft, centerY - 7, batteryWidth, 15), Radius.circular(2)),
      statusBarPaint,
    );
    canvas.drawRect(Rect.fromLTWH(batteryLeft + 2.5, centerY - 8.5, 4, 1.5), statusBarPaint);

    final signalSize = 14.0;
    final signalRight = batteryLeft - spacing;
    canvas.drawPath(
      Path()
        ..moveTo(signalRight - signalSize, centerY + 7)
        ..lineTo(signalRight, centerY + 7)
        ..lineTo(signalRight, centerY + 7 - signalSize)
        ..close(),
      statusBarPaint,
    );

    final wifiCenter = Offset(signalRight - signalSize - spacing - 9, centerY + 7);
    canvas.drawPath(
      Path()
        ..moveTo(wifiCenter.dx, wifiCenter.dy)
        ..arcTo(Rect.fromCircle(center: wifiCenter, radius: 13), -pi * 3 / 4, pi / 2, false)
        ..close(),
      statusBarPaint,
    );
  }

  @override
  bool shouldRepaint(AndroidStatusBarPainter oldDelegate) => oldDelegate.height != height;
}
