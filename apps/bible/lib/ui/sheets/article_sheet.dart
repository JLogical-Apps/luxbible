import 'package:bible/models/article.dart';
import 'package:bible/models/article_collection.dart';
import 'package:bible/ui/sheets/preview_passage_sheet.dart';
import 'package:bible/ui/widgets/rich_content_view.dart';
import 'package:bible/ui/widgets/passage_list_item.dart';
import 'package:flutter/material.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:style/style.dart';

class ArticleSheet {
  static Future<void> show(
    BuildContext context, {
    required ArticleCollection collection,
    required Article article,
    required Function(VerseSelection) onNavigateToVerseSelection,
  }) => context.showStyledSheetWithBreadcrumbs(breadcrumbText: article.title, (context, _) {
    void navigateToVerseSelection(VerseSelection verseSelection) {
      context.pop();
      onNavigateToVerseSelection(verseSelection);
    }

    return StyledSheet(
      title: article.title.toText(),
      subtitle: collection.source().toText(),
      children: [
        Padding(
          padding: .all(16),
          child: RichContentList(content: article.body, onNavigateToVerseSelection: navigateToVerseSelection),
        ),
        if (article.passages.isNotEmpty)
          StyledSection(
            title: t.articles.passagesForFurtherStudy.toText(),
            padding: .only(top: 24),
            children: article.passages
                .map(
                  (passage) => PassageListItem(
                    verseSelection: passage,
                    maxLines: 2,
                    onPressed: () => PreviewPassageSheet.show(
                      context,
                      verseSelection: passage,
                      onNavigateToVerseSelection: navigateToVerseSelection,
                    ),
                  ),
                )
                .toList(),
          ),
      ],
    );
  });
}
