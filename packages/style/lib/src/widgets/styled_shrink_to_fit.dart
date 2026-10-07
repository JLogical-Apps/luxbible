import 'package:flutter/material.dart';

class StyledShrinkToFit extends StatelessWidget {
  final Widget child;
  final double minScale;

  const StyledShrinkToFit({super.key, required this.child, this.minScale = 0.8});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => FittedBox(
        fit: .scaleDown,
        // Caps the child's width so it ellipsizes once it would need to shrink past minScale.
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: constraints.maxWidth / minScale),
          child: child,
        ),
      ),
    );
  }
}
