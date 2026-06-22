import 'package:flutter/material.dart';

class StyledCheckbox extends StatelessWidget {
  final bool isSelected;
  final bool isEnabled;

  const StyledCheckbox({super.key, required this.isSelected, this.isEnabled = true});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Checkbox(value: isSelected, onChanged: isEnabled ? (_) {} : null),
    );
  }
}
