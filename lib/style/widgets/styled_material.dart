import 'package:bible/style/style.dart';
import 'package:flutter/material.dart';

class StyledMaterial extends StatelessWidget {
  final Widget child;
  final Function()? onPressed;
  final Function()? onLongPressed;
  final bool enabled;

  final ColorBuilder? colorBuilder;
  final BorderRadius borderRadius;
  final EdgeInsets padding;

  const StyledMaterial({
    super.key,
    required this.child,
    this.onPressed,
    this.onLongPressed,
    bool? enabled,
    this.colorBuilder,
    this.borderRadius = .zero,
    this.padding = .zero,
  }) : enabled = enabled ?? (onPressed != null || onLongPressed != null);

  @override
  Widget build(BuildContext context) {
    final color = colorBuilder?.call(context.colors);
    final backgroundColor = color?.asSurface(disabled: !enabled) ?? Colors.transparent;
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOutCubic,
      decoration: BoxDecoration(color: backgroundColor, borderRadius: borderRadius),
      child: Material(
        color: Colors.transparent,
        borderRadius: borderRadius,
        child: InkWell(
          borderRadius: borderRadius,
          onTap: onPressed,
          onLongPress: onLongPressed,
          child: Padding(
            padding: padding,
            child: DefaultTextStyle(
              style: context.textStyle.labelLg.onColor(backgroundColor).disabled(disabled: !enabled),
              child: IconTheme.merge(
                data: IconThemeData(color: backgroundColor.foreground(disabled: !enabled)),
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
