import 'package:bible/style/style_context_extensions.dart';
import 'package:bible/utils/extensions/map_if_non_null.dart';
import 'package:flutter/material.dart';

class StyledCircleButton extends StatelessWidget {
  final Widget child;
  final Function()? onPressed;

  StyledCircleButton({super.key, Widget? child, IconData? icon, this.onPressed})
    : child = child ?? icon?.mapIfNonNull(Icon.new) ?? SizedBox.shrink();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(
        icon: child,
        onPressed: onPressed,
        padding: EdgeInsets.zero,
        constraints: BoxConstraints(maxWidth: 48, maxHeight: 48),
        style: IconButton.styleFrom(
          foregroundColor: context.colors.contentPrimary,
          iconSize: 24,
          fixedSize: Size.square(40),
          maximumSize: Size.square(40),
          minimumSize: Size.square(40),
        ),
      ),
    );
  }
}
