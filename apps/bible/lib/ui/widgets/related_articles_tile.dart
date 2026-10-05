import 'package:bible/models/article.dart';
import 'package:bible/models/article_collection.dart';
import 'package:bible/providers/articles_provider.dart';
import 'package:bible/ui/sheets/article_sheet.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/lux.dart';
import 'package:style/style.dart';

class RelatedArticlesTile extends ConsumerWidget {
  final ArticleCollection collection;
  final Article article;
  final Function(VerseSelection) onNavigateToVerseSelection;

  const RelatedArticlesTile({
    super.key,
    required this.collection,
    required this.article,
    required this.onNavigateToVerseSelection,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final relatedArticles = ref.watch(relatedArticlesProvider(collection: collection, article: article)).value ?? {};
    final items = relatedArticles.entries
        .expand(
          (entry) => entry.value.map(
            (relatedArticle) => StyledListItem.navigation(
              leading: entry.key.icon.toIcon(),
              title: relatedArticle.title.toText(),
              subtitle: entry.key.relatedDescription().toText(),
              onPressed: () => ArticleSheet.show(
                context,
                collection: entry.key,
                article: relatedArticle,
                onNavigateToVerseSelection: onNavigateToVerseSelection,
              ),
            ),
          ),
        )
        .toList();
    if (items.isEmpty) return SizedBox.shrink();

    return Padding(
      padding: .only(left: 16, right: 16, top: 16),
      child: StyledTile(child: StyledList(children: items)),
    );
  }
}
