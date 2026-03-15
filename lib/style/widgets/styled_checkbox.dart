import 'package:flutter/material.dart';

class StyledCheckbox extends StatelessWidget {
  final bool isSelected;

  const StyledCheckbox({super.key, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Checkbox(value: isSelected, onChanged: (_) {});
  }
}
