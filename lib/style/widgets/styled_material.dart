import 'package:bible/style/color_builder.dart';
import 'package:bible/style/style_context_extensions.dart';
import 'package:bible/style/text_style_extensions.dart';
import 'package:flutter/material.dart';

class StyledMaterial extends StatelessWidget {
  final Widget child;
  final Function()? onPressed;
  final Function()? onLongPressed;

  final ColorBuilder? colorBuilder;
  final BorderRadius borderRadius;
  final EdgeInsets padding;

  const StyledMaterial({
    super.key,
    required this.child,
    this.onPressed,
    this.onLongPressed,
    this.colorBuilder,
    this.borderRadius = BorderRadius.zero,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    final color = colorBuilder?.call(context.colors);
    return Material(
      color: color ?? Colors.transparent,
      borderRadius: borderRadius,
      child: InkWell(
        borderRadius: borderRadius,
        onTap: onPressed,
        onLongPress: onLongPressed,
        child: Padding(
          padding: padding,
          child: DefaultTextStyle(
            style: context.textStyle.labelLg.onColor(color),
            child: IconTheme.merge(
              data: IconThemeData(color: color?.foreground()),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
