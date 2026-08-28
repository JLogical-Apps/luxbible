import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/lux.dart';
import 'package:memory/models/activity_plan.dart';
import 'package:style/style.dart';
import 'package:utils_core/utils_core.dart';

class WordSelectionBuilder extends HookConsumerWidget {
  final WordSelectionActivityPlan plan;

  const WordSelectionBuilder({super.key, required this.plan});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bible = ref.watch(localBibleProvider(translation: .bsb)).value;
    if (bible == null) {
      return StyledLoading(loadingPadding: .all(16));
    }

    final passageWords = bible.getPassageVerses(plan.passage).expand((words) => getVerseWords(words)).toList();
    final wordKeys = useMemoized(() => passageWords.map((_) => GlobalKey()).toList());

    final availableWords = useMemoized(
      () => bible.verseByReference.values
          .expand((verse) => getVerseWords(verse))
          .map((word) => word.text)
          .toList()
          .distinctBy((word) => word.toLowerCase().withoutPunctuation)
          .toList(),
    );
    final previousWordsByWord = useMemoized(
      () => bible.words
          .skipLast(1)
          .mapIndexed((index, previousWord) => (previousWord, bible.words[index + 1]))
          .groupListsBy((words) => words.$2.toLowerCase().withoutPunctuation)
          .mapValues((word, previousWords) => previousWords.map((word) => word.$1).toList()),
    );

    (int currentIndex, List<WordChoice>?) getStep(int index) {
      if (index == passageWords.length) return (index, null);

      final correctWord = passageWords[index];
      final correctWordWithoutPunctuation = correctWord.text.withoutPunctuation;

      final previousCorrectWord = index == 0
          ? plan.passage.references.first.previousOrNull
                ?.mapIfNonNull((reference) => bible.getVerseByReference(reference))
                ?.mapIfNonNull((verse) => verse.text.words.last)
          : passageWords[index - 1].text;
      final previousCorrectWordWithoutPunctuation = previousCorrectWord?.withoutPunctuation;

      final incorrectWords = availableWords
          .where((word) => word.toLowerCase().withoutPunctuation != correctWordWithoutPunctuation.toLowerCase())
          .where((word) => word[0].isUpperCase == correctWordWithoutPunctuation[0].isUpperCase)
          .where((word) => word.lastLetter.isPunctuation == correctWord.text.lastLetter.isPunctuation)
          .map((word) {
            final wordWithoutPunctuation = word.withoutPunctuation;
            final previousWords = previousWordsByWord[wordWithoutPunctuation.toLowerCase()] ?? [];
            return (
              word,
              [
                if (previousCorrectWord != null && previousCorrectWordWithoutPunctuation != null)
                  ...previousWords.map(
                    (word) => word.toLowerCase() == previousCorrectWord.toLowerCase()
                        ? 3
                        : wordWithoutPunctuation.toLowerCase() == previousCorrectWordWithoutPunctuation.toLowerCase()
                        ? 1
                        : 0,
                  ),
              ].sum,
            );
          })
          .where((wordAndValue) => wordAndValue.$2 > 0)
          .sortedByDescending((wordAndValue) => wordAndValue.$2)
          .map((wordAndValue) => wordAndValue.$1)
          .take(10)
          .shuffled()
          .take(3)
          .toList();

      return (
        index,
        [
          WordChoice(text: correctWord.text, isCorrect: true),
          ...incorrectWords.map((word) => WordChoice(text: word, isCorrect: false)),
        ].sortedBy((choice) => choice.text.toLowerCase()),
      );
    }

    final stepState = useState(useMemoized(() => getStep(0)));
    final (currentIndex, choices) = stepState.value;

    usePostFrameEffect(
      () => wordKeys.elementAtOrNull(currentIndex)?.scrollIntoView(duration: Duration(milliseconds: 300)),
      [currentIndex],
    );

    final errorCountState = useState(0);

    return StyledTransitionBuilder(
      value: errorCountState.value,
      builder: (context, value, child) => StyledDock(
        shrinkWrap: false,
        childrenPadding: .all(16),
        children: [
          Wrap(
            spacing: 6,
            runSpacing: 8,
            children: passageWords
                .mapIndexed(
                  (wordIndex, word) => AnimatedOpacity(
                    key: wordKeys[wordIndex],
                    opacity: currentIndex > wordIndex ? 1 : 0,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOutCubic,
                    child: Text(
                      word.text,
                      style: context.textStyle.paragraphLg.copyWith(
                        color: word.redLetters ? context.colors.red.dark : null,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
        buttonsColor: Color.lerp(context.colors.surfacePrimary, context.colors.surfaceCritical, value),
        aboveButtons: choices == null
            ? null
            : StyledSection(
                title: 'Select the next word'.toText(),
                children: choices
                    .map(
                      (choice) => StyledListItem(
                        title: choice.text.toText(),
                        onPressed: choice.isCorrect
                            ? () => stepState.value = getStep(currentIndex + 1)
                            : () => errorCountState.value++,
                      ),
                    )
                    .toList(),
                padding: .only(top: 16),
              ),
        buttonsBuilder: (context) => [
          if (currentIndex + 1 > passageWords.length)
            StyledRectButton.secondary(label: 'Reset'.toText(), onPressed: () => stepState.value = getStep(0)),
        ],
      ),
    );
  }
}

List<SelectionWord> getVerseWords(Verse verse) => verse.words
    .expand((word) => word.text!.words.map((w) => SelectionWord(text: w, redLetters: word.redLetters)))
    .toList();

class SelectionWord {
  final String text;
  final bool redLetters;

  SelectionWord({required this.text, required this.redLetters});
}

class WordChoice {
  final String text;
  final bool isCorrect;

  WordChoice({required this.text, required this.isCorrect});
}
