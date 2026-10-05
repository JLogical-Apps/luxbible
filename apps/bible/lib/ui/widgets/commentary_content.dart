import 'package:bible/models/article.dart';
import 'package:bible/models/commentary.dart';
import 'package:bible/providers/articles_provider.dart';
import 'package:bible/providers/root_ref.dart';
import 'package:bible/ui/sheets/article_sheet.dart';
import 'package:bible/ui/sheets/preview_passage_sheet.dart';
import 'package:bible/ui/widgets/bible_map_card.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';

class CommentaryBookSectionView extends StatelessWidget {
  final BookType book;
  final CommentaryBookSection section;
  final List<CommentaryContent> content;
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
  final List<CommentaryContent> content;
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
      child: CommentaryContentList(content: content, onNavigateToVerseSelection: onNavigateToVerseSelection),
    ),
  );
}

class CommentaryContentList extends StatelessWidget {
  final List<CommentaryContent> content;
  final Function(VerseSelection) onNavigateToVerseSelection;

  const CommentaryContentList({super.key, required this.content, required this.onNavigateToVerseSelection});

  @override
  Widget build(BuildContext context) => DefaultTextStyle(
    style: context.textStyle.paragraphMd,
    child: Column(
      crossAxisAlignment: .stretch,
      spacing: 12,
      children: content
          .map((block) => CommentaryContentView(content: block, onNavigateToVerseSelection: onNavigateToVerseSelection))
          .toList(),
    ),
  );
}

class CommentaryContentView extends StatelessWidget {
  final CommentaryContent content;
  final Function(VerseSelection) onNavigateToVerseSelection;

  const CommentaryContentView({super.key, required this.content, required this.onNavigateToVerseSelection});

  @override
  Widget build(BuildContext context) => switch (content) {
    CommentaryParagraph(:final text, :final style) => CommentaryParagraphView(
      text: text,
      style: style,
      onNavigateToVerseSelection: onNavigateToVerseSelection,
    ),
    CommentaryTable(:final rows) => CommentaryTableView(
      rows: rows,
      onNavigateToVerseSelection: onNavigateToVerseSelection,
    ),
    CommentaryBibleMap(:final id) => BibleMapCard(mapId: id),
    CommentaryBox(:final title, :final content) => StyledTile(
      padding: .all(16),
      child: Column(
        crossAxisAlignment: .stretch,
        spacing: 12,
        children: [
          Text(title, style: context.textStyle.headingXxs),
          CommentaryContentList(content: content, onNavigateToVerseSelection: onNavigateToVerseSelection),
        ],
      ),
    ),
  };
}

Future<void> openCommentaryLink(
  BuildContext context,
  String link, {
  required Function(VerseSelection) onNavigateToVerseSelection,
}) async {
  if (!link.startsWith(Article.dictionaryLinkPrefix)) {
    return PreviewPassageSheet.show(
      context,
      verseSelection: VerseSelection.fromOsisId(link),
      onNavigateToVerseSelection: onNavigateToVerseSelection,
    );
  }

  final articleId = link.substring(Article.dictionaryLinkPrefix.length);
  final dictionary = await ref.read(articlesProvider(collection: .dictionary).future);
  final article = dictionary.firstWhereOrNull((article) => article.id == articleId);
  if (article == null || !context.mounted) return;

  await ArticleSheet.show(
    context,
    collection: .dictionary,
    article: article,
    onNavigateToVerseSelection: onNavigateToVerseSelection,
  );
}

class CommentaryParagraphView extends StatelessWidget {
  final Markdown text;
  final CommentaryParagraphStyle style;
  final Function(VerseSelection) onNavigateToVerseSelection;

  const CommentaryParagraphView({
    super.key,
    required this.text,
    required this.style,
    required this.onNavigateToVerseSelection,
  });

  @override
  Widget build(BuildContext context) {
    final baseStyle = DefaultTextStyle.of(context).style;
    return Container(
      padding: switch (style) {
        .quote || .indented => .only(left: 16),
        .poetry => .symmetric(horizontal: 16),
        _ => .zero,
      },
      decoration: style == .quote
          ? BoxDecoration(
              border: Border(left: BorderSide(color: context.colors.borderOpaque, width: 2)),
            )
          : null,
      child: MarkdownBuilder(
        text,
        style: switch (style) {
          .heading => context.textStyle.headingXxs,
          .attribution || .italic => baseStyle.copyWith(fontStyle: .italic),
          .bold => baseStyle.bold,
          .boldItalic || .poetry => baseStyle.bold.copyWith(fontStyle: .italic),
          _ => baseStyle,
        },
        textAlign: switch (style) {
          .heading || .centered || .poetry => .center,
          .attribution => .end,
          _ => null,
        },
        onLinkPressed: (text, link) =>
            openCommentaryLink(context, link, onNavigateToVerseSelection: onNavigateToVerseSelection),
      ),
    );
  }
}

class CommentaryTableView extends StatelessWidget {
  final List<List<Markdown>> rows;
  final Function(VerseSelection) onNavigateToVerseSelection;

  const CommentaryTableView({super.key, required this.rows, required this.onNavigateToVerseSelection});

  @override
  Widget build(BuildContext context) {
    final columnCount = rows.map((row) => row.length).maxOrNull ?? 0;
    return StyledFog(
      child: SingleChildScrollView(
        scrollDirection: .horizontal,
        child: IntrinsicWidth(
          child: Table(
            defaultColumnWidth: IntrinsicColumnWidth(),
            border: .all(color: context.colors.borderOpaque),
            children: rows
                .mapIndexed(
                  (rowIndex, row) => TableRow(
                    children: Range.generate(0, columnCount - 1).map((columnIndex) {
                      final text = row.elementAtOrNull(columnIndex) ?? Markdown('');
                      return Padding(
                        padding: .all(8),
                        child: MarkdownBuilder(
                          text,
                          style: rowIndex == 0 ? context.textStyle.labelSm.bold : context.textStyle.paragraphSm,
                          onLinkPressed: (text, link) =>
                              openCommentaryLink(context, link, onNavigateToVerseSelection: onNavigateToVerseSelection),
                        ),
                      );
                    }).toList(),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
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
