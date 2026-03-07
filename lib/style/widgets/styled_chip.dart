import 'package:bible/style/style_context_extensions.dart';
import 'package:bible/style/widgets/styled_material.dart';
import 'package:flutter/material.dart';

class StyledChip extends StatelessWidget {
  final Widget child;
  final Function()? onPressed;

  const StyledChip({super.key, required this.child, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null;

    return StyledMaterial(
      color: enabled ? context.colors.surfaceSecondary : Colors.transparent,
      borderRadius: BorderRadius.circular(8),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      onPressed: onPressed,
      child: DefaultTextStyle(style: context.textStyle.labelSm, child: child),
    );
  }
}
