import 'package:bible/models/user/user.dart';
import 'package:bible/providers/cross_references_provider.dart';
import 'package:bible/providers/root_ref.dart';
import 'package:bible/ui/dialogs/tutorial_dialog.dart';
import 'package:bible/ui/widgets/passage_list_item.dart';
import 'package:flutter/material.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';

class CrossReferencesSheet {
  static List<Widget> buildSheetChildren(
    BuildContext context, {
    required VerseSelection verseSelection,
    required Function(VerseSelection) onNavigateToVerseSelection,
    required User user,
    bool popOnAction = true,
  }) {
    final crossReferences = ref.read(crossReferencesProvider);
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
              (crossReference) => PassageListItem(
                key: ValueKey(crossReference),
                verseSelection: crossReference.toVerseSelection(),
                onPressed: () => PassagePreviewPage.show(
                  context,
                  verseSelection: crossReference.toVerseSelection(),
                  onNavigateToVerseSelection: (selection) {
                    if (popOnAction) context.pop();
                    onNavigateToVerseSelection(selection);
                  },
                ),
              ),
            ),
          ];
  }
}
