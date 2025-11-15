import 'package:bible/style/style_context_extensions.dart';
import 'package:flutter/material.dart';

class ColoredCircle extends StatelessWidget {
  final double? size;
  final Color color;
  final bool isSelected;

  const ColoredCircle({super.key, this.size, required this.color, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: IconTheme.of(context).size,
      height: IconTheme.of(context).size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        border: Border.all(color: context.colors.border(isSelected), width: 2.5),
      ),
    );
  }
}
