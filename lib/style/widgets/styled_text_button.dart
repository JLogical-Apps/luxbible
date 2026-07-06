import 'package:bible/style/style.dart';
import 'package:flutter/material.dart';

class StyledTextButton extends StatelessWidget {
  final Widget? leading;
  final Widget child;
  final Function()? onPressed;

  const StyledTextButton({super.key, this.leading, required this.child, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return StyledMaterial(
      borderRadius: .circular(8),
      padding: .all(12),
      onPressed: onPressed,
      child: Row(
        spacing: 8,
        children: [
          ?leading,
          DefaultTextStyle(style: context.textStyle.labelSm, child: child),
        ],
      ),
    );
  }
}
