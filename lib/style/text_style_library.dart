import 'package:bible/style/color_library.dart';
import 'package:flutter/material.dart';

class TextStyleLibrary {
  final ColorLibrary colorLibrary;

  const TextStyleLibrary({required this.colorLibrary});

  TextStyle get base => TextStyle(
    color: colorLibrary.contentPrimary,
    decorationColor: colorLibrary.contentPrimary,
    decorationStyle: TextDecorationStyle.dotted,
  );

  TextStyle get labelLarge => base.copyWith(
    fontFamily: 'Inter',
    fontSize: 18,
    height: 24 / 18,
    fontVariations: [FontVariation('wght', 500)],
  );

  TextStyle get labelMedium => base.copyWith(
    fontFamily: 'Inter',
    fontSize: 16,
    height: 20 / 16,
    fontVariations: [FontVariation('wght', 500)],
  );

  TextStyle get paragraphLarge => base.copyWith(
    fontFamily: 'Inter',
    fontSize: 18,
    height: 28 / 18,
    fontVariations: [FontVariation('wght', 400)],
  );

  TextStyle get paragraphMedium => base.copyWith(
    fontFamily: 'Inter',
    fontSize: 16,
    height: 24 / 16,
    fontVariations: [FontVariation('wght', 400)],
  );

  TextStyle get bibleChapter => base.copyWith(
    fontFamily: 'Inter',
    fontSize: 24,
    fontVariations: [FontVariation('wght', 700)],
    letterSpacing: 0.25,
    height: 36 / 24,
  );

  TextStyle get bibleVerseNumber => base.copyWith(
    fontFamily: 'Inter',
    fontSize: 12,
    fontVariations: [FontVariation('wght', 700)],
    letterSpacing: 0.25,
    height: 0,
  );

  TextStyle get bibleBody => base.copyWith(
    fontFamily: 'Inter',
    fontSize: 19,
    fontVariations: [FontVariation('wght', 400)],
    letterSpacing: 0.25,
    height: 36 / 18,
  );
}
