import 'dart:collection';

import 'package:bible/models/reference/verse_selection.dart';
import 'package:bible/models/user/tutorial.dart';
import 'package:bible/models/user/user.dart';
import 'package:bible/providers/bibles_provider.dart';
import 'package:bible/providers/root_ref.dart';
import 'package:bible/style/style.dart';
import 'package:bible/ui/widgets/interlinear_word_tile.dart';
import 'package:bible/utils/extensions/build_context_extensions.dart';
import 'package:bible/utils/extensions/collection_extensions.dart';
import 'package:bible/utils/extensions/flutter_string_extensions.dart';
import 'package:bible/utils/extensions/icon_data_extensions.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
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
    bool showDirectionBanner = true,
    bool popOnAction = true,
  }) {
    final studyBible = ref.read(studyBibleProvider);
    final showInterlinearBsbBanner = user.translation != .bsb && !user.tutorials.contains(Tutorial.interlinearBsb);

    return [
      if (showDirectionBanner || showInterlinearBsbBanner)
        Padding(
          padding: .all(16),
          child: Column(
            spacing: 16,
            children: [
              if (showDirectionBanner)
                StyledTile.message(leading: direction.icon.toIcon(), title: direction.description().toText()),
              if (showInterlinearBsbBanner)
                StyledBanner(
                  colorBuilder: .surfaceTertiary,
                  leading: Symbols.book.toIcon(),
                  message: 'Interlinear uses BSB'.toText(),
                  action: StyledTextAction(
                    label: 'Learn More'.toText(),
                    onPressed: () => context.showStyledDialog(
                      (context) => StyledDialog(
                        title: 'Interlinear Bible'.toText(),
                        body:
                            "The BSB was designed with word-for-word Strong's and morphology tagging, which is what makes the Interlinear lexical breakdown possible. Your selected translation is used everywhere else in the app."
                                .toText(),
                        buttonsBuilder: (context) => [
                          StyledRectButton.secondary(
                            label: "Don't Show Again".toText(),
                            onPressed: () {
                              ref.updateUser((user) => user.withTutorial(.interlinearBsb));
                              context.pop();
                            },
                          ),
                          StyledRectButton.primary(label: 'Ok'.toText(), onPressed: () => context.pop()),
                        ],
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
