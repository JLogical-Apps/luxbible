import 'package:flutter/material.dart';
import 'package:style/src/style_context_extensions.dart';

class StyledNotificationDot extends StatelessWidget {
  final Widget child;
  final bool isVisible;

  const StyledNotificationDot({super.key, required this.child, this.isVisible = true});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: .none,
      children: [
        child,
        if (isVisible)
          Positioned(
            top: -5,
            right: -5,
            child: IgnorePointer(
              child: Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(shape: .circle, color: context.colors.blue.medium),
              ),
            ),
          ),
      ],
    );
  }
}
