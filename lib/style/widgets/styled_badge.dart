import 'package:bible/style/color_library.dart';
import 'package:bible/style/style_context_extensions.dart';
import 'package:bible/utils/extensions/object_extensions.dart';
import 'package:flutter/material.dart';

class StyledBadge extends StatelessWidget {
  final String? text;
  final IconData? icon;

  final Color? color;

  const StyledBadge({super.key, this.text, this.icon, this.color});

  @override
  Widget build(BuildContext context) {
    final color = this.color ?? context.colors.surfaceSecondary;
    final foregroundColor = ColorLibrary.fromBackground(color).contentPrimary;

    return IgnorePointer(
      child: Container(
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(999)),
        padding: EdgeInsets.symmetric(horizontal: 4),
        constraints: BoxConstraints(minHeight: 18),
        alignment: Alignment.center,
        child:
            text?.mapIfNonNull(
              (text) => Text(text, style: context.textStyle.labelXs.copyWith(color: foregroundColor)),
            ) ??
            icon?.mapIfNonNull((icon) => Icon(icon, size: 10, color: foregroundColor)),
      ),
    );
  }
}
