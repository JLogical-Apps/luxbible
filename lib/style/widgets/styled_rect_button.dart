import 'package:bible/style/color_builder.dart';
import 'package:bible/style/widgets/styled_material.dart';
import 'package:flutter/material.dart';

class StyledRectButton extends StatelessWidget {
  final Widget label;
  final Function()? onPressed;

  final ColorBuilder? colorBuilder;

  StyledRectButton.primary({super.key, required this.label, required this.onPressed}) : colorBuilder = .primary;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: StyledMaterial(
        onPressed: onPressed,
        colorBuilder: colorBuilder,
        borderRadius: BorderRadius.circular(8),
        child: Center(child: label),
      ),
    );
  }
}
