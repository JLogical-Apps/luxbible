import 'package:bible/style/color_library.dart';
import 'package:bible/style/style_context_extensions.dart';
import 'package:flutter/material.dart';

extension TextStyleExtensions on TextStyle {
  TextStyle subtle(BuildContext context) => copyWith(color: context.colors.contentSecondary);

  TextStyle subtleTertiary(BuildContext context) => copyWith(color: context.colors.contentTertiary);

  TextStyle disabled(BuildContext context, {bool isDisabled = true}) =>
      isDisabled ? copyWith(color: context.colors.contentDisabled) : this;

  TextStyle error(BuildContext context, {bool isError = true}) =>
      isError ? copyWith(color: context.colors.contentError) : this;

  TextStyle onColor(Color? color) =>
      color == null ? this : copyWith(color: ColorLibrary.fromBackground(color).contentPrimary);

  TextStyle get thin => copyWith(fontVariations: [FontVariation('wght', 100)]);
  TextStyle get extraLight => copyWith(fontVariations: [FontVariation('wght', 200)]);
  TextStyle get light => copyWith(fontVariations: [FontVariation('wght', 300)]);
  TextStyle get regular => copyWith(fontVariations: [FontVariation('wght', 400)]);
  TextStyle get medium => copyWith(fontVariations: [FontVariation('wght', 520)]);
  TextStyle get semiBold => copyWith(fontVariations: [FontVariation('wght', 600)]);
  TextStyle get bold => copyWith(fontVariations: [FontVariation('wght', 700)]);
  TextStyle get extraBold => copyWith(fontVariations: [FontVariation('wght', 800)]);
  TextStyle get black => copyWith(fontVariations: [FontVariation('wght', 900)]);

  double getWidth(String text) => (TextPainter(
    text: TextSpan(text: text, style: this),
    textDirection: TextDirection.ltr,
  )..layout()).width;

  double get totalHeight => fontSize! * height!;
}
