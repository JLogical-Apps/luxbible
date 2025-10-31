import 'package:bible/extensions/brightness_extensions.dart';
import 'package:flutter/material.dart';

class ColorLibrary {
  final Brightness brightness;

  const ColorLibrary({required this.brightness});

  Color get backgroundPrimary =>
      brightness.when(light: Color(0xFFFAFAFA), dark: Color(0xFF09090B));

  Color get contentPrimary =>
      brightness.when(light: Color(0xFF424547), dark: Color(0xFFD3D7DA));
}
