import 'package:bible/style/color_library.dart';
import 'package:bible/style/text_style_extensions.dart';
import 'package:flutter/material.dart';

class TextStyleLibrary {
  final ColorLibrary colorLibrary;

  const TextStyleLibrary({required this.colorLibrary});

  TextStyle get base => TextStyle(
    fontFamily: 'Inter',
    color: colorLibrary.contentPrimary,
    decorationColor: colorLibrary.contentPrimary,
    decorationStyle: TextDecorationStyle.dotted,
  );

  TextStyle get headingXs => base.bold.copyWith(fontSize: 20, height: 28 / 20, letterSpacing: 0.3);

  TextStyle get labelLg => base.medium.copyWith(fontSize: 18, height: 24 / 18);
  TextStyle get labelMd => base.medium.copyWith(fontSize: 16, height: 20 / 16);
  TextStyle get labelSm => base.medium.copyWith(fontSize: 14, height: 20 / 14);
  TextStyle get labelXs => base.medium.copyWith(fontSize: 12, height: 16 / 12);

  TextStyle get paragraphLg => base.regular.copyWith(fontSize: 18, height: 28 / 18);
  TextStyle get paragraphMd => base.copyWith(fontSize: 16, height: 24 / 16);
  TextStyle get paragraphSm => base.copyWith(fontSize: 14, height: 20 / 14);

  TextStyle get bibleChapter => base.bold.copyWith(fontSize: 24, letterSpacing: 0.25, height: 36 / 24);

  TextStyle get bibleVerseNumber => base.bold.copyWith(fontSize: 12, letterSpacing: 0.25, height: 1);

  TextStyle get bibleBody => base.regular.copyWith(fontSize: 18, letterSpacing: 0.25, height: 36 / 18);
}
