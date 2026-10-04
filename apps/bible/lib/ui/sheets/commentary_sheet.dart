import 'package:bible/models/commentary_type.dart';
import 'package:bible/providers/commentary_provider.dart';
import 'package:bible/ui/widgets/commentary_content.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:style/style.dart';

class CommentarySheet {
  static List<Widget> buildSheetChildren(
    BuildContext context,
    WidgetRef ref, {
    required VerseSelection verseSelection,
    required CommentaryType commentaryType,
    required Function(VerseSelection) onNavigateToVerseSelection,
    Function(int)? onNavigateToIndex,
  }) {
    final book = verseSelection.references.first.book;
    final commentary = ref.watch(commentaryProvider(type: commentaryType, book: book)).value;
    if (commentary == null) {
      return [Padding(padding: .all(16), child: StyledLoading())];
    }

    final hasBookSections = verseSelection.references.any(
      (reference) => reference.chapterNum == 1 && reference.verseNum == 1,
    );
    final contentByBookSection = {if (hasBookSections) ...commentary.contentByBookSection};
    final blocks = commentary.getBlocksFor(verseSelection);
    final itemCount = contentByBookSection.length + blocks.length;

    Widget? getNavigation(int index) => onNavigateToIndex == null
        ? null
        : CommentaryHeaderNavigation(index: index, itemCount: itemCount, onNavigateToIndex: onNavigateToIndex);

    final children = [
      ...contentByBookSection.entries.mapIndexed(
        (index, entry) => CommentaryBookSectionView(
          book: book,
          section: entry.key,
          content: entry.value,
          onNavigateToVerseSelection: onNavigateToVerseSelection,
          trailing: getNavigation(index),
        ),
      ),
      ...blocks.mapIndexed(
        (index, block) => CommentaryBlockView(
          block: block,
          onNavigateToVerseSelection: onNavigateToVerseSelection,
          trailing: getNavigation(index + contentByBookSection.length),
        ),
      ),
    ];

    return children.isEmpty
        ? [
            Padding(
              padding: .all(16),
              child: StyledBanner(message: t.emptyStates.noCommentaries.toText()),
            ),
          ]
        : StyledDivider(height: 2).wrapPositioned(children);
  }
}
