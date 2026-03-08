import 'package:bible/style/style.dart';
import 'package:flutter/material.dart';

class StyledPillButton extends StatelessWidget {
  final Widget label;
  final Widget? leading;
  final Widget? trailing;

  final Function()? onPressed;

  final ColorBuilder? colorBuilder;

  const StyledPillButton({
    super.key,
    required this.label,
    this.leading,
    this.trailing,
    this.onPressed,
    this.colorBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final colorBuilder = this.colorBuilder ?? .surfaceSecondary;
    return StyledMaterial(
      colorBuilder: colorBuilder,
      padding: .symmetric(horizontal: 12, vertical: 10),
      borderRadius: .circular(999),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: .min,
        spacing: 8,
        children: [
          if (leading case final leading?) IconTheme.merge(data: IconThemeData(size: 16), child: leading),
          DefaultTextStyle(style: context.textStyle.labelSm.onColor(colorBuilder(context.colors)), child: label),
          if (trailing case final trailing?) IconTheme.merge(data: IconThemeData(size: 16), child: trailing),
        ],
      ),
    );
  }
}
