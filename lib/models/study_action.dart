import 'dart:collection';

import 'package:bible/models/bible/bible_translation.dart';
import 'package:bible/models/reference/region.dart';
import 'package:bible/models/reference/verse_selection.dart';
import 'package:bible/providers/bibles_provider.dart';
import 'package:bible/providers/commentaries_provider.dart';
import 'package:bible/providers/cross_references_provider.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/style/style.dart';
import 'package:bible/ui/widgets/interlinear_word_tile.dart';
import 'package:bible/utils/extensions/build_context_extensions.dart';
import 'package:bible/utils/extensions/collection_extensions.dart';
import 'package:bible/utils/extensions/icon_data_extensions.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:bible/utils/extensions/string_extensions.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:utils_core/utils_core.dart';

enum StudyAction {
  compare,
  interlinear,
  commentary,
  crossReferences;

  String title() => switch (this) {
    compare => 'Compare',
    interlinear => 'Interlinear',
    commentary => 'Commentary',
    crossReferences => 'Cross References',
  };

  String description({required ReferencesRegion? region, required RegionType regionType}) {
    final regionText = region?.format() ?? regionType.formatThis();
    return switch (this) {
      compare => 'Compare $regionText across a variety of translations.',
      interlinear => 'View a lexical breakdown of $regionText using Strongs.',
      commentary => 'View commentaries of $regionText.',
      crossReferences => 'View cross references of $regionText.',
    };
  }

  IconData get icon => switch (this) {
    compare => Symbols.text_compare,
    interlinear => Symbols.dictionary,
    commentary => Symbols.tooltip_2,
    crossReferences => Symbols.graph_4,
  };

