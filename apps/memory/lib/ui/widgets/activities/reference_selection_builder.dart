import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/lux.dart';
import 'package:memory/models/activity_plan.dart';
import 'package:style/style.dart';

class ReferenceSelectionBuilder extends HookConsumerWidget {
  final ReferenceSelectionActivityPlan plan;

  const ReferenceSelectionBuilder({super.key, required this.plan});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final verses = ref.watch(verseSelectionVersesProvider(translation: .bsb, selection: plan.passage)).value;
    if (verses == null) {
      return StyledLoading(loadingPadding: .all(16));
    }

    final isCompletedState = useState(false);
    final errorCountState = useState(0);
    final choices = useMemoized(() => getReferenceChoices(plan.passage), [plan.passage]);

    return StyledTransitionBuilder(
      value: errorCountState.value,
      builder: (context, value, child) => StyledDock(
        shrinkWrap: false,
        childrenPadding: .all(16),
        children: [VerseText(verses: verses, style: context.textStyle.paragraphLg)],
        buttonsColor: Color.lerp(context.colors.surfacePrimary, context.colors.surfaceCritical, value),
        aboveButtons: isCompletedState.value
            ? null
            : StyledSection(
                title: 'Select the correct reference'.toText(),
                children: choices
                    .map(
                      (choice) => StyledListItem(
                        title: choice.passage.format().toText(),
                        onPressed: choice.isCorrect
                            ? () => isCompletedState.value = true
                            : () => errorCountState.value++,
                      ),
                    )
                    .toList(),
                padding: .only(top: 16),
              ),
        buttonsBuilder: (context) => [
          if (isCompletedState.value)
            StyledRectButton.secondary(label: 'Reset'.toText(), onPressed: () => isCompletedState.value = false),
        ],
      ),
    );
  }
}

List<ReferenceChoice> getReferenceChoices(VerseSelection correctPassage) {
  final correctReference = correctPassage.references.first;
  final books = [
    correctReference.book,
    ...BookType.values
        .where((book) => book != correctReference.book && book.testament == correctReference.book.testament)
        .shuffled()
        .take(2),
  ];
  final correctRange = (
    chapterNum: correctReference.chapterNum,
    startVerseNum: correctReference.verseNum,
    endVerseNum: correctReference.verseNum + correctPassage.references.length - 1,
  );
  final generatedRanges = Iterable.generate(100, (_) {
    final chapterNum = Random().nextInt(correctReference.book.bookInfo.numChapters) + 1;
    final startVerseNum = Random().nextInt(correctReference.book.bookInfo.getNumVerses(chapterNum)) + 1;
    return (
      chapterNum: chapterNum,
      startVerseNum: startVerseNum,
      endVerseNum: startVerseNum + correctPassage.references.length - 1,
    );
  }).where((range) => range != correctRange).distinct.take(2).toList();

  final ranges = [correctRange, ...generatedRanges];
  final combinations = [
    (bookIndex: 0, rangeIndex: 0),
    (bookIndex: 0, rangeIndex: 1),
    (bookIndex: 1, rangeIndex: 0),
    (bookIndex: 1, rangeIndex: 2),
    (bookIndex: 2, rangeIndex: 1),
    (bookIndex: 2, rangeIndex: 2),
  ];

  return combinations
      .map((combination) {
        final isCorrect = combination == combinations.first;
        return ReferenceChoice(
          passage: isCorrect
              ? correctPassage
              : getPassageSelection(book: books[combination.bookIndex], range: ranges[combination.rangeIndex]),
          isCorrect: isCorrect,
        );
      })
      .sortedBy((choice) => choice.passage.spans.first.start.startReference);
}

VerseSelection getPassageSelection({
  required BookType book,
  required ({int chapterNum, int startVerseNum, int endVerseNum}) range,
}) {
  final start = Reference(book: book, chapterNum: range.chapterNum, verseNum: range.startVerseNum);
  final end = Reference(book: book, chapterNum: range.chapterNum, verseNum: range.endVerseNum);
  return VerseSelection(
    spans: [
      VerseSpanReference(
        start: VerseBiblePointer(reference: start),
        end: start == end ? null : VerseBiblePointer(reference: end),
      ),
    ],
  );
}

class ReferenceChoice {
  final VerseSelection passage;
  final bool isCorrect;

  ReferenceChoice({required this.passage, required this.isCorrect});
}
