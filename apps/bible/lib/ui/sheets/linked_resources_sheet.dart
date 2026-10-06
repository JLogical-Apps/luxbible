import 'package:bible/models/article_collection.dart';
import 'package:bible/models/linked_resource.dart';
import 'package:bible/providers/articles_provider.dart';
import 'package:bible/providers/bible_maps_provider.dart';
import 'package:bible/providers/creeds_provider.dart';
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
      if (popOnAction) context.pop();
      onNavigateToVerseSelection(selection);
    }

    final sections = [
      ...<ArticleCollection>[.people, .themes, .dictionary]
          .where((collection) => linkedArticlesByCollection[collection]!.isNotEmpty)
          .map(
            (collection) => StyledSection(
              title: collection.title().toText(),
              children: linkedArticlesByCollection[collection]!
                  .map(
                    (article) => ArticleListItem(
                      collection: collection,
                      article: article,
                      onNavigateToVerseSelection: navigateToVerseSelection,
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
      if (linkedVideos.isNotEmpty)
        StyledSection(
          title: t.labels.videos.toText(),
          padding: .only(top: 16, bottom: 8),
          children: linkedVideos
              .map((video) => VideoListItem(video: video, onNavigateToVerseSelection: navigateToVerseSelection))
              .toList(),
        ),
      if (linkedCreedItems.isNotEmpty)
        StyledSection(
          title: t.labels.creeds.toText(),
          padding: .only(top: 16, bottom: 8),
          children: linkedCreedItems
              .map(
                (reference) =>
                    CreedItemListItem(reference: reference, onNavigateToVerseSelection: navigateToVerseSelection),
              )
              .toList(),
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
