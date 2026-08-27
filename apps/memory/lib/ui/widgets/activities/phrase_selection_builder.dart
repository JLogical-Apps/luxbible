import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/lux.dart';
import 'package:memory/models/activity_plan.dart';
import 'package:memory/ui/widgets/phrase_text.dart';
import 'package:memory/utils/common_english_function_words.dart';
import 'package:style/style.dart';

class PhraseSelectionBuilder extends HookConsumerWidget {
  final PhraseSelectionActivityPlan plan;

  const PhraseSelectionBuilder({super.key, required this.plan});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final phrasesByReference = ref.watch(phrasesByReferenceProvider(translation: .bsb)).value;
    if (phrasesByReference == null) {
      return StyledLoading(loadingPadding: .all(16));
    }

    final passage = plan.passage;
    final chapterReference = passage.references.first.toChapterReference();
    final passagePhrases = passage.references.expand((reference) => phrasesByReference[reference]!).toList();
    final phraseKeys = useMemoized(() => passagePhrases.map((_) => GlobalKey()).toList(), []);

    (int currentIndex, List<Choice>?) getStep(int index) {
      if (index == passagePhrases.length) return (index, null);

      final correctPhrase = passagePhrases[index];
      final correctPhraseImportantWords = correctPhrase.keywords
          .where((word) => !commonEnglishFunctionWords.contains(word))
          .toSet();
      final incorrectPhrases = phrasesByReference.entries
          .expand((referenceAndPhrases) => referenceAndPhrases.value.map((phrase) => (referenceAndPhrases.key, phrase)))
          .where(
            (referenceAndPhrase) =>
                referenceAndPhrase.$2.textWords.first == correctPhrase.textWords.first &&
                referenceAndPhrase.$2.words.first.redLetters == correctPhrase.words.first.redLetters &&
                referenceAndPhrase.$2.text != correctPhrase.text,
          )
          .map((referenceAndPhrase) {
            final (reference, phrase) = referenceAndPhrase;
            final phraseLengthDiff = (phrase.text.length - correctPhrase.text.length).abs();
            return (
              phrase,
              [
                if (passage.references.contains(reference))
                  8
                else if (reference.toChapterReference() == chapterReference)
                  5
                else if (reference.book == chapterReference.book)
                  4
                else if (reference.book.testament == chapterReference.book.testament)
                  2,
                if (phraseLengthDiff < 8) 5 else if (phraseLengthDiff < 16) 3,
                if (phrase.text.hasQuotationMark == correctPhrase.text.hasQuotationMark) 5,
                8 * pow(phrase.keywords.toSet().intersection(correctPhraseImportantWords).length, 0.6),
              ].sum,
            );
          })
          .sortedByDescending((phraseAndRanking) => phraseAndRanking.$2)
          .take(10)
          .map((phraseAndRanking) => phraseAndRanking.$1)
          .toList();

      return (
        index,
        [
          Choice(phrase: correctPhrase, isCorrect: true),
          ...incorrectPhrases.shuffled().take(3).map((phrase) => Choice(phrase: phrase, isCorrect: false)),
        ].shuffled(),
      );
    }

    final stepState = useState(useMemoized(() => getStep(0)));
    final (currentIndex, choices) = stepState.value;

    usePostFrameEffect(
      () => phraseKeys.elementAtOrNull(currentIndex)?.scrollIntoView(duration: Duration(milliseconds: 300)),
      [currentIndex],
    );

    final errorCountState = useState(0);

    return StyledTransitionBuilder(
      value: errorCountState.value,
      builder: (context, value, child) => StyledDock(
        shrinkWrap: false,
        childrenPadding: .all(16),
        children: [
          ...passagePhrases.mapIndexed(
            (phraseIndex, phrase) => SizedBox(
              width: double.infinity,
              key: phraseKeys[phraseIndex],
              child: StyledSizeAndFade.showHide(
                key: ValueKey(phraseIndex),
                clip: .hardEdge,
                show: currentIndex > phraseIndex,
                child: Padding(
                  padding: .only(bottom: 16),
                  child: Align(alignment: .centerLeft, child: PhraseText.phrase(phrase)),
                ),
              ),
            ),
          ),
        ],
        buttonsColor: Color.lerp(context.colors.surfacePrimary, context.colors.surfaceCritical, value),
        aboveButtons: choices != null
            ? StyledSection(
                title: 'Select the next phrase'.toText(),
                children: choices
                    .map(
                      (choice) => StyledListItem(
                        title: PhraseText.phrase(choice.phrase),
                        onPressed: choice.isCorrect
                            ? () => stepState.value = getStep(currentIndex + 1)
                            : () => errorCountState.value++,
                      ),
                    )
                    .toList(),
                padding: .only(top: 16),
              )
            : null,
        buttonsBuilder: (context) => [
          if (currentIndex + 1 > passagePhrases.length)
            StyledRectButton.secondary(label: 'Reset'.toText(), onPressed: () => stepState.value = getStep(0)),
        ],
      ),
    );
  }
}

class Choice {
  final Phrase phrase;
  final bool isCorrect;

  const Choice({required this.phrase, required this.isCorrect});
}
