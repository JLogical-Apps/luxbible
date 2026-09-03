import 'package:flutter/material.dart';
import 'package:flutter_tailwind_colors/flutter_tailwind_colors.dart';
import 'package:lux/lux.dart';
import 'package:style/src/hue.dart';

class ColorLibrary {
  final Brightness brightness;

  ColorLibrary._({required this.brightness});

  static final ColorLibrary _light = ColorLibrary._(brightness: .light);
  static final ColorLibrary _dark = ColorLibrary._(brightness: .dark);

  factory ColorLibrary({required Brightness brightness}) => brightness.when(light: _light, dark: _dark);

  factory ColorLibrary.fromBackground(Color color) => ColorLibrary(brightness: color.brightness);

  ColorLibrary get inverted => ColorLibrary(brightness: brightness.inverted);

  late final Hue zinc = TWColors.zinc.asHue(brightness);
  late final Hue stone = TWColors.stone.asHue(brightness);
  late final Hue red = TWColors.red.asHue(brightness);
  late final Hue orange = TWColors.orange.asHue(brightness);
  late final Hue yellow = TWColors.yellow.asHue(brightness);
  late final Hue green = TWColors.green.asHue(brightness);
  late final Hue blue = TWColors.blue.asHue(brightness);
  late final Hue violet = TWColors.violet.asHue(brightness);

  List<Hue> get vibrantHues => [red, orange, yellow, green, blue, violet];

  Color get backgroundPrimary => brightness.when(light: zinc.shade100, dark: zinc.shade900);
  Color get backgroundCritical => brightness.when(light: red.shade600, dark: red.shade700);

  Color get surfacePrimary => brightness.when(light: Colors.white, dark: zinc.shade800);
  Color get surfaceSecondary => brightness.when(light: zinc.shade200, dark: zinc.shade600);
  Color get surfaceTertiary => brightness.when(light: zinc.shade100, dark: zinc.shade700);
  Color get surfaceDisabled => brightness.when(light: zinc.shade100, dark: zinc.shade700);
  Color get surfaceCritical => brightness.when(light: red.shade100, dark: red.shade950);
  Color surface({bool isDisabled = false}) => isDisabled ? surfaceDisabled : surfacePrimary;

  Color get contentPrimary => brightness.when(light: Colors.black, dark: Colors.white);
  Color get contentPrimaryInverse => brightness.when(light: Colors.white, dark: Colors.black);
  Color get contentSecondary => brightness.when(light: zinc.shade700, dark: zinc.shade300);
  Color get contentTertiary => brightness.when(light: zinc.shade600, dark: zinc.shade400);
  Color get contentDisabled => brightness.when(light: zinc.shade400, dark: zinc.shade600);
  Color get contentCritical => red.shade600;
  Color content({bool isDisabled = false, bool isCritical = false}) => isCritical
      ? contentCritical
      : isDisabled
      ? contentDisabled
      : contentPrimary;

  Color get borderOpaque => brightness.when(light: zinc.shade200, dark: zinc.shade700);
  Color get borderSelected => brightness.when(light: Colors.black, dark: Colors.white);
  Color get borderDisabled => brightness.when(light: zinc.shade100, dark: zinc.shade800);
  Color get borderError => red.shade600;
  Color border(bool isSelected) => isSelected ? borderSelected : borderOpaque;
}

extension on MaterialColor {
  Hue asHue(Brightness brightness) => Hue(brightness: brightness, color: this);
}

extension ColorExtensions on Color {
  Brightness get brightness => ThemeData.estimateBrightnessForColor(this);
  Color foreground({bool isDisabled = false, bool isCritical = false}) =>
      ColorLibrary.fromBackground(this).content(isDisabled: isDisabled, isCritical: isCritical);
  Color asSurface({bool isDisabled = false}) {
    final colors = ColorLibrary.fromBackground(this);
    return isDisabled
        ? this == colors.contentPrimaryInverse
              ? colors.inverted.surfaceDisabled
              : colors.surfaceDisabled
        : this;
  }
}