  Future<void> onPressed(
    BuildContext context,
    WidgetRef ref, {
    required ReferencesRegion region,
    required Function(VerseSelection) onNavigateToVerseSelection,
  }) async {
    switch (this) {
      case compare:
        context.showStyledSheet(
          (context) => StyledSheet(
            title: 'Compare'.toText(),
            subtitle: region.format().toText(),
            children: BibleTranslation.values
                .mapIndexed<Widget>(
                  (i, translation) => Consumer(
                    builder: (context, ref, child) {
                      final text = ref
                          .watch(
                            verseSelectionTextProvider(selection: region.toVerseSelection(), translation: translation),
                          )
                          .value;
                      return Stack(
                        children: [
                          StyledStickyHeader.child(
                            title: translation.title().toText(),
                            child: StyledLoading(
                              child: text == null ? null : Padding(padding: .only(bottom: 16), child: text.toText()),
                            ),
                          ),
                          if (i + 1 < BibleTranslation.values.length)
                            Positioned(bottom: 0, left: 0, right: 0, child: StyledDivider(height: 2)),
                        ],
                      );
                    },
                  ),
                )
                .toList(),
          ),
        );
      case interlinear:
        final studyBible = ref.read(studyBibleProvider);

        context.showStyledSheetWithBreadcrumbs(breadcrumbText: region.format(), (context) {
          final user = ref.watch(userProvider); // User can be update tab preference

          final tabController = useTabController(
            initialLength: InterlinearDirection.values.length,
            initialIndex: user.interlinearDirection.index,
          );

          useOnListenableChange(tabController, () {
            final interlinearDirection = InterlinearDirection.values[tabController.index];
            if (interlinearDirection != user.interlinearDirection) {
              ref.updateUser((user) => user.copyWith(interlinearDirection: interlinearDirection));
            }
          });

          final interlinearDirection =
              InterlinearDirection.values[useListenableSelector(tabController, () => tabController.index)];

          return StyledSheet(
            title: 'Interlinear'.toText(),
            subtitle: region.format().toText(),
            aboveDivider: StyledTabBar.fill(
              tabController: tabController,
              tabTitles: InterlinearDirection.values.map((direction) => direction.title().toText()).toList(),
            ),
            showDivider: false,
            children: [
              Padding(
                padding: .all(16),
                child: Column(
                  spacing: 16,
                  children: [
                    StyledTile.message(
                      leading: interlinearDirection.icon().toIcon(),
                      title: interlinearDirection.description().toText(),
                    ),
                    if (user.translation != .bsb)
                      StyledBanner(
                        colorBuilder: .surfaceTertiary,
                        leading: Symbols.book.toIcon(),
                        message: 'Interlinear uses BSB'.toText(),
                        action: StyledTextAction(
                          label: 'Learn More'.toText(),
                          onPressed: () => context.showStyledDialog(
                            (context) => StyledDialog.confirm(
                              title: 'Interlinear Translation'.toText(),
                              body:
                                  "The BSB was designed with word-for-word Strong's and morphology tagging, which is what makes the Interlinear lexical breakdown possible. Your selected translation is used everywhere else in the app."
                                      .toText(),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              ...region.references.mapIndexed((i, reference) {
                final verse = studyBible.getVerseByReference(reference);
                if (verse == null) {
                  return null;
                }

                return Stack(
                  children: [
                    StyledStickyHeader(
                      title: reference.format().toText(),
                      children: verse.words
                          .mapToMap((word) => MapEntry(word, word.data))
                          .withoutNullValues
                          .maybeSortedBy(
                            (word, data) => data.originalPosition,
                            shouldSort: interlinearDirection == .forward,
                          )
                          .mapToIterable(
                            (word, data) => InterlinearWordTile(
                              word: word,
                              data: data,
                              direction: interlinearDirection,
                              onNavigateToVerseSelection: onNavigateToVerseSelection,
                            ),
                          )
                          .toList(),
                    ),
                    if (i + 1 < region.references.length)
                      Positioned(bottom: 0, left: 0, right: 0, child: StyledDivider(height: 2)),
                  ],
                );
              }).nonNulls,
            ],
          );
        });
      case commentary:
        final commentaries = ref.watch(commentariesProvider);
        final relatedCommentaries = commentaries
            .mapToMap((commentary) => MapEntry(commentary, commentary.getNotesFor(region.toVerseSelection())))
            .where((commentary, notes) => notes.isNotEmpty);
        context.showStyledSheet(
          (context) => StyledSheet(
            title: 'Commentary'.toText(),
            subtitle: region.format().toText(),
            children: relatedCommentaries.isEmpty
                ? [
                    Padding(
                      padding: .all(16),
                      child: StyledBanner(message: 'No Commentaries Found'.toText()),
                    ),
                  ]
                : relatedCommentaries
                      .mapToIterable(
                        (commentary, notes) => StyledStickyHeader(
                          title: commentary.name.toText(),
                          children: notes
                              .mapToIterable(
                                (verseSelection, note) =>
                                    StyledListItem(title: verseSelection.format().toText(), subtitle: note.toText()),
                              )
                              .toList(),
                        ),
                      )
                      .toList(),
          ),
        );
      case crossReferences:
        final user = ref.read(userProvider);
        final crossReferences = ref.read(crossReferencesProvider);
        final relatedCrossReferences = crossReferences.where(
          (reference, crossReferences) => region.references.contains(reference),
        );
        context.showStyledSheet(
          (context) => StyledSheet(
            title: 'Cross References'.toText(),
            subtitle: region.format().toText(),
            children: relatedCrossReferences.isEmpty
                ? [
                    Padding(
                      padding: .all(16),
                      child: StyledBanner(message: 'No Cross References Found'.toText()),
                    ),
                  ]
                : relatedCrossReferences
                      .mapToIterable(
                        (reference, crossReferences) => StyledStickyHeader(
                          title: reference.format().toText(),
                          children: crossReferences
                              .map(
                                (references) => Consumer(
                                  builder: (context, ref, child) {
                                    final verses = ref
                                        .watch(
                                          verseSelectionTextProvider(
                                            translation: user.translation,
                                            selection: references.toVerseSelection(),
                                          ),
                                        )
                                        .value;
                                    return StyledListItem(
                                      title: references.toVerseSelection().format().toText(),
                                      subtitle: StyledLoading(child: verses?.toText()),
                                      onPressed: () {
                                        context.pop();
                                        onNavigateToVerseSelection(references.toVerseSelection());
                                      },
                                      trailing: Symbols.expand_circle_right.toIcon(),
                                    );
                                  },
                                ),
                              )
                              .toList(),
                        ),
                      )
                      .toList(),
          ),
        );
    }
  }
}
