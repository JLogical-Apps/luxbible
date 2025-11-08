import 'package:bible/style/style_context_extensions.dart';
import 'package:flutter/material.dart';

class StyledShadow extends BoxShadow {
  final BuildContext context;

  const StyledShadow(this.context);

  @override
  Color get color => context.brightness == Brightness.light
      ? Colors.black.withValues(alpha: 0.12)
      : Colors.black.withValues(alpha: 0.5);

  @override
  Offset get offset => Offset(0, 4);

  @override
  double get spreadRadius => 0;

  @override
  double get blurRadius => 16;
}
