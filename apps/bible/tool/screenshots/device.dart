import 'package:flutter/material.dart';

import 'status_bar.dart';

enum ScreenshotDevice {
  iphone,
  ipad,
  pixel;

  TargetPlatform get platform => switch (this) {
    iphone || ipad => .iOS,
    pixel => .android,
  };

  Size get screenSize => switch (this) {
    iphone => Size(440, 956),
    ipad => Size(1032, 1376),
    pixel => Size(412, 915),
  };

  double get pixelRatio => switch (this) {
    iphone || pixel => 3,
    ipad => 2,
  };

  EdgeInsets get safeArea => switch (this) {
    iphone => .only(top: 62, bottom: 34),
    ipad => .only(top: 24, bottom: 20),
    pixel => .only(top: 40, bottom: 24),
  };

  // The frame keeps its physical size under zoom, so its point sizes shrink as the pixel ratio grows.
  double get screenRadius =>
      switch (this) {
        iphone => 62,
        ipad => 18,
        pixel => 36,
      } /
      zoom;

  double get bezelWidth =>
      switch (this) {
        iphone => 14,
        ipad => 20,
        pixel => 10,
      } /
      zoom;

  Rect? get cameraCutout => switch (this) {
    iphone => Rect.fromCenter(center: Offset(logicalScreenSize.width / 2, 29.5), width: 126, height: 37),
    ipad => null,
    pixel => Rect.fromCircle(center: Offset(logicalScreenSize.width / 2, 20), radius: 11),
  };

  Size get homeIndicatorSize => switch (this) {
    iphone => Size(146, 5),
    ipad => Size(320, 5),
    pixel => Size(108, 4),
  };

  CustomPainter get statusBarPainter => switch (this) {
    iphone => IphoneStatusBarPainter(island: cameraCutout!),
    ipad => IpadStatusBarPainter(height: safeArea.top),
    pixel => AndroidStatusBarPainter(height: safeArea.top),
  };

  // Like iPadOS Display Zoom, the iPad's content renders at 130% so it reads at a similar size to the phones beside it.
  // It raises the pixel ratio, since the reader's word hit-testing doesn't account for scale transforms.
  double get zoom => switch (this) {
    ipad => 1.3,
    iphone || pixel => 1,
  };

  Size get logicalScreenSize => screenSize / zoom;

  double get viewPixelRatio => pixelRatio * zoom;

  Size get frameSize => Size(logicalScreenSize.width + bezelWidth * 2, logicalScreenSize.height + bezelWidth * 2);

  MediaQueryData get mediaQuery => MediaQueryData(
    size: logicalScreenSize,
    devicePixelRatio: viewPixelRatio,
    padding: safeArea,
    viewPadding: safeArea,
  );
}

class DeviceFrame extends StatelessWidget {
  final ScreenshotDevice device;
  final GlobalKey screenKey;
  final Widget child;

  const DeviceFrame({super.key, required this.device, required this.screenKey, required this.child});

  @override
  Widget build(BuildContext context) => Container(
    width: device.frameSize.width,
    height: device.frameSize.height,
    padding: .all(device.bezelWidth),
    decoration: BoxDecoration(color: Colors.black, borderRadius: .circular(device.screenRadius + device.bezelWidth)),
    // A border in the background decoration would inset the screen by its width.
    foregroundDecoration: BoxDecoration(
      borderRadius: .circular(device.screenRadius + device.bezelWidth),
      border: .all(color: Color(0xFF4A4A4E), width: 2.5 / device.zoom),
    ),
    child: ClipRRect(
      borderRadius: .circular(device.screenRadius),
      child: RepaintBoundary(
        key: screenKey,
        child: DeviceScreen(device: device, child: child),
      ),
    ),
  );
}

class DeviceScreen extends StatelessWidget {
  final ScreenshotDevice device;
  final Widget child;

  const DeviceScreen({super.key, required this.device, required this.child});

  @override
  Widget build(BuildContext context) {
    final size = device.logicalScreenSize;
    final homeIndicator = device.homeIndicatorSize;
    return SizedBox.fromSize(
      size: size,
      child: Stack(
        children: [
          MediaQuery(data: device.mediaQuery, child: child),
          Positioned.fill(
            child: IgnorePointer(child: CustomPaint(painter: device.statusBarPainter)),
          ),
          if (device.cameraCutout case final cutout?)
            Positioned.fromRect(
              rect: cutout,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.black, borderRadius: .circular(cutout.height / 2)),
              ),
            ),
          Positioned(
            bottom: 8,
            left: (size.width - homeIndicator.width) / 2,
            child: Container(
              width: homeIndicator.width,
              height: homeIndicator.height,
              decoration: BoxDecoration(color: Colors.white, borderRadius: .circular(homeIndicator.height / 2)),
            ),
          ),
        ],
      ),
    );
  }
}
