import 'package:bible/models/bible/verse.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/style/style.dart';
import 'package:bible/ui/widgets/word_substring_text.dart';
import 'package:bible/utils/extensions/string_extensions.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:utils_core/utils_core.dart';

class VerseText extends ConsumerWidget {
  final List<Verse> verses;

  final String? highlightStrongId;
  final String? highlightTerm;

  final TextStyle? style;

  const VerseText({super.key, required this.verses, this.highlightStrongId, this.highlightTerm, this.style});
  VerseText.verse({super.key, required Verse verse, this.highlightStrongId, this.highlightTerm, this.style})
    : verses = [verse];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
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
                        style: TextStyle(
                          color: word.redLetters && user.themeLayout.redLetters ? context.colors.red.dark : null,
                        ),
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
    );
  }
}
