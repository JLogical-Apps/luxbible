import 'package:bible/style/color_builder.dart';
import 'package:bible/style/color_library.dart';
import 'package:bible/style/style_context_extensions.dart';
import 'package:bible/style/widgets/styled_material.dart';
import 'package:flutter/material.dart';

class StyledTag extends StatelessWidget {
  final Widget child;
  final Widget? leading;
  final Function()? onPressed;

  final ColorBuilder? colorBuilder;

  const StyledTag({super.key, required this.child, this.leading, this.colorBuilder, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final color = colorBuilder?.call(context.colors) ?? context.colors.surfaceSecondary;
    final foregroundColor = ColorLibrary.fromBackground(color).contentPrimary;

    return StyledMaterial(
      colorBuilder: colorBuilder ?? .surfaceSecondary,
      padding: .symmetric(vertical: 4, horizontal: 6),
      onPressed: onPressed,
      isEnabled: true,
      borderRadius: .circular(999),
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
    );
  }
}
