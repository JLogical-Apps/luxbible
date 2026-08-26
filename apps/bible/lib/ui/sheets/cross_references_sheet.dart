import 'package:bible/models/user/user.dart';
import 'package:bible/providers/cross_references_provider.dart';
import 'package:bible/providers/root_ref.dart';
import 'package:bible/ui/dialogs/tutorial_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';
import 'package:utils_core/utils_core.dart';

class CrossReferencesSheet {
  static List<Widget> buildSheetChildren(
    BuildContext context, {
    required VerseSelection verseSelection,
    required Function(VerseSelection) onNavigateToVerseSelection,
    required User user,
    bool popOnAction = true,
  }) {
    final crossReferences = ref.read(crossReferencesProvider);
    final crossReferenceTranslation = user.translation.isOnline ? user.studyTranslation : user.translation;
    final showStudyBanner = user.translation.isOnline && !user.tutorials.has(.crossReferencesStudy);
    final crossReferenceSpans = verseSelection.references
        .map((reference) => crossReferences[reference])
        .nonNulls
        .fold(<VerseSpanReference, int>{}, (totalVoteBySpan, voteBySpan) {
          voteBySpan.forEach((span, vote) => totalVoteBySpan.update(span, (v) => v + vote, ifAbsent: () => vote));
          return totalVoteBySpan;
        })
        .sortedByDescending((span, votes) => votes)
        .keys
        .toList();

    return crossReferenceSpans.isEmpty
        ? [
            Padding(
              padding: .all(16),
              child: StyledBanner(message: t.studyActions.noCrossReferences.toText()),
            ),
          ]
        : [
            if (showStudyBanner)
              Padding(
                padding: .all(16),
                child: StyledBanner(
                  colorBuilder: .surfaceTertiary,
                  leading: Symbols.book.toIcon(),
                  message: t.studyActions.crossReferencesUse(translation: user.studyTranslation.title()).toText(),
                  action: StyledTextAction(
                    label: t.common.learnMore.toText(),
                    onPressed: () => context.showStyledDialog(
                      (context) => TutorialDialog(
                        title: t.studyActions.crossReferences.toText(),
                        body: t.studyActions.onlineCrossReferencesExplanation.toText(),
                        tutorial: .crossReferencesStudy,
                      ),
                    ),
                  ),
                ),
              ),
            ...crossReferenceSpans.map(
              (crossReference) => Consumer(
                key: ValueKey(crossReference),
                builder: (context, ref, child) {
                  final verseSelection = crossReference.toVerseSelection();
                  final book = crossReference.references.first.book;
                  final translation = crossReferenceTranslation == user.translation
                      ? user.getTranslationFor(book)
                      : crossReferenceTranslation.effectiveFor(book);
                  final verses = ref
                      .watch(verseSelectionVersesProvider(translation: translation, selection: verseSelection))
                      .value;
                  return StyledListItem.navigation(
                    title: Row(
                      spacing: 4,
                      children: [
                        verseSelection.format().toText(),
                        if (!crossReferenceTranslation.containsBook(book))
                          StyledTag.sm(child: translation.title().toText()),
                      ],
                    ),
                    subtitle: StyledLoading(
                      child: verses?.mapIfNonNull(
                        (verses) => VerseText(redLetters: user.themeLayout.redLetters, verses: verses),
                      ),
                    ),
                    onPressed: () => PassagePreviewPage.show(
                      context,
                      verseSelection: verseSelection,
                      onNavigateToVerseSelection: (selection) {
                        if (popOnAction) context.pop();
                        onNavigateToVerseSelection(selection);
                      },
                    ),
                  );
                },
              ),
            ),
          ];
  }
}
