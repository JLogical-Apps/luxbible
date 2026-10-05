import 'package:bible/models/commentary.dart';
import 'package:bible/models/rich_content.dart';
import 'package:bible/ui/widgets/rich_content_view.dart';
import 'package:flutter/material.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';

class CommentaryBookSectionView extends StatelessWidget {
  final BookType book;
  final CommentaryBookSection section;
  final List<RichContent> content;
  final Function(VerseSelection) onNavigateToVerseSelection;
  final Widget? trailing;

  const CommentaryBookSectionView({
    super.key,
    required this.book,
    required this.section,
    required this.content,
    required this.onNavigateToVerseSelection,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final bookTitle = book.title(isPlural: true);
    return CommentarySectionContainer(
      title: switch (section) {
        .summary => t.commentaryUi.atAGlance(book: bookTitle),
        .introduction => t.commentaryUi.introTo(book: bookTitle),
      },
      content: content,
      onNavigateToVerseSelection: onNavigateToVerseSelection,
      trailing: trailing,
    );
  }
}

class CommentaryBlockView extends StatelessWidget {
  final CommentaryBlock block;
  final Function(VerseSelection) onNavigateToVerseSelection;
  final Function(VerseSelection)? onOutlineSelectionPressed;
  final Widget? trailing;

  const CommentaryBlockView({
    super.key,
    required this.block,
    required this.onNavigateToVerseSelection,
    this.onOutlineSelectionPressed,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) => switch (block) {
    CommentaryOutline(:final items) => StyledStickyHeader.child(
      title: t.commentaryUi.chapterOutline.toText(),
      trailing: trailing,
      childPadding: .zero,
      headerPadding: .symmetric(horizontal: 16, vertical: trailing == null ? 16 : 8),
      child: Column(
        crossAxisAlignment: .stretch,
        children: items
            .map(
              (item) => StyledListItem.navigation(
                title: MarkdownBuilder(item.text),
                subtitle: item.selection.format().toText(),
                onPressed: () => (onOutlineSelectionPressed ?? onNavigateToVerseSelection)(item.selection),
              ),
            )
            .toList(),
      ),
    ),
    CommentarySection(:final selection, :final content) => CommentarySectionContainer(
      title: selection.format(),
      content: content,
      onNavigateToVerseSelection: onNavigateToVerseSelection,
      trailing: trailing,
    ),
  };
}

class CommentarySectionContainer extends StatelessWidget {
  final String title;
  final List<RichContent> content;
  final Function(VerseSelection) onNavigateToVerseSelection;
  final Widget? trailing;

  const CommentarySectionContainer({
    super.key,
    required this.title,
    required this.content,
    required this.onNavigateToVerseSelection,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) => StyledStickyHeader.child(
    title: title.toText(),
    trailing: trailing,
    headerPadding: .symmetric(horizontal: 16, vertical: trailing == null ? 16 : 8),
    child: Padding(
      padding: .only(bottom: 16),
      child: RichContentList(content: content, onNavigateToVerseSelection: onNavigateToVerseSelection),
    ),
  );
}

class CommentaryHeaderNavigation extends StatelessWidget {
  final int index;
  final int itemCount;
  final Function(int) onNavigateToIndex;

  const CommentaryHeaderNavigation({
    super.key,
    required this.index,
    required this.itemCount,
    required this.onNavigateToIndex,
  });

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: .min,
    spacing: 4,
    children: [
      Visibility(
        visible: index > 0,
        maintainSize: true,
        maintainAnimation: true,
        maintainState: true,
        child: Tooltip(
          message: t.commentaryUi.previousSection,
          child: StyledCircleButton.md(
            child: Symbols.arrow_upward.toIcon(),
            onPressed: () => onNavigateToIndex(index - 1),
          ),
        ),
      ),
      Visibility(
        visible: index < itemCount - 1,
        maintainSize: true,
        maintainAnimation: true,
        maintainState: true,
        child: Tooltip(
          message: t.commentaryUi.nextSection,
          child: StyledCircleButton.md(
            child: Symbols.arrow_downward.toIcon(),
            onPressed: () => onNavigateToIndex(index + 1),
          ),
        ),
      ),
    ],
  );
}
