import 'package:bible/style/color_library.dart';
import 'package:bible/style/text_style_extensions.dart';
import 'package:flutter/material.dart';

class TextStyleLibrary {
  final ColorLibrary colorLibrary;

  const TextStyleLibrary({required this.colorLibrary});

  TextStyle get base =>
      TextStyle(fontFamily: 'Inter', color: colorLibrary.contentPrimary, decorationColor: colorLibrary.contentPrimary);

  TextStyle get displayBase => base.bold.copyWith(fontFamily: 'Bitter');
  TextStyle get displaySm => displayBase.copyWith(fontSize: 44, height: 52 / 44);
  TextStyle get displayXs => displayBase.copyWith(fontSize: 36, height: 44 / 36);

  TextStyle get headingSm => base.bold.copyWith(fontSize: 24, height: 32 / 24, letterSpacing: 0.3);
  TextStyle get headingXs => base.bold.copyWith(fontSize: 20, height: 28 / 20, letterSpacing: 0.3);
  TextStyle get headingXxs => base.bold.copyWith(fontSize: 18, height: 24 / 18, letterSpacing: 0.3);

  TextStyle get labelLg => base.medium.copyWith(fontSize: 18, height: 24 / 18);
  TextStyle get labelMd => base.medium.copyWith(fontSize: 16, height: 20 / 16);
  TextStyle get labelSm => base.medium.copyWith(fontSize: 14, height: 20 / 14);
  TextStyle get labelXs => base.medium.copyWith(fontSize: 12, height: 16 / 12);

  TextStyle get paragraphLg => base.regular.copyWith(fontSize: 18, height: 28 / 18);
  TextStyle get paragraphMd => base.copyWith(fontSize: 16, height: 24 / 16);
  TextStyle get paragraphSm => base.copyWith(fontSize: 14, height: 20 / 14);

  TextStyle get bibleSection => base.bold.copyWith(fontSize: 24, height: 40 / 24);

  TextStyle get bibleVerseNumber => base.bold.copyWith(fontSize: 14, letterSpacing: 0.25, decorationStyle: .dotted);
  TextStyle get bibleBody =>
      base.regular.copyWith(fontSize: 20, letterSpacing: 0.2, height: 40 / 20, decorationStyle: .dotted);
}
