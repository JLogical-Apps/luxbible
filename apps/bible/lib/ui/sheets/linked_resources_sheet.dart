import 'package:bible/models/article_collection.dart';
import 'package:bible/models/linked_resource.dart';
import 'package:bible/providers/articles_provider.dart';
import 'package:bible/providers/bible_maps_provider.dart';
import 'package:bible/providers/creeds_provider.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/providers/videos_provider.dart';
import 'package:bible/ui/widgets/article_list_item.dart';
import 'package:bible/ui/widgets/bible_map_list_item.dart';
import 'package:bible/ui/widgets/creed_item_list_item.dart';
import 'package:bible/ui/widgets/video_list_item.dart';
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
    final articlesByCollection = ArticleCollection.values.mapToMap(
      (collection) => MapEntry(collection, ref.watch(articlesProvider(collection: collection)).value),
    );
    final maps = ref.watch(bibleMapsProvider).value;
    final creeds = ref.watch(creedsProvider).value;
    final videoCollections = ref.watch(videoCollectionsProvider).value;
    if (articlesByCollection.values.contains(null) || maps == null || creeds == null || videoCollections == null) {
      return [Padding(padding: .all(16), child: StyledLoading())];
    }

    final linkedMaps = maps.whereLinkedTo(verseSelection, getPassages: (map) => map.passages).toList();
    final linkedVideos = videoCollections
        .expand((collection) => collection.videos)
        .whereLinkedTo(verseSelection, getPassages: (video) => video.passages)
        .toList();
    final linkedCreedItems = creeds
        .expand((creed) => creed.itemReferences)
        // Ranking by overlap would scatter each document's questions, so they keep the order they're read in.
        .whereLinkedToInOrder(verseSelection, getPassages: (reference) => reference.item.passages)
        .toList();
    final linkedArticlesByCollection = articlesByCollection.map(
      (collection, articles) => MapEntry(
        collection,
        articles!.whereLinkedTo(verseSelection, getPassages: collection.getLinkedPassages).toList(),
      ),
    );

    void navigateToVerseSelection(VerseSelection selection) {
      // An article or creed item opened from here replaces this sheet in the breadcrumbs.
      if (popOnAction && context.mounted) context.pop();
      onNavigateToVerseSelection(selection);
    }

    final sections = ref
        .watch(userProvider)
        .resourceOrderOrDefault
        .map(
          (type) => (
            type: type,
            items: switch (type) {
              .people || .themes || .dictionary =>
                linkedArticlesByCollection[type.articleCollection!]!
                    .map(
                      (article) => ArticleListItem(
                        collection: type.articleCollection!,
                        article: article,
                        onNavigateToVerseSelection: navigateToVerseSelection,
                      ),
                    )
                    .toList(),
              .maps => linkedMaps.map((map) => BibleMapListItem(map: map)).toList(),
              .videos =>
                linkedVideos
                    .map((video) => VideoListItem(video: video, onNavigateToVerseSelection: navigateToVerseSelection))
                    .toList(),
              .creeds =>
                linkedCreedItems
                    .map(
                      (reference) =>
                          CreedItemListItem(reference: reference, onNavigateToVerseSelection: navigateToVerseSelection),
                    )
                    .toList(),
            },
          ),
        )
        .where((section) => section.items.isNotEmpty)
        .map((section) => StyledStickyHeader(title: section.type.title().toText(), children: section.items))
        .toList();
    return sections.isEmpty
        ? [
            Padding(
              padding: .all(16),
              child: StyledBanner(message: t.studyActions.noLinkedResources.toText()),
            ),
          ]
        : StyledDivider(height: 2).wrapPositioned(sections);
  }
}
