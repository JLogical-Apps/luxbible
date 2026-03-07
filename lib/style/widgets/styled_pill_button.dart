import 'package:bible/style/style.dart';
import 'package:bible/utils/extensions/object_extensions.dart';
import 'package:flutter/material.dart';

class StyledPillButton extends StatelessWidget {
  final Widget label;
  final Widget? leading;
  final Widget? trailing;

  final Function()? onPressed;

  final Color? color;

  StyledPillButton({
    super.key,
    Widget? label,
    String? labelText,
    Widget? leading,
    IconData? leadingIcon,
    Widget? trailing,
    IconData? trailingIcon,
    this.onPressed,
    this.color,
  }) : label = label ?? labelText?.mapIfNonNull(Text.new) ?? SizedBox.shrink(),
       leading = leading ?? leadingIcon?.mapIfNonNull(Icon.new),
       trailing = trailing ?? trailingIcon?.mapIfNonNull(Icon.new);

  @override
  Widget build(BuildContext context) {
    final color = this.color ?? context.colors.surfaceSecondary;
    final colorLibrary = ColorLibrary.fromBackground(color);
    return StyledMaterial(
      color: color,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      borderRadius: BorderRadius.circular(999),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 8,
        children: [
          if (leading case final leading?)
            IconTheme.merge(
              data: IconThemeData(color: colorLibrary.contentPrimary, size: 16),
              child: leading,
            ),
          DefaultTextStyle(style: context.textStyle.labelSm.onColor(color), child: label),
          if (trailing case final trailing?)
            IconTheme.merge(
              data: IconThemeData(color: colorLibrary.contentPrimary, size: 16),
              child: trailing,
            ),
        ],
      ),
    );
  }
}
