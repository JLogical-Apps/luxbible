import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/lux.dart';
import 'package:memory/models/activity_plan.dart';
import 'package:memory/ui/widgets/phrase_text.dart';
import 'package:style/style.dart';

class PhraseSelectionBuilder extends HookConsumerWidget {
  final PhraseSelectionActivityPlan plan;

  const PhraseSelectionBuilder({super.key, required this.plan});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final verses = ref.watch(verseSelectionVersesProvider(translation: .bsb, selection: plan.passage)).value;
    if (verses == null) {
      return SizedBox.shrink();
    }

    final phrases = verses.expand((verse) => Phrase.fromVerse(verse)).toList();
    final phraseKeys = useMemoized(() => phrases.map((_) => GlobalKey()).toList(), []);

    (int currentIndex, List<Choice>?) getStep(int index) {
      if (index == phrases.length) return (index, null);

      final incorrectPhrases = phrases.skip(index + 1).toList();
      final remainingIncorrectPhrases = 3 - incorrectPhrases.length;
      if (remainingIncorrectPhrases > 0) {
        incorrectPhrases.addAll(phrases.take((index - 1).clampZero).shuffled().take(remainingIncorrectPhrases));
      }
      incorrectPhrases.shuffle();

      final correctAnswer = Random().nextInt(4);
      return (
        index,
        List.generate(4, (i) {
          if (i == correctAnswer) return Choice(phrase: phrases[index], isCorrect: true);
          if (incorrectPhrases.elementAtOrNull(i) case final phrase?) return Choice(phrase: phrase, isCorrect: false);
          return null;
        }).nonNulls.toList(),
      );
    }

    final stepState = useState(getStep(0));
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
          ...phrases.mapIndexed(
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
          if (currentIndex + 1 > phrases.length)
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
