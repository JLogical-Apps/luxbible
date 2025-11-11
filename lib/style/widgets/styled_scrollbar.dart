import 'package:bible/style/style_context_extensions.dart';
import 'package:flutter/material.dart';

class StyledScrollbar extends StatelessWidget {
  final Widget child;

  const StyledScrollbar({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ScrollbarTheme(
      data: ScrollbarThemeData(
        radius: Radius.circular(999),
        thumbColor: WidgetStateProperty.all(context.colors.borderOpaque),
        thickness: WidgetStateProperty.all(4),
        mainAxisMargin: 8,
        crossAxisMargin: 4,
      ),
      child: Scrollbar(child: child),
    );
  }
}
