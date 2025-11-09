import 'package:bible/style/style_context_extensions.dart';
import 'package:flutter/material.dart';

extension TextStyleExtensions on TextStyle {
  TextStyle subtle(BuildContext context) =>
      copyWith(color: context.colors.contentSecondary);

  TextStyle subtleTertiary(BuildContext context) =>
      copyWith(color: context.colors.contentTertiary);

  TextStyle disabled(BuildContext context, {bool isDisabled = true}) =>
      isDisabled ? copyWith(color: context.colors.contentDisabled) : this;

  double getWidth(String text) => (TextPainter(
    text: TextSpan(text: text, style: this),
    textDirection: TextDirection.ltr,
  )..layout()).width;
}
