import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ResizableContainer extends HookWidget {
  final Widget child;
  final double height;
  final double minHeight;
  final double maxHeight;

  final Function(double) onHeightUpdated;
  final Function()? onResizeStart;
  final Function()? onResizeEnd;

  const ResizableContainer({
    super.key,
    required this.child,
    required this.height,
    required this.minHeight,
    required this.maxHeight,
    required this.onHeightUpdated,
    this.onResizeStart,
    this.onResizeEnd,
  });

  @override
  Widget build(BuildContext context) {
    final isResizingState = useState(false);
    final dragStartHeightRef = useRef(0.0);
    final dragStartYRef = useRef(0.0);
    final height = this.height.clamp(minHeight, maxHeight);

    return GestureDetector(
      onVerticalDragStart: (details) {
        isResizingState.value = true;
        onResizeStart?.call();
        dragStartHeightRef.value = height;
        dragStartYRef.value = details.globalPosition.dy;
      },
      onVerticalDragUpdate: (details) {
        final offset = details.globalPosition.dy - dragStartYRef.value;
        onHeightUpdated((dragStartHeightRef.value - offset).clamp(minHeight, maxHeight));
      },
      onVerticalDragEnd: (_) {
        isResizingState.value = false;
        onResizeEnd?.call();
      },
      child: child,
    );
  }
}
