import 'package:bible/style/style_context_extensions.dart';
import 'package:flutter/material.dart';

class StyledCircleButton extends StatelessWidget {
  final Widget child;
  final Function()? onPressed;

  final Color? color;

  final double iconSize;
  final double dimension;

  const StyledCircleButton.lg({super.key, required this.child, required this.onPressed, this.color})
    : iconSize = 24,
      dimension = 40;

  const StyledCircleButton.sm({super.key, required this.child, required this.onPressed, this.color})
    : iconSize = 16,
      dimension = 32;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(
        icon: child,
        onPressed: onPressed,
        padding: EdgeInsets.zero,
        constraints: BoxConstraints(maxWidth: 48, maxHeight: 48),
        style: IconButton.styleFrom(
          foregroundColor: context.colors.contentPrimary,
          backgroundColor: color,
          iconSize: iconSize,
          fixedSize: Size.square(dimension),
          maximumSize: Size.square(dimension),
          minimumSize: Size.square(dimension),
        ),
      ),
    );
  }
}
