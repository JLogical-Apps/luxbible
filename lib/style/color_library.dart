import 'package:bible/extensions/brightness_extensions.dart';
import 'package:flutter/material.dart';

class ColorLibrary {
  final Brightness brightness;

  const ColorLibrary({required this.brightness});

  Color get backgroundPrimary =>
      brightness.when(light: Color(0xFFF4F4F5), dark: Color(0xFF09090B));

  Color get surfacePrimary =>
      brightness.when(light: Colors.white, dark: Color(0xFF18181B));

  Color get surfaceSecondary =>
      brightness.when(light: Color(0xFFF4F4F5), dark: Color(0xFF27272A));

  Color get surfaceTertiary =>
      brightness.when(light: Color(0xFFE4E4E7), dark: Color(0xFF3F3F46));

  Color get contentPrimary =>
      brightness.when(light: Colors.black, dark: Colors.white);
}
