import 'package:bible/utils/extensions/brightness_extensions.dart';
import 'package:flutter/material.dart';

class Hue {
  final MaterialColor color;
  final Brightness brightness;

  const Hue({required this.color, required this.brightness});

  Color get shade050 => color[50]!;
  Color get shade100 => color.shade100;
  Color get shade200 => color.shade200;
  Color get shade300 => color.shade300;
  Color get shade400 => color.shade400;
  Color get shade500 => color.shade500;
  Color get shade600 => color.shade600;
  Color get shade700 => color.shade700;
  Color get shade800 => color.shade800;
  Color get shade900 => color.shade900;
  Color get shade950 => color[950]!;

  Color get primary => brightness.when(light: shade400, dark: shade300);
  Color get secondary => brightness.when(light: shade200, dark: shade700);
  Color get tertiary => brightness.when(light: shade100, dark: shade800);
  Color get dark => brightness.when(light: shade700, dark: shade200);
  Color get medium => shade500;
}
