import 'package:bible/style/style.dart';
import 'package:flutter/material.dart';

class StyledCircleButton extends StatelessWidget {
  final Widget child;
  final Function()? onPressed;

  final ColorBuilder? colorBuilder;

  final double iconSize;
  final double dimension;

  const StyledCircleButton.lg({super.key, required this.child, required this.onPressed, this.colorBuilder})
    : iconSize = 24,
      dimension = 40;

  const StyledCircleButton.md({super.key, required this.child, required this.onPressed, this.colorBuilder})
    : iconSize = 24,
      dimension = 40;

  const StyledCircleButton.sm({super.key, required this.child, required this.onPressed, this.colorBuilder})
    : iconSize = 16,
      dimension = 32;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(
        icon: child,
        onPressed: onPressed,
        padding: .zero,
        constraints: BoxConstraints(maxWidth: 48, maxHeight: 48),
        style: IconButton.styleFrom(
          foregroundColor: colorBuilder?.call(context.colors).foreground() ?? context.colors.contentPrimary,
          backgroundColor: colorBuilder?.call(context.colors),
          iconSize: iconSize,
          fixedSize: Size.square(dimension),
          maximumSize: Size.square(dimension),
          minimumSize: Size.square(dimension),
        ),
      ),
    );
  }
}
