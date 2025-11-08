import 'package:bible/style/color_library.dart';
import 'package:flutter/material.dart';

class TextStyleLibrary {
  final ColorLibrary colorLibrary;

  const TextStyleLibrary({required this.colorLibrary});

  TextStyle get bibleChapter => TextStyle(
    fontFamily: 'Inter',
    fontSize: 24,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.25,
    height: 36 / 24,
    color: colorLibrary.contentPrimary,
    decorationColor: colorLibrary.contentPrimary,
    decorationStyle: TextDecorationStyle.dotted,
  );

  TextStyle get bibleVerseNumber => TextStyle(
    fontFamily: 'Inter',
    fontSize: 12,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.25,
    height: 0,
    color: colorLibrary.contentPrimary,
    decorationColor: colorLibrary.contentPrimary,
    decorationStyle: TextDecorationStyle.dotted,
  );

  TextStyle get bibleBody => TextStyle(
    fontFamily: 'Inter',
    fontSize: 19,
    fontWeight: FontWeight.w300,
    letterSpacing: 0.25,
    height: 36 / 18,
    color: colorLibrary.contentPrimary,
    decorationColor: colorLibrary.contentPrimary,
    decorationStyle: TextDecorationStyle.dotted,
  );
}
