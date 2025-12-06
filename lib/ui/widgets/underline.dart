import 'package:bible/style/style_context_extensions.dart';
import 'package:flutter/material.dart';

class Underline extends StatelessWidget {
  final Widget child;
  final bool isUnderlined;

  const Underline({super.key, required this.child, this.isUnderlined = true});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned.fill(
          child: IgnorePointer(
            child: Text(
              '.....',
              style: context.textStyle.bibleBody.copyWith(
                color: Colors.transparent,
                decoration: isUnderlined ? TextDecoration.underline : null,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
