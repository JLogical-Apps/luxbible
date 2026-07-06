import 'dart:collection';

import 'package:bible/models/bible/bible.dart';
import 'package:bible/models/reference/verse_selection.dart';
import 'package:bible/models/user/tutorial.dart';
import 'package:bible/models/user/user.dart';
import 'package:bible/style/style.dart';
import 'package:bible/ui/dialogs/tutorial_dialog.dart';
import 'package:bible/ui/widgets/interlinear_word_tile.dart';
import 'package:bible/utils/extensions/collection_extensions.dart';
import 'package:bible/utils/extensions/flutter_string_extensions.dart';
import 'package:bible/utils/extensions/icon_data_extensions.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
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
                  message: 'Using ${user.studyTranslation.title()} for interlinear'.toText(),
                  action: StyledTextAction(
                    label: 'Learn More'.toText(),
                    onPressed: () => context.showStyledDialog(
                      (context) => TutorialDialog(
                        title: 'Interlinear Bible'.toText(),
                        body:
                            "Study Bibles are designed with word-for-word Strong's and morphology tagging, which is what makes the Interlinear lexical breakdown possible. Using your most-recent Study Bible instead."
                                .toText(),
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
