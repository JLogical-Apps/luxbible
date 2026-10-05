import 'package:bible/models/article_collection.dart';
import 'package:bible/models/linked_resource.dart';
import 'package:bible/providers/articles_provider.dart';
import 'package:bible/providers/bible_maps_provider.dart';
import 'package:bible/ui/widgets/article_list_item.dart';
import 'package:bible/ui/widgets/bible_map_list_item.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:style/style.dart';
import 'package:utils_core/utils_core.dart';

class LinkedResourcesSheet {
  static List<Widget> buildSheetChildren(
    BuildContext context,
    WidgetRef ref, {
    required VerseSelection verseSelection,
    required Function(VerseSelection) onNavigateToVerseSelection,
    bool popOnAction = true,
  }) {
    final articlesByCollection = ArticleCollection.values
        .where((collection) => collection.hasPassages)
        .mapToMap((collection) => MapEntry(collection, ref.watch(articlesProvider(collection: collection)).value));
    final maps = ref.watch(bibleMapsProvider).value;
    if (articlesByCollection.values.contains(null) || maps == null) {
      return [Padding(padding: .all(16), child: StyledLoading())];
    }

    final linkedArticlesByCollection = articlesByCollection
        .mapValues((collection, articles) => articles!.whereLinkedTo(verseSelection).toList())
        .where((collection, articles) => articles.isNotEmpty);
    final linkedMaps = maps.whereLinkedTo(verseSelection).toList();

    final sections = [
      ...linkedArticlesByCollection.mapToIterable(
        (collection, articles) => StyledSection(
          title: collection.title().toText(),
          padding: .only(top: 16, bottom: 8),
          children: articles
              .map(
                (article) => ArticleListItem(
                  collection: collection,
                  article: article,
                  onNavigateToVerseSelection: (selection) {
                    if (popOnAction) context.pop();
                    onNavigateToVerseSelection(selection);
                  },
                ),
              )
              .toList(),
        ),
      ),
      if (linkedMaps.isNotEmpty)
        StyledSection(
          title: t.labels.maps.toText(),
          padding: .only(top: 16, bottom: 8),
          children: linkedMaps.map((map) => BibleMapListItem(map: map)).toList(),
        ),
    ];
    return sections.isEmpty
        ? [
            Padding(
              padding: .all(16),
              child: StyledBanner(message: t.studyActions.noLinkedResources.toText()),
            ),
          ]
        : sections;
  }
}
