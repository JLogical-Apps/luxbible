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
    return IgnorePointer(
      ignoring: onSelected == null,
      child: Switch.adaptive(
        value: isSelected,
        onChanged: onSelected ?? (_) {},
        activeThumbColor: context.colors.contentPrimaryInverse,
        inactiveThumbColor: context.colors.contentTertiary,
        inactiveTrackColor: context.colors.borderOpaque,
        activeTrackColor: context.colors.borderSelected,
        trackOutlineColor: .all(isSelected ? context.colors.borderSelected : context.colors.contentTertiary),
      ),
    );
  }
}
