import 'package:style/src/style_context_extensions.dart';
import 'package:style/src/widgets/styled_material.dart';
import 'package:flutter/material.dart';

class StyledChip extends StatelessWidget {
  final Widget? leading;
  final Widget child;

  final Function()? onPressed;
  final bool? isSelected;

  const StyledChip({super.key, this.leading, required this.child, this.onPressed, this.isSelected});

  @override
  Widget build(BuildContext context) {
    final isEnabled = onPressed != null;

    return StyledMaterial(
      colorBuilder: isEnabled && isSelected == null ? .surfaceSecondary : null,
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
      isSelected: isSelected,
    );
  }
}
