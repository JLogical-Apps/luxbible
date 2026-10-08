import 'package:bible/models/article.dart';
import 'package:bible/models/article_collection.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/ui/dialogs/tutorial_dialog.dart';
import 'package:bible/ui/sheets/contents_sheet.dart';
import 'package:bible/ui/sheets/preview_passage_sheet.dart';
import 'package:bible/ui/widgets/passage_list_item.dart';
import 'package:bible/ui/widgets/related_articles_tile.dart';
import 'package:bible/ui/widgets/rich_content_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';

class ArticleSheet {
  static Future<void> show(
    BuildContext context, {
    required ArticleCollection collection,
    required Article article,
    required Function(VerseSelection) onNavigateToVerseSelection,
  }) => context.showStyledSheetWithBreadcrumbs(breadcrumbText: article.title, (context, ref) {
    final user = ref.watch(userProvider);
    final showStudyBanner = user.translation.isOnline && !user.tutorials.has(.articlePassagesStudy);

    final headingsByIndex = article.headingsByIndex;
    final keysByIndex = useMemoized(() => headingsByIndex.map((index, _) => MapEntry(index, GlobalKey())));
    final sections = headingsByIndex.entries
        .map(
          (entry) => ContentsSection(
            title: entry.value.text.withStrippedMarkdown,
            key: keysByIndex[entry.key]!,
            isNested: entry.value.style == .subheading,
          ),
        )
        .toList();

    void navigateToVerseSelection(VerseSelection verseSelection) {
      context.pop();
      onNavigateToVerseSelection(verseSelection);
    }

    return StyledSheet(
      title: article.title.toText(),
      subtitle: collection.source().toText(),
      trailing: ContentsSheet.hasContents(sections)
          ? Tooltip(
              message: t.labels.contents,
              child: StyledCircleButton.md(
                child: Symbols.toc.toIcon(),
                onPressed: () => ContentsSheet.show(context, sections: sections, topPadding: 8),
              ),
            )
          : null,
      children: [
        RelatedArticlesTile(
          collection: collection,
          article: article,
          onNavigateToVerseSelection: navigateToVerseSelection,
        ),
        Padding(
          padding: .all(16),
          child: RichContentList(
            content: article.body,
            keysByIndex: keysByIndex,
            onNavigateToVerseSelection: navigateToVerseSelection,
          ),
        ),
        if (article.passages.isNotEmpty)
          StyledSection(
            title: t.articles.passagesForFurtherStudy.toText(),
            padding: .only(top: 24),
            children: [
              if (showStudyBanner)
                Padding(
                  padding: .only(left: 16, right: 16, bottom: 8),
                  child: StyledBanner(
                    colorBuilder: .surfaceTertiary,
                    leading: Symbols.book.toIcon(),
                    message: t.articles.usingTranslation(translation: user.studyTranslation.title()).toText(),
                    action: StyledTextAction(
                      label: t.common.learnMore.toText(),
                      onPressed: () => context.showStyledDialog(
                        (context) => TutorialDialog(
                          title: t.articles.passagesForFurtherStudy.toText(),
                          body: t.articles.onlinePassagesExplanation.toText(),
                          tutorial: .articlePassagesStudy,
                        ),
                      ),
                    ),
                  ),
                ),
              ...article.passages.map(
                (passage) => PassageListItem(
                  verseSelection: passage,
                  maxLines: 2,
                  onPressed: () => PreviewPassageSheet.show(
                    context,
                    verseSelection: passage,
                    onNavigateToVerseSelection: navigateToVerseSelection,
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  });
}
