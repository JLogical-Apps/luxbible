import 'package:bible/style/style.dart';
import 'package:flutter/material.dart';

class StyledCheckbox extends StatelessWidget {
  final bool isSelected;
  final bool isEnabled;
  final bool isCompact;
  final bool isInverted;

  const StyledCheckbox({
    super.key,
    required this.isSelected,
    this.isEnabled = true,
    this.isCompact = false,
    this.isInverted = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = isInverted ? context.colors.inverted : context.colors;

    return IgnorePointer(
      child: Checkbox(
        value: isSelected,
        onChanged: isEnabled ? (_) {} : null,
        visualDensity: isCompact ? .compact : null,
        materialTapTargetSize: isCompact ? .shrinkWrap : null,
        fillColor: .resolveWith(
          (states) => !states.contains(WidgetState.selected)
              ? Colors.transparent
              : colors.content(isDisabled: states.contains(WidgetState.disabled)),
        ),
        checkColor: colors.contentPrimaryInverse,
        side: WidgetStateBorderSide.resolveWith(
          (states) => BorderSide(width: 2, color: colors.content(isDisabled: states.contains(WidgetState.disabled))),
        ),
      ),
    );
  }
}
