import 'package:bible/style/style.dart';
import 'package:flutter/material.dart';

class StyledSwitch extends StatelessWidget {
  final bool isSelected;
  final Function(bool newValue)? onSelected;

  const StyledSwitch({super.key, required this.isSelected, this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Switch.adaptive(
      value: isSelected,
      onChanged: onSelected,
      activeThumbColor: context.colors.contentPrimaryInverse,
      inactiveThumbColor: context.colors.contentTertiary,
      inactiveTrackColor: context.colors.borderOpaque,
      activeTrackColor: context.colors.borderSelected,
      trackOutlineColor: .all(isSelected ? context.colors.borderSelected : context.colors.contentTertiary),
    );
  }
}
