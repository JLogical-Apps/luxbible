import 'package:style/src/style_context_extensions.dart';
import 'package:flutter/material.dart';

class StyledScrollbar extends StatelessWidget {
  final Widget child;

  final ScrollController? controller;
  final bool removePadding;

  const StyledScrollbar({super.key, required this.child, this.controller, this.removePadding = false});

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removeViewPadding(
      context: context,
      removeRight: removePadding,
      removeLeft: removePadding,
      removeBottom: removePadding,
      removeTop: removePadding,
      child: ScrollbarTheme(
        data: ScrollbarThemeData(
          radius: .circular(999),
          thumbColor: WidgetStateProperty.all(context.colors.borderOpaque),
          thickness: WidgetStateProperty.all(4),
          mainAxisMargin: 8,
          crossAxisMargin: 4,
        ),
        child: Scrollbar(controller: controller, child: child),
      ),
    );
  }
}
