import 'package:flutter/material.dart';
import 'package:style/style.dart';

class StyledPillButton extends StatelessWidget {
  final Widget label;
  final Widget? leading;
  final Widget? trailing;

  final Function()? onPressed;

  final ColorBuilder? colorBuilder;

  final EdgeInsets padding;
  final TextStyle Function(TextStyleLibrary) textStyleBuilder;

  StyledPillButton.md({super.key, required this.label, this.leading, this.trailing, this.onPressed, this.colorBuilder})
    : padding = .symmetric(horizontal: 16, vertical: 12),
      textStyleBuilder = ((textStyle) => textStyle.labelMd);

  StyledPillButton.sm({super.key, required this.label, this.leading, this.trailing, this.onPressed, this.colorBuilder})
    : padding = .symmetric(horizontal: 12, vertical: 10),
      textStyleBuilder = ((textStyle) => textStyle.labelSm);

  @override
  Widget build(BuildContext context) {
    final colorBuilder = this.colorBuilder ?? .surfaceSecondary;
    return StyledMaterial(
      colorBuilder: colorBuilder,
      padding: padding,
      borderRadius: .circular(999),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: .min,
        spacing: 8,
        children: [
          if (leading case final leading?) IconTheme.merge(data: IconThemeData(size: 16), child: leading),
          DefaultTextStyle(
            style: textStyleBuilder(
              context.textStyle,
            ).copyWith(height: 1).onColor(colorBuilder(context.colors)).disabled(isDisabled: onPressed == null),
            child: label,
          ),
          if (trailing case final trailing?) IconTheme.merge(data: IconThemeData(size: 16), child: trailing),
        ],
      ),
    );
  }
}
