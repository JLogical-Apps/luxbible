import 'package:bible/style/style.dart';
import 'package:flutter/material.dart';

class StyledCircleButton extends StatelessWidget {
  final Widget child;
  final Function()? onPressed;

  final ColorBuilder? colorBuilder;

  final double _iconSize;
  final double _dimension;

  const StyledCircleButton.lg({super.key, required this.child, required this.onPressed, this.colorBuilder})
    : _iconSize = 24,
      _dimension = 40;

  const StyledCircleButton.md({super.key, required this.child, required this.onPressed, this.colorBuilder})
    : _iconSize = 24,
      _dimension = 40;

  const StyledCircleButton.sm({super.key, required this.child, required this.onPressed, this.colorBuilder})
    : _iconSize = 16,
      _dimension = 32;

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
          iconSize: _iconSize,
          fixedSize: Size.square(_dimension),
          maximumSize: Size.square(_dimension),
          minimumSize: Size.square(_dimension),
        ),
      ),
    );
  }
}
