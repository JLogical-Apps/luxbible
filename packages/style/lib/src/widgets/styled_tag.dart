import 'package:style/src/color_builder.dart';
import 'package:style/src/color_library.dart';
import 'package:style/src/style_context_extensions.dart';
import 'package:style/src/text_style_library.dart';
import 'package:style/src/widgets/styled_material.dart';
import 'package:flutter/material.dart';

class StyledTag extends StatelessWidget {
  final Widget child;
  final Widget? leading;
  final Function()? onPressed;
  final bool isEnabled;

  final ColorBuilder? colorBuilder;

  final EdgeInsets padding;
  final TextStyle Function(TextStyleLibrary) textStyleBuilder;
  final double iconSize;

  StyledTag.sm({super.key, required this.child, this.leading, this.colorBuilder, this.onPressed, this.isEnabled = true})
    : padding = .symmetric(vertical: 4, horizontal: 6),
      textStyleBuilder = ((textStyle) => textStyle.labelXs),
      iconSize = 12;

  StyledTag.md({super.key, required this.child, this.leading, this.colorBuilder, this.onPressed, this.isEnabled = true})
    : padding = .symmetric(vertical: 6, horizontal: 8),
      textStyleBuilder = ((textStyle) => textStyle.labelSm),
      iconSize = 16;

  @override
  Widget build(BuildContext context) {
    final color = colorBuilder?.call(context.colors) ?? context.colors.surfaceSecondary;
    final foregroundColor = ColorLibrary.fromBackground(color).contentPrimary;

    return Opacity(
      opacity: isEnabled ? 1 : 0.5,
      child: StyledMaterial(
        colorBuilder: colorBuilder ?? .surfaceSecondary,
        padding: padding,
        onPressed: onPressed,
        isEnabled: true,
        borderRadius: .circular(999),
        child: Row(
          spacing: 4,
          children: [
            if (leading case final leading?)
              IconTheme.merge(
                data: IconThemeData(size: iconSize, color: foregroundColor),
                child: leading,
              ),
            DefaultTextStyle(
              style: textStyleBuilder(context.textStyle).copyWith(color: foregroundColor),
              child: IconTheme.merge(
                data: IconThemeData(size: iconSize, color: foregroundColor),
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
