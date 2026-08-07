import 'package:flutter/material.dart';
import 'package:style/src/color_builder.dart';
import 'package:style/src/widgets/styled_material.dart';

class StyledRectButton extends StatelessWidget {
  final Widget label;
  final Function()? onPressed;

  final ColorBuilder? colorBuilder;
  final bool isCritical;

  StyledRectButton.primary({super.key, required this.label, required this.onPressed, this.isCritical = false})
    : colorBuilder = .primary;
  StyledRectButton.secondary({super.key, required this.label, required this.onPressed, this.isCritical = false})
    : colorBuilder = .surfaceSecondary;
  StyledRectButton.transparent({super.key, required this.label, required this.onPressed, this.isCritical = false})
    : colorBuilder = .transparent;
  StyledRectButton.critical({super.key, required this.label, required this.onPressed})
    : isCritical = false,
      colorBuilder = .backgroundCritical;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: StyledMaterial(
        onPressed: onPressed,
        colorBuilder: colorBuilder,
        isCritical: isCritical,
        borderRadius: .circular(8),
        child: Center(child: label),
      ),
    );
  }
}
