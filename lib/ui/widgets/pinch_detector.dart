import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class PinchDetector extends StatelessWidget {
  final GestureScaleStartCallback? onStart;
  final GestureScaleUpdateCallback? onUpdate;
  final Widget child;

  const PinchDetector({super.key, this.onStart, this.onUpdate, required this.child});

  @override
  Widget build(BuildContext context) => RawGestureDetector(
    gestures: {
      _TwoFingerScaleGestureRecognizer: GestureRecognizerFactoryWithHandlers<_TwoFingerScaleGestureRecognizer>(
        _TwoFingerScaleGestureRecognizer.new,
        (recognizer) => recognizer
          ..onStart = onStart
          ..onUpdate = onUpdate,
      ),
    },
    child: child,
  );
}

class _TwoFingerScaleGestureRecognizer extends ScaleGestureRecognizer {
  @override
  void handleEvent(PointerEvent event) {
    super.handleEvent(event);
    if (event is PointerDownEvent && pointerCount >= 2) {
      resolve(.accepted);
    }
  }
}
