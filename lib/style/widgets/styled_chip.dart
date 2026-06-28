import 'package:bible/style/style_context_extensions.dart';
import 'package:bible/style/widgets/styled_material.dart';
import 'package:flutter/material.dart';

class StyledChip extends StatelessWidget {
  final Widget child;
  final Function()? onPressed;

  const StyledChip({super.key, required this.child, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final isEnabled = onPressed != null;

    return StyledMaterial(
      colorBuilder: isEnabled ? .surfaceSecondary : null,
      borderRadius: .circular(8),
      padding: .symmetric(horizontal: 8, vertical: 8),
      onPressed: onPressed,
      child: DefaultTextStyle(style: context.textStyle.labelSm, child: child),
    );
  }
}
