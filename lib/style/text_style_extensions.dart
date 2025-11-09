import 'package:bible/style/style_context_extensions.dart';
import 'package:flutter/material.dart';

extension TextStyleExtensions on TextStyle {
  TextStyle subtle(BuildContext context) =>
      copyWith(color: context.colors.contentSecondary);

  TextStyle disabled(BuildContext context, {bool isDisabled = true}) =>
      isDisabled ? copyWith(color: context.colors.contentDisabled) : this;
}
