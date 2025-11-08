import 'package:bible/style/color_library.dart';
import 'package:bible/style/text_style_library.dart';
import 'package:flutter/material.dart';

extension StyleContextExtensions on BuildContext {
  Brightness get brightness => Theme.of(this).brightness;

  ColorLibrary get colors => ColorLibrary(brightness: brightness);

  TextStyleLibrary get textStyle => TextStyleLibrary(colorLibrary: colors);
}
