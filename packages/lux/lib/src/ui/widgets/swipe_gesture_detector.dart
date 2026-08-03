import 'package:flutter/material.dart';

class SwipeGestureDetector extends StatelessWidget {
  final int Function() index;
  final int maxIndex;
  final Function(int) onSwipe;

  final Widget? child;

  const SwipeGestureDetector({
    super.key,
    required this.index,
    required this.maxIndex,
    required this.onSwipe,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        final delta = details.velocity.pixelsPerSecond;
        const sensitivity = 8;

        final newIndex = delta.dx > sensitivity
            ? index() - 1
            : delta.dx < -sensitivity
            ? index() + 1
            : null;

        if (newIndex == null || newIndex < 0 || newIndex >= maxIndex) {
          return;
        }

        onSwipe(newIndex);
      },
      child: child,
    );
  }
}
