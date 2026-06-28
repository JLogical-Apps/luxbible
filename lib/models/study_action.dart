import 'package:bible/models/reference/region_type.dart';
import 'package:bible/models/reference/verse_selection.dart';
import 'package:bible/models/user/user.dart';
import 'package:bible/providers/bibles_provider.dart';
import 'package:bible/providers/commentaries_provider.dart';
import 'package:bible/providers/cross_references_provider.dart';
import 'package:bible/providers/root_ref.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/style/style.dart';
import 'package:bible/ui/sheets/compare_sheet.dart';
import 'package:bible/ui/sheets/interlinear_sheet.dart';
import 'package:bible/ui/widgets/interlinear_word_tile.dart';
import 'package:bible/utils/extensions/build_context_extensions.dart';
import 'package:bible/utils/extensions/collection_extensions.dart';
import 'package:bible/utils/extensions/flutter_string_extensions.dart';
import 'package:bible/utils/extensions/icon_data_extensions.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
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

  String description({required String? regionFormat, required RegionType regionType}) {
    final regionText = regionFormat ?? regionType.formatThis();
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

  List<Widget> buildSheetChildren(
    BuildContext context, {
    required VerseSelection verseSelection,
    required Function(VerseSelection) onNavigateToVerseSelection,
    required User user,
  }) {
    switch (this) {
      case compare:
        return CompareSheet.buildSheetChildren(
          context,
          verseSelection: verseSelection,
          onNavigateToVerseSelection: onNavigateToVerseSelection,
          user: user,
        );
      case interlinear:
        throw UnimplementedError();
      case commentary:
        final commentaries = ref.read(commentariesProvider);
        final relatedCommentaries = commentaries
            .mapToMap((commentary) => MapEntry(commentary, commentary.getNotesFor(verseSelection)))
            .where((commentary, notes) => notes.isNotEmpty);
        return relatedCommentaries.isEmpty
            ? [
                Padding(
                  padding: .all(16),
                  child: StyledBanner(message: 'No Commentaries Found'.toText()),
                ),
              ]
            : relatedCommentaries
                  .mapToIterable(
                    (commentary, notes) => StyledStickyHeader(
                      title: commentary.type.title().toText(),
                      children: notes
                          .mapToIterable(
                            (verseSelection, note) =>
                                StyledListItem(title: verseSelection.format().toText(), subtitle: note.toText()),
                          )
                          .toList(),
                    ),
                  )
                  .toList();
      case crossReferences:
        final user = ref.read(userProvider);
        final crossReferences = ref.read(crossReferencesProvider);
        final relatedCrossReferences = verseSelection.references
            .mapToMap((reference) => MapEntry(reference, crossReferences[reference]))
            .withoutNullValues;
        return relatedCrossReferences.isEmpty
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
                                final book = references.references.first.book;
                                final translation = user.translation.effectiveFor(book);
                                final verses = ref
                                    .watch(
                                      verseSelectionTextProvider(
                                        translation: translation,
                                        selection: references.toVerseSelection(),
                                      ),
                                    )
                                    .value;
                                return StyledListItem(
                                  title: Row(
                                    spacing: 4,
                                    children: [
                                      references.toVerseSelection().format().toText(),
                                      if (!user.translation.containsBook(book))
                                        StyledTag(child: translation.title().toText()),
                                    ],
                                  ),
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
                  .toList();
    }
  }

  Future<void> onPressed(
    BuildContext context, {
    required VerseSelection verseSelection,
    required String regionFormat,
    required Function(VerseSelection) onNavigateToVerseSelection,
    required User user,
  }) async {
    if (this == .interlinear) {
      context.showStyledSheetWithBreadcrumbs(breadcrumbText: regionFormat, (context) {
        final user = ref.read(userProvider);

        final tabController = useTabController(
          initialLength: InterlinearDirection.values.length,
          initialIndex: user.interlinearDirection.index,
        );

        useOnListenableChange(tabController, () {
          final interlinearDirection = InterlinearDirection.values[tabController.index];
          // Read fresh so the comparison reflects the latest saved preference.
          if (interlinearDirection != ref.read(userProvider).interlinearDirection) {
            ref.updateUser((user) => user.copyWith(interlinearDirection: interlinearDirection));
          }
        });

        final interlinearDirection =
            InterlinearDirection.values[useListenableSelector(tabController, () => tabController.index)];

        return StyledSheet(
          title: 'Interlinear'.toText(),
          subtitle: regionFormat.toText(),
          aboveDivider: StyledTabBar.fill(
            tabController: tabController,
            tabTitles: InterlinearDirection.values.map((direction) => direction.title().toText()).toList(),
          ),
          showDivider: false,
          children: InterlinearSheet.buildSheetChildren(
            context,
            verseSelection: verseSelection,
            onNavigateToVerseSelection: onNavigateToVerseSelection,
            direction: interlinearDirection,
            user: user,
          ),
        );
      });
    } else {
      context.showStyledSheet(
        (context) => StyledSheet(
          title: title().toText(),
          subtitle: regionFormat.toText(),
          children: buildSheetChildren(
            context,
            verseSelection: verseSelection,
            onNavigateToVerseSelection: onNavigateToVerseSelection,
            user: user,
          ),
        ),
      );
    }
  }
}
