import 'package:bible/models/linked_resource.dart';
import 'package:bible/providers/videos_provider.dart';
import 'package:bible/ui/widgets/video_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';

class VideosPage extends HookConsumerWidget implements StyledRoute<VerseSelection> {
  const VideosPage({super.key});

  @override
  String get path => '/videos';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final collections = ref.watch(videoCollectionsProvider).value;

    final searchState = useState('');
    final matchingCollections = collections
        ?.map(
          (collection) =>
              (title: collection.title, videos: collection.videos.whereMatchingTitleSearch(searchState.value).toList()),
        )
        .where((collection) => collection.videos.isNotEmpty)
        .toList();

    return StyledPage(
      title: t.labels.videos.toText(),
      body: Column(
        children: [
          Container(
            padding: MediaQuery.viewPaddingOf(context).onlyHorizontal + .all(16),
            decoration: BoxDecoration(color: context.colors.surfacePrimary, boxShadow: [StyledShadow.down(context)]),
            child: StyledTextField(
              text: searchState.value,
              hintText: t.videos.searchHint,
              onChanged: (text) => searchState.value = text,
              autocorrect: false,
            ),
          ),
          Expanded(
            child: StyledScrollbar(
              child: StyledListView(
                padding: .only(bottom: MediaQuery.paddingOf(context).bottom + MediaQuery.viewInsetsOf(context).bottom),
                children: [
                  if (matchingCollections == null)
                    Padding(padding: .all(16), child: StyledLoading())
                  else if (matchingCollections.isEmpty)
                    SafeArea(
                      top: false,
                      bottom: false,
                      child: Padding(
                        padding: .all(16),
                        child: StyledTile.message(
                          title: t.videos.noMatchingVideos.toText(),
                          subtitle: t.emptyStates.tryAnotherSearch.toText(),
                          leading: Symbols.search.toIcon(),
                        ),
                      ),
                    ),
                  ...?matchingCollections?.expand(
                    (collection) => StyledSection(
                      title: collection.title.toText(),
                      children: collection.videos
                          .map(
                            (video) => VideoListItem(
                              video: video,
                              onNavigateToVerseSelection: (verseSelection) => context.pop(verseSelection),
                            ),
                          )
                          .toList(),
                    ).buildChildren(context),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
