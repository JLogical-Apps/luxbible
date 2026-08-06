import 'package:flutter/material.dart';
import 'package:style/style.dart';

ThemeData get theme => ThemeData(
  colorScheme: ColorScheme.highContrastLight(brightness: Brightness.light, primary: Colors.black),
  cardColor: Colors.white,
  appBarTheme: AppBarThemeData(scrolledUnderElevation: 0),
  iconTheme: IconThemeData(fill: 1, weight: 400, size: 25, color: Colors.black, opticalSize: 24),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.black,
    selectionColor: Colors.black.withValues(alpha: 0.2),
    selectionHandleColor: Colors.black,
  ),
  sliderTheme: SliderThemeData(inactiveTrackColor: ColorLibrary(brightness: .light).surfaceSecondary),
);

ThemeData get darkTheme => ThemeData(
  colorScheme: ColorScheme.dark(brightness: Brightness.dark, primary: Colors.white),
  cardColor: Colors.black,
  appBarTheme: AppBarThemeData(scrolledUnderElevation: 0),
  iconTheme: IconThemeData(fill: 1, weight: 400, size: 25, color: Colors.white, opticalSize: 24),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.white,
    selectionColor: Colors.white.withValues(alpha: 0.2),
    selectionHandleColor: Colors.white,
  ),
  sliderTheme: SliderThemeData(inactiveTrackColor: ColorLibrary(brightness: .dark).surfaceSecondary),
);
