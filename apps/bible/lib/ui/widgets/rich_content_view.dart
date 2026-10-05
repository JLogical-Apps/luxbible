import 'package:bible/models/article.dart';
import 'package:bible/models/rich_content.dart';
import 'package:bible/providers/articles_provider.dart';
import 'package:bible/providers/root_ref.dart';
import 'package:bible/ui/sheets/article_sheet.dart';
import 'package:bible/ui/sheets/preview_passage_sheet.dart';
import 'package:bible/ui/widgets/bible_map_card.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:lux/lux.dart';
import 'package:style/style.dart';

class RichContentList extends StatelessWidget {
  final List<RichContent> content;
  final Function(VerseSelection) onNavigateToVerseSelection;

  const RichContentList({super.key, required this.content, required this.onNavigateToVerseSelection});

  @override
  Widget build(BuildContext context) => DefaultTextStyle(
    style: context.textStyle.paragraphMd,
    child: Column(
      crossAxisAlignment: .stretch,
      spacing: 12,
      children: content.mapIndexed((index, block) {
        final view = RichContentView(content: block, onNavigateToVerseSelection: onNavigateToVerseSelection);
        return switch (block) {
          RichParagraph(style: .heading) when index > 0 => Padding(padding: .only(top: 12), child: view),
          _ => view,
        };
      }).toList(),
    ),
  );
}

class RichContentView extends StatelessWidget {
  final RichContent content;
  final Function(VerseSelection) onNavigateToVerseSelection;

  const RichContentView({super.key, required this.content, required this.onNavigateToVerseSelection});

  @override
  Widget build(BuildContext context) => switch (content) {
    RichParagraph(:final text, :final style) => RichParagraphView(
      text: text,
      style: style,
      onNavigateToVerseSelection: onNavigateToVerseSelection,
    ),
    RichTable(:final rows) => RichTableView(rows: rows, onNavigateToVerseSelection: onNavigateToVerseSelection),
    RichBibleMap(:final id) => BibleMapCard(mapId: id),
    RichBox(:final title, :final content) => StyledTile(
      padding: .all(16),
      child: Column(
        crossAxisAlignment: .stretch,
        spacing: 12,
        children: [
          Text(title, style: context.textStyle.headingXxs),
          RichContentList(content: content, onNavigateToVerseSelection: onNavigateToVerseSelection),
        ],
      ),
    ),
  };
}

Future<void> openRichContentLink(
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

class RichParagraphView extends StatelessWidget {
  final Markdown text;
  final RichParagraphStyle style;
  final Function(VerseSelection) onNavigateToVerseSelection;

  const RichParagraphView({
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
          .centered || .poetry => .center,
          .attribution => .end,
          _ => null,
        },
        onLinkPressed: (text, link) =>
            openRichContentLink(context, link, onNavigateToVerseSelection: onNavigateToVerseSelection),
      ),
    );
  }
}

class RichTableView extends StatelessWidget {
  final List<List<Markdown>> rows;
  final Function(VerseSelection) onNavigateToVerseSelection;

  const RichTableView({super.key, required this.rows, required this.onNavigateToVerseSelection});

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
                          onLinkPressed: (text, link) => openRichContentLink(
                            context,
                            link,
                            onNavigateToVerseSelection: onNavigateToVerseSelection,
                          ),
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
