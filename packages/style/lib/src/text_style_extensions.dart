import 'package:style/src/color_library.dart';
import 'package:flutter/material.dart';

extension TextStyleExtensions on TextStyle {
  TextStyle subtle({bool isSubtle = true}) => isSubtle ? copyWith(color: colors.contentSecondary) : this;
  TextStyle subtleTertiary({bool isSubtle = true}) => isSubtle ? copyWith(color: colors.contentTertiary) : this;
  TextStyle disabled({bool isDisabled = true}) => isDisabled ? copyWith(color: colors.contentDisabled) : this;
  TextStyle critical({bool isCritical = true}) => isCritical ? copyWith(color: colors.contentCritical) : this;

  ColorLibrary get colors => ColorLibrary.fromBackground(color ?? Colors.transparent).inverted;

  TextStyle onColor(Color? color) =>
      color == null ? this : copyWith(color: ColorLibrary.fromBackground(color).contentPrimary);

  TextStyle get thin => copyWith(fontVariations: [FontVariation('wght', 100)]);
  TextStyle get extraLight => copyWith(fontVariations: [FontVariation('wght', 200)]);
  TextStyle get light => copyWith(fontVariations: [FontVariation('wght', 300)]);
  TextStyle get regular => copyWith(fontVariations: [FontVariation('wght', 440)]);
  TextStyle get medium => copyWith(fontVariations: [FontVariation('wght', 520)]);
  TextStyle get semiBold => copyWith(fontVariations: [FontVariation('wght', 600)]);
  TextStyle get bold => copyWith(fontVariations: [FontVariation('wght', 700)]);
  TextStyle get extraBold => copyWith(fontVariations: [FontVariation('wght', 800)]);
  TextStyle get black => copyWith(fontVariations: [FontVariation('wght', 900)]);

  TextStyle get underlined => copyWith(decoration: TextDecoration.underline);

  static final Map<(TextStyle, String), double> _textWidths = {};
  double getWidth(String text) => _textWidths.putIfAbsent(
    (this, text),
    () => (TextPainter(
      text: TextSpan(text: text, style: this),
      textDirection: .ltr,
    )..layout()).width,
  );

  double get totalHeight => fontSize! * height!;
}
