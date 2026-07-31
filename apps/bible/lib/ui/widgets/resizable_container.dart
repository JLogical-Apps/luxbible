import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ResizableContainer extends HookWidget {
  final Widget child;
  final double initialHeight;
  final double minHeight;
  final double maxHeight;

  final Function(double) onHeightUpdated;
  final Function()? onResizeStart;
  final Function()? onResizeEnd;

  const ResizableContainer({
    super.key,
    required this.child,
    required this.initialHeight,
    required this.minHeight,
    required this.maxHeight,
    required this.onHeightUpdated,
    this.onResizeStart,
    this.onResizeEnd,
  });

  @override
  Widget build(BuildContext context) {
    final heightState = useState(initialHeight.clamp(minHeight, maxHeight));
    final dragStartHeightRef = useRef(0.0);
    final dragStartYRef = useRef(0.0);

    return SizedBox(
      height: heightState.value,
      child: GestureDetector(
        onVerticalDragStart: (details) {
          onResizeStart?.call();
          dragStartHeightRef.value = heightState.value;
          dragStartYRef.value = details.globalPosition.dy;
        },
        onVerticalDragUpdate: (details) {
          final offset = details.globalPosition.dy - dragStartYRef.value;
          final height = (dragStartHeightRef.value - offset).clamp(minHeight, maxHeight);
          heightState.value = height;
          onHeightUpdated(height);
        },
        onVerticalDragEnd: (_) => onResizeEnd?.call(),
        child: child,
      ),
    );
  }
}
