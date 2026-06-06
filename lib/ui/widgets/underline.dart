import 'package:flutter/material.dart';

class Underline extends StatelessWidget {
  final Widget child;
  final TextStyle style;
  final bool isUnderlined;

  const Underline({super.key, required this.child, required this.style, this.isUnderlined = true});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned.fill(
          child: IgnorePointer(
            child: Text(
              '.....',
              style: style.copyWith(color: Colors.transparent, decoration: isUnderlined ? .underline : null),
            ),
          ),
        ),
      ],
    );
  }
}
