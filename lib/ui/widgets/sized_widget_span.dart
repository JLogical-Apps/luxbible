import 'package:flutter/widgets.dart';

class SizedWidgetSpan extends WidgetSpan {
  final Size size;

  SizedWidgetSpan({required Widget child, required this.size, super.alignment})
    : super(
        child: SizedBox.fromSize(size: size, child: child),
      );
}
