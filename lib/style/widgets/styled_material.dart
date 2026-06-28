import 'package:bible/style/style.dart';
import 'package:flutter/material.dart';

class StyledMaterial extends StatelessWidget {
  final Widget child;
  final Function()? onPressed;
  final Function()? onLongPressed;
  final bool isEnabled;

  final ColorBuilder? colorBuilder;
  final bool isCritical;
  final BorderRadius borderRadius;
  final EdgeInsets padding;

  const StyledMaterial({
    super.key,
    required this.child,
    this.onPressed,
    this.onLongPressed,
    bool? isEnabled,
    this.colorBuilder,
    this.isCritical = false,
    this.borderRadius = .zero,
    this.padding = .zero,
  }) : isEnabled = isEnabled ?? (onPressed != null || onLongPressed != null);

  @override
  Widget build(BuildContext context) {
    final color = colorBuilder?.call(context.colors);
    final backgroundColor = color?.asSurface(isDisabled: !isEnabled);
    final foregroundColor = backgroundColor?.foreground(isDisabled: !isEnabled, isCritical: isCritical);
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
          overlayColor: foregroundColor == null ? null : .all(foregroundColor.withValues(alpha: 0.1)),
          child: Padding(
            padding: padding,
            child: DefaultTextStyle(
              style: context.textStyle.labelLg
                  .onColor(backgroundColor)
                  .disabled(isDisabled: !isEnabled)
                  .critical(isCritical: isCritical),
              child: IconTheme.merge(
                data: IconThemeData(color: foregroundColor),
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
