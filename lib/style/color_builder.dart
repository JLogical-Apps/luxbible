import 'package:bible/style/color_library.dart';
import 'package:bible/style/color_palette.dart';

class ColorBuilder {
  final ColorPalette Function(ColorLibrary) builder;

  const ColorBuilder(this.builder);

  static ColorBuilder get primary => ColorBuilder((colors) => colors.contentPrimary);

  static ColorBuilder get surfacePrimary => ColorBuilder((colors) => colors.surfacePrimary);
  static ColorBuilder get surfaceSecondary => ColorBuilder((colors) => colors.surfaceSecondary);
  static ColorBuilder get surfaceTertiary => ColorBuilder((colors) => colors.surfaceTertiary);

  static ColorBuilder get surfacePrimaryInverted => ColorBuilder((colors) => colors.inverted.surfacePrimary);

  static ColorBuilder get backgroundPrimary => ColorBuilder((colors) => colors.inverted.backgroundPrimary);
  static ColorBuilder get backgroundError => ColorBuilder((colors) => colors.inverted.backgroundError);

  ColorPalette call(ColorLibrary colors) => builder(colors);
}
