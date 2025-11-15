import 'package:bible/style/hue.dart';
import 'package:bible/utils/extensions/brightness_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tailwind_colors/flutter_tailwind_colors.dart';

class ColorLibrary {
  final Brightness brightness;

  const ColorLibrary({required this.brightness});

  factory ColorLibrary.fromBackground(Color color) =>
      ColorLibrary(brightness: ThemeData.estimateBrightnessForColor(color));

  ColorLibrary get inverted => ColorLibrary(brightness: brightness.inverted);

  Hue get zinc => TWColors.zinc.asHue(brightness);
  Hue get stone => TWColors.stone.asHue(brightness);
  Hue get red => TWColors.red.asHue(brightness);
  Hue get orange => TWColors.orange.asHue(brightness);
  Hue get yellow => TWColors.yellow.asHue(brightness);
  Hue get green => TWColors.green.asHue(brightness);
  Hue get blue => TWColors.blue.asHue(brightness);
  Hue get violet => TWColors.violet.asHue(brightness);

  Color get backgroundPrimary => brightness.when(light: zinc.shade100, dark: zinc.shade950);
  Color get backgroundCritical => brightness.when(light: red.shade600, dark: red.shade700);

  Color get surfacePrimary => brightness.when(light: Colors.white, dark: zinc.shade900);
  Color get surfaceSecondary => brightness.when(light: zinc.shade200, dark: zinc.shade700);
  Color get surfaceTertiary => brightness.when(light: zinc.shade100, dark: zinc.shade800);
  Color get surfaceDisabled => brightness.when(light: zinc.shade100, dark: zinc.shade800);

  Color get contentPrimary => brightness.when(light: Colors.black, dark: Colors.white);
  Color get contentPrimaryInverse => brightness.when(light: Colors.white, dark: Colors.black);
  Color get contentSecondary => brightness.when(light: zinc.shade700, dark: zinc.shade300);
  Color get contentTertiary => brightness.when(light: zinc.shade600, dark: zinc.shade400);
  Color get contentDisabled => brightness.when(light: zinc.shade400, dark: zinc.shade600);

  Color get borderOpaque => brightness.when(light: zinc.shade200, dark: zinc.shade700);
  Color get borderSelected => brightness.when(light: Colors.black, dark: Colors.white);
  Color border(bool isSelected) => isSelected ? borderSelected : borderOpaque;
}

extension on MaterialColor {
  Hue asHue(Brightness brightness) => Hue(brightness: brightness, color: this);
}
