import 'package:bible/style/style_context_extensions.dart';
import 'package:flutter/material.dart';

class StyledShadow extends BoxShadow {
  final BuildContext context;
  final double direction;

  const StyledShadow.down(this.context) : direction = 1;
  const StyledShadow.up(this.context) : direction = -1;

  @override
  Color get color => context.brightness == Brightness.light
      ? Colors.black.withValues(alpha: 0.12)
      : Colors.black.withValues(alpha: 0.5);

  @override
  Offset get offset => Offset(0, 4 * direction);

  @override
  double get spreadRadius => 0;

  @override
  double get blurRadius => 16;
}
