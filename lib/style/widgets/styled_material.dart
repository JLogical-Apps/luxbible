import 'package:flutter/material.dart';

class StyledMaterial extends StatelessWidget {
  final Widget child;
  final Function()? onPressed;

  final Color? color;
  final BorderRadius borderRadius;
  final EdgeInsets padding;

  const StyledMaterial({
    super.key,
    required this.child,
    this.onPressed,
    this.color,
    this.borderRadius = BorderRadius.zero,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color ?? Colors.transparent,
      borderRadius: borderRadius,
      child: InkWell(
        borderRadius: borderRadius,
        onTap: onPressed,
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}
