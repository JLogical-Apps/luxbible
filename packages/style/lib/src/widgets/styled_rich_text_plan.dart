import 'package:flutter/material.dart';
import 'package:style/src/style_context_extensions.dart';
import 'package:style/src/text_style_extensions.dart';

sealed class StyledRichTextPart {
  InlineSpan toSpan(BuildContext context, TextStyle style);

  static StyledRichTextPart text(String text, {TextStyle? Function(TextStyle)? styleModifier}) =>
      TextRichTextPart(text: text, styleModifier: styleModifier);

  static StyledRichTextPart link(String text, {required Function() onTap}) =>
      LinkRichTextPart(text: text, onTap: onTap);
}

class TextRichTextPart implements StyledRichTextPart {
  final String text;
  final TextStyle? Function(TextStyle)? styleModifier;

  const TextRichTextPart({required this.text, this.styleModifier});

  @override
  InlineSpan toSpan(BuildContext context, TextStyle style) {
    return TextSpan(text: text, style: styleModifier?.call(style) ?? style);
  }
}

class LinkRichTextPart implements StyledRichTextPart {
  final String text;
  final Function() onTap;

  const LinkRichTextPart({required this.text, required this.onTap});

  @override
  InlineSpan toSpan(BuildContext context, TextStyle style) {
    return WidgetSpan(
      alignment: PlaceholderAlignment.baseline,
      baseline: TextBaseline.alphabetic,
      child: GestureDetector(
        onTap: onTap,
        child: Text(text, style: style.underlined.medium.copyWith(color: context.colors.contentPrimary)),
      ),
    );
  }
}
