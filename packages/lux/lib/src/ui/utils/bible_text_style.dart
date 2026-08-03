import 'package:flutter/material.dart';
import 'package:style/style.dart';

class BibleTextStyle {
  static const baseMultiplier = 0.95;

  final BuildContext context;
  final String fontFamily;
  final double multiplier;

  BibleTextStyle(this.context, {this.fontFamily = 'Inter', this.multiplier = baseMultiplier});

  TextStyle get base => TextStyle(
    fontFamily: fontFamily,
    color: context.colors.contentPrimary,
    decorationColor: context.colors.contentPrimary,
  );

  TextStyle get majorSection => base.extraBold.copyWith(fontSize: 28 * multiplier, height: 40 / 28);
  TextStyle get section => base.bold.copyWith(fontSize: 24 * multiplier, height: 40 / 24);
  TextStyle get smallHeading =>
      base.regular.copyWith(fontSize: 20 * multiplier, letterSpacing: 0, height: 40 / 20, fontStyle: .italic);
  TextStyle get smallSection => base.bold.copyWith(fontSize: 20 * multiplier, letterSpacing: 0, height: 40 / 20);
  TextStyle get speakerHeading =>
      base.bold.copyWith(fontSize: 20 * multiplier, letterSpacing: 0, height: 40 / 20, fontStyle: .italic);
  TextStyle get verseNumber =>
      base.bold.copyWith(fontSize: 14 * multiplier, letterSpacing: 0, decorationStyle: .dotted);
  TextStyle get body =>
      base.regular.copyWith(fontSize: 20 * multiplier, letterSpacing: 0, height: 40 / 20, decorationStyle: .dotted);
}
