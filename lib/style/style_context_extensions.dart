import 'package:bible/style/color_library.dart';
import 'package:bible/style/text_style_library.dart';
import 'package:flutter/material.dart';

extension StyleContextExtensions on BuildContext {
  ColorLibrary get colors =>
      ColorLibrary(brightness: Theme.of(this).brightness);

  TextStyleLibrary get textStyle => TextStyleLibrary(colorLibrary: colors);
}
