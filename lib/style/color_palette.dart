import 'package:flutter/painting.dart';

class ColorPalette extends Color {
  final Color _disabled;

  ColorPalette({required double a, required double r, required double g, required double b, required Color disabled})
    : _disabled = disabled,
      super.from(alpha: a, red: r, green: g, blue: b);

  Color disabled({bool disabled = true}) => disabled ? _disabled : this;
}

extension ColorExtensions on Color {
  ColorPalette asColorPalette({required Color disabled}) => ColorPalette(a: a, r: r, g: g, b: b, disabled: disabled);
}
