import 'package:flutter/material.dart';

class WordSubstringText extends StatelessWidget {
  final String text;

  final TextStyle? style;
  final TextStyle? Function(String word) wordStyleMapper;

  const WordSubstringText(this.text, {super.key, this.style, required this.wordStyleMapper});

  @override
  Widget build(BuildContext context) => Text.rich(TextSpan(style: style, children: getSpans()));

  List<InlineSpan> getSpans() {
    final tokenSpans = <InlineSpan>[];
    text.splitMapJoin(
      RegExp(r'\S+'),
      onMatch: (match) {
        final token = match[0]!;
        tokenSpans.add(TextSpan(text: token, style: (style ?? TextStyle()).merge(wordStyleMapper(token))));
        return '';
      },
      onNonMatch: (nonMatch) {
        if (nonMatch.isNotEmpty) tokenSpans.add(TextSpan(text: nonMatch));
        return '';
      },
    );
    return tokenSpans;
  }
}
