import 'package:bible/style/color_builder.dart';
import 'package:bible/style/color_library.dart';
import 'package:bible/style/style_context_extensions.dart';
import 'package:flutter/material.dart';

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
        decoration: BoxDecoration(color: color, borderRadius: .circular(999)),
        padding: .all(4),
        constraints: BoxConstraints(minHeight: 18),
        alignment: .center,
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
