import 'package:flutter/material.dart';
import 'package:style/style.dart';

class StyledSwitch extends StatelessWidget {
  final bool isSelected;
  final Function(bool newValue)? onSelected;
  final bool isEnabled;

  const StyledSwitch({super.key, required this.isSelected, this.onSelected, bool? isEnabled})
    : isEnabled = isEnabled ?? onSelected != null;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = !isEnabled
        ? context.colors.surfaceDisabled
        : isSelected
        ? context.colors.borderSelected
        : context.colors.borderOpaque;
    return IgnorePointer(
      ignoring: onSelected == null,
      child: Switch.adaptive(
        value: isSelected,
        onChanged: onSelected ?? (_) {},
        activeThumbColor: context.colors.contentPrimaryInverse,
        inactiveThumbColor: isEnabled ? context.colors.contentTertiary : context.colors.contentDisabled,
        inactiveTrackColor: isEnabled ? context.colors.borderOpaque : context.colors.borderDisabled,
        activeTrackColor: backgroundColor,
        trackColor: .all(backgroundColor),
        trackOutlineColor: .all(
          !isEnabled
              ? context.colors.surfaceDisabled
              : isSelected
              ? context.colors.contentPrimary
              : context.colors.contentTertiary,
        ),
      ),
    );
  }
}
