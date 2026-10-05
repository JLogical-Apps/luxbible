import 'package:bible/models/article.dart';
import 'package:bible/models/article_collection.dart';
import 'package:bible/ui/sheets/article_sheet.dart';
import 'package:flutter/material.dart';
import 'package:lux/lux.dart';
import 'package:style/style.dart';
import 'package:utils_core/utils_core.dart';

class ArticleListItem extends StatelessWidget {
  final ArticleCollection collection;
  final Article article;
  final Function(VerseSelection) onNavigateToVerseSelection;

  const ArticleListItem({
    super.key,
    required this.collection,
    required this.article,
    required this.onNavigateToVerseSelection,
  });

  @override
  Widget build(BuildContext context) => StyledListItem.navigation(
    title: article.title.toText(),
    subtitle: article.preview?.mapIfNonNull((preview) => MarkdownBuilder(preview.withCollapsedWhitespace, maxLines: 2)),
    onPressed: () => ArticleSheet.show(
      context,
      collection: collection,
      article: article,
      onNavigateToVerseSelection: onNavigateToVerseSelection,
    ),
  );
}
