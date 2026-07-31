import 'package:bible/style/style.dart';
import 'package:flutter/material.dart';

class StyledCheckbox extends StatelessWidget {
  final bool isSelected;
  final bool isPartial;
  final bool isEnabled;

  final Function(bool newValue)? onChanged;

  const StyledCheckbox({
    super.key,
    required this.isSelected,
    this.isPartial = false,
    this.isEnabled = true,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: onChanged == null,
      child: Checkbox(
        value: isPartial && !isSelected ? null : isSelected,
        tristate: isPartial && !isSelected,
        onChanged: isEnabled ? (_) => onChanged?.call(!isSelected) : null,
        fillColor: .resolveWith(
          (states) => !states.contains(WidgetState.selected)
              ? Colors.transparent
              : context.colors.content(isDisabled: states.contains(WidgetState.disabled)),
        ),
        checkColor: context.colors.contentPrimaryInverse,
        side: WidgetStateBorderSide.resolveWith(
          (states) =>
              BorderSide(width: 2, color: context.colors.content(isDisabled: states.contains(WidgetState.disabled))),
        ),
      ),
    );
  }
}
