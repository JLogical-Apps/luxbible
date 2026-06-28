import 'package:bible/style/color_library.dart';
import 'package:flutter/material.dart';

class ColorBuilder {
  final Color Function(ColorLibrary) builder;

  const ColorBuilder(this.builder);

  static final ColorBuilder primary = ColorBuilder((colors) => colors.contentPrimary);

  static final ColorBuilder surfacePrimary = ColorBuilder((colors) => colors.surfacePrimary);
  static final ColorBuilder surfaceSecondary = ColorBuilder((colors) => colors.surfaceSecondary);
  static final ColorBuilder surfaceTertiary = ColorBuilder((colors) => colors.surfaceTertiary);

  static final ColorBuilder surfacePrimaryInverted = ColorBuilder((colors) => colors.inverted.surfacePrimary);

  static final ColorBuilder backgroundPrimary = ColorBuilder((colors) => colors.backgroundPrimary);
  static final ColorBuilder backgroundError = ColorBuilder((colors) => colors.backgroundError);

  static final ColorBuilder transparent = ColorBuilder((colors) => Colors.transparent);

  Color call(ColorLibrary colors) => builder(colors);
}
