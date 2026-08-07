import 'package:flutter/material.dart';
import 'package:style/src/color_builder.dart';
import 'package:style/src/color_library.dart';
import 'package:style/src/style_context_extensions.dart';

class StyledBadge extends StatelessWidget {
  final Widget child;
  final Widget? leading;

  final ColorBuilder? colorBuilder;

  const StyledBadge({super.key, required this.child, this.leading, this.colorBuilder});

  @override
  Widget build(BuildContext context) {
    final color = colorBuilder?.call(context.colors) ?? context.colors.surfaceSecondary;
    final foregroundColor = ColorLibrary.fromBackground(color).contentPrimary;

    return IgnorePointer(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: .circular(999),
          color: colorBuilder?.call(context.colors) ?? context.colors.surfaceSecondary,
        ),
        constraints: BoxConstraints(minHeight: 18),
        padding: .all(4),
        child: Row(
          spacing: 4,
          children: [
            if (leading case final leading?)
              IconTheme.merge(
                data: IconThemeData(size: 12, color: foregroundColor),
                child: leading,
              ),
            DefaultTextStyle(
              style: context.textStyle.labelXs.copyWith(color: foregroundColor),
              child: IconTheme.merge(
                data: IconThemeData(size: 12, color: foregroundColor),
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
