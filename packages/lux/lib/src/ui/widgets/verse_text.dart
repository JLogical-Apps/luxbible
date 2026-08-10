import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:lux/lux_core.dart';
import 'package:lux/src/ui/widgets/word_substring_text.dart';
import 'package:style/style.dart';
import 'package:utils_core/utils_core.dart';

class VerseText extends StatelessWidget {
  final List<Verse> verses;

  final String? highlightStrongId;
  final String? highlightTerm;

  final bool redLetters;
  final int? maxLines;
  final TextStyle? style;

  const VerseText({
    super.key,
    required this.verses,
    this.highlightStrongId,
    this.highlightTerm,
    this.redLetters = true,
    this.maxLines,
    this.style,
  });

  VerseText.verse({
    super.key,
    required Verse verse,
    this.highlightStrongId,
    this.highlightTerm,
    this.redLetters = true,
    this.maxLines,
    this.style,
  }) : verses = [verse];

  @override
  Widget build(BuildContext context) {
    final searchTerms = highlightTerm?.onlyLetters.toLowerCase().split(' ').where((term) => term.isNotBlank).toSet();

    return Text.rich(
      TextSpan(
        style: style,
        children: verses
            .expandIndexed(
              (index, verse) => [
                if (index > 0) TextSpan(text: ' '),
                ...verse.words
                    .where((word) => word.text != null)
                    .expand(
                      (word) => WordSubstringText(
                        word.text!,
                        style: TextStyle(color: word.redLetters && redLetters ? context.colors.red.dark : null),
                        wordStyleMapper: (textWord) =>
                            (highlightStrongId != null && word.data?.strongId == highlightStrongId) ||
                                (searchTerms != null && searchTerms.contains(textWord.onlyLetters.toLowerCase()))
                            ? TextStyle(fontWeight: .bold)
                            : null,
                      ).getSpans(),
                    ),
              ],
            )
            .toList(),
      ),
      maxLines: maxLines,
      overflow: .ellipsis,
    );
  }
}
