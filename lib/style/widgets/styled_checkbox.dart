import 'package:flutter/material.dart';

class StyledCheckbox extends StatelessWidget {
  final bool selected;

  const StyledCheckbox({super.key, required this.selected});

  @override
  Widget build(BuildContext context) {
    return Checkbox(value: selected, onChanged: (_) {});
  }
}
