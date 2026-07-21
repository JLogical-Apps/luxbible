import 'package:bible/models/bible/bible_translation.dart';
import 'package:bible/models/reference/region_type.dart';
import 'package:bible/models/reference/verse_selection.dart';
import 'package:bible/models/reference/verse_span_reference.dart';
import 'package:bible/models/user/tutorial.dart';
import 'package:bible/models/user/user.dart';
import 'package:bible/providers/bibles_provider.dart';
import 'package:bible/providers/cross_references_provider.dart';
import 'package:bible/providers/root_ref.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/style/style.dart';
import 'package:bible/ui/dialogs/tutorial_dialog.dart';
import 'package:bible/ui/pages/chapter_preview_page.dart';
import 'package:bible/ui/sheets/commentary_sheet.dart';
import 'package:bible/ui/sheets/compare_sheet.dart';
import 'package:bible/ui/sheets/interlinear_sheet.dart';
import 'package:bible/ui/widgets/interlinear_word_tile.dart';
import 'package:bible/ui/widgets/swipe_gesture_detector.dart';
import 'package:bible/ui/widgets/verse_text.dart';
import 'package:bible/utils/extensions/build_context_extensions.dart';
import 'package:bible/utils/extensions/collection_extensions.dart';
import 'package:bible/utils/extensions/flutter_string_extensions.dart';
import 'package:bible/utils/extensions/icon_data_extensions.dart';
import 'package:bible/utils/extensions/object_extensions.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

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

  BibleTranslation? getTranslationOverride({required User user}) => switch (this) {
    interlinear => user.translation.isStudy ? null : user.studyTranslation,
    crossReferences => user.translation.isLocal ? null : user.studyTranslation,
    _ => null,
  };

  List<Widget> buildSheetChildren(
    BuildContext context, {
    required VerseSelection verseSelection,
    required Function(VerseSelection) onNavigateToVerseSelection,
    required User user,
    bool popOnAction = true,
  }) {
    switch (this) {
      case compare:
        return CompareSheet.buildSheetChildren(context, verseSelection: verseSelection, user: user);
      case interlinear:
        throw UnimplementedError();
      case commentary:
        throw UnimplementedError();
      case crossReferences:
        final user = ref.read(userProvider);
        final crossReferences = ref.read(crossReferencesProvider);

        final crossReferenceTranslation = user.translation.isOnline ? user.studyTranslation : user.translation;
        final showCrossReferencesStudyBanner =
            user.translation.isOnline && !user.tutorials.contains(Tutorial.crossReferencesStudy);

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
                  child: StyledBanner(message: 'No Cross References Found'.toText()),
                ),
              ]
            : [
                if (showCrossReferencesStudyBanner)
                  Padding(
                    padding: .all(16),
                    child: StyledBanner(
                      colorBuilder: .surfaceTertiary,
                      leading: Symbols.book.toIcon(),
                      message: 'Cross references use ${user.studyTranslation.title()}'.toText(),
                      action: StyledTextAction(
                        label: 'Learn More'.toText(),
                        onPressed: () => context.showStyledDialog(
                          (context) => TutorialDialog(
                            title: 'Cross References'.toText(),
                            body:
                                'Because your selected translation is only available online, cross references are shown using the latest Study Bible you used to save on performance and costs. Your selected translation is used everywhere else in the app.'
                                    .toText(),
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
                        subtitle: StyledLoading(child: verses?.mapIfNonNull((verses) => VerseText(verses: verses))),
                        onPressed: () => ChapterPreviewPage.show(
                          context,
                          verseSelection: verseSelection,
                          onNavigateToPassage: () {
                            if (popOnAction) context.pop();
                            onNavigateToVerseSelection(verseSelection);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ];
    }
  }

  Future<void> onPressed(
    BuildContext context, {
    required VerseSelection verseSelection,
    required String regionFormat,
    required Function(VerseSelection) onNavigateToVerseSelection,
    required User user,
  }) async {
    if (this == crossReferences) ref.markOnboardingStep(.crossReferences);

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

        return StyledSheet.builder(
          title: 'Interlinear'.toText(),
          subtitle: Row(
            mainAxisAlignment: .center,
            spacing: 8,
            children: [
              regionFormat.toText(),
              if (user.translation != user.studyTranslation)
                StyledTag.sm(child: user.studyTranslation.title().toText()),
            ],
          ),
          aboveDivider: StyledTabBar.fill(
            tabController: tabController,
            tabTitles: InterlinearDirection.values.map((direction) => direction.title().toText()).toList(),
          ),
          showDivider: false,
          childrenBuilder: (context, ref) {
            final studyBible = ref.watch(studyBibleProvider).value;
            if (studyBible == null) {
              return [Padding(padding: .all(16), child: StyledLoading())];
            }
            return InterlinearSheet.buildSheetChildren(
              context,
              verseSelection: verseSelection,
              onNavigateToVerseSelection: onNavigateToVerseSelection,
              direction: interlinearDirection,
              user: user,
              studyBible: studyBible,
            );
          },
        );
      });
    } else if (this == .commentary) {
      context.showStyledSheet((context) {
        final tabController = useTabController(initialLength: user.commentariesOrDefault.length);
        final index = useListenableSelector(tabController, () => tabController.index);
        final selectedCommentary = user.commentariesOrDefault[index];

        return StyledSheet(
          title: title().toText(),
          subtitle: regionFormat.toText(),
          shrinkWrap: false,
          aboveDivider: StyledTabBar.scrollable(
            tabController: tabController,
            tabTitles: user.commentariesOrDefault.map((type) => type.title().toText()).toList(),
          ),
          showDivider: false,
          childrenWrapper: (context, child) => SwipeGestureDetector(
            index: () => index,
            maxIndex: tabController.length,
            onSwipe: (newIndex) =>
                tabController.animateTo(newIndex, duration: Duration(milliseconds: 300), curve: Curves.easeInOutCubic),
            child: child,
          ),
          children: CommentarySheet.buildSheetChildren(
            context,
            verseSelection: verseSelection,
            commentary: selectedCommentary,
            onNavigateToVerseSelection: (verseSelection) {
              context.pop();
              onNavigateToVerseSelection(verseSelection);
            },
          ),
        );
      });
    } else {
      context.showStyledSheet(
        (context) => StyledSheet(
          title: title().toText(),
          subtitle: SingleChildScrollView(
            scrollDirection: .horizontal,
            child: Row(
              mainAxisAlignment: .center,
              spacing: 8,
              children: [
                regionFormat.toText(),
                if (getTranslationOverride(user: user) case final override?)
                  StyledTag.sm(child: override.title().toText()),
              ],
            ),
          ),
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
