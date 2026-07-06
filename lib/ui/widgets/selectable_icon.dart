import 'package:flutter/material.dart';

class SelectableIcon extends StatelessWidget {
  final IconData icon;
  final bool isSelected;

  final Color? color;

  const SelectableIcon(this.icon, {super.key, required this.isSelected, this.color});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Icon(icon, color: color),
        if (isSelected) Icon(icon, fill: 0),
      ],
    );
  }
}
