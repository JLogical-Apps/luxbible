import 'dart:collection';

import 'package:lux/lux.dart';
import 'package:collection/collection.dart';
import 'package:lux/i18n.dart';
import 'package:flutter/material.dart';
import 'package:bible/models/user/tutorial.dart';
import 'package:bible/models/user/user.dart';
import 'package:bible/ui/dialogs/tutorial_dialog.dart';
import 'package:bible/ui/widgets/interlinear_word_tile.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';
import 'package:utils_core/utils_core.dart';

class InterlinearSheet {
  static List<Widget> buildSheetChildren(
    BuildContext context, {
    required VerseSelection verseSelection,
    required Function(VerseSelection) onNavigateToVerseSelection,
    required InterlinearDirection direction,
    required User user,
    required Bible studyBible,
    bool showDirectionBanner = true,
    bool popOnAction = true,
  }) {
    final showInterlinearStudyBanner = !user.translation.isStudy && !user.tutorials.contains(Tutorial.interlinearStudy);

    return [
      if (showDirectionBanner || showInterlinearStudyBanner)
        Padding(
          padding: .all(16),
          child: Column(
            spacing: 16,
            children: [
              if (showDirectionBanner)
                StyledTile.message(leading: direction.icon.toIcon(), title: direction.description().toText()),
              if (showInterlinearStudyBanner)
                StyledBanner(
                  colorBuilder: .surfaceTertiary,
                  leading: Symbols.book.toIcon(),
                  message: t.interlinearUi.usingTranslation(translation: user.studyTranslation.title()).toText(),
                  action: StyledTextAction(
                    label: t.common.learnMore.toText(),
                    onPressed: () => context.showStyledDialog(
                      (context) => TutorialDialog(
                        title: t.interlinearUi.interlinearBible.toText(),
                        body: t.interlinearUi.studyBibleExplanation.toText(),
                        tutorial: .interlinearStudy,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ...StyledDivider(height: 2).wrapPositioned(
        verseSelection.references
            .mapIndexed((i, reference) {
              final verse = studyBible.getVerseByReference(reference);
              if (verse == null) {
                return null;
              }

              return StyledStickyHeader(
                title: reference.format().toText(),
                children: verse.words
                    .mapToMap((word) => MapEntry(word, word.data))
                    .withoutNullValues
                    .maybeSortedBy((word, data) => data.originalPosition, shouldSort: direction == .forward)
                    .mapToIterable(
                      (word, data) => InterlinearWordTile(
                        word: word,
                        data: data,
                        direction: direction,
                        onNavigateToVerseSelection: onNavigateToVerseSelection,
                        popOnAction: popOnAction,
                      ),
                    )
                    .toList(),
              );
            })
            .nonNulls
            .toList(),
      ),
    ];
  }
}
