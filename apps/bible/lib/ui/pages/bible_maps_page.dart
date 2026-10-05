import 'package:bible/models/linked_resource.dart';
import 'package:bible/providers/bible_maps_provider.dart';
import 'package:bible/ui/widgets/bible_map_list_item.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';

// Typed like the other Resources pages, which can return a passage to open, although maps never do.
class BibleMapsPage extends HookConsumerWidget implements StyledRoute<VerseSelection> {
  const BibleMapsPage({super.key});

  @override
  String get path => '/maps';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final maps = ref.watch(bibleMapsProvider).value;
    final mapsInBibleOrder = useMemoized(() => maps?.sortedBy((map) => map.passages.first.references.first), [maps]);

    final searchState = useState('');
    final matchingMaps = mapsInBibleOrder?.whereMatchingTitleSearch(searchState.value).toList();

    return StyledPage(
      title: t.labels.maps.toText(),
      body: Column(
        children: [
          Container(
            padding: MediaQuery.viewPaddingOf(context).onlyHorizontal + .all(16),
            decoration: BoxDecoration(color: context.colors.surfacePrimary, boxShadow: [StyledShadow.down(context)]),
            child: StyledTextField(
              text: searchState.value,
              hintText: t.maps.searchHint,
              onChanged: (text) => searchState.value = text,
              autocorrect: false,
            ),
          ),
          Expanded(
            child: StyledScrollbar(
              child: StyledListView(
                padding: .only(bottom: MediaQuery.paddingOf(context).bottom + MediaQuery.viewInsetsOf(context).bottom),
                children: [
                  if (matchingMaps == null)
                    Padding(padding: .all(16), child: StyledLoading())
                  else if (matchingMaps.isEmpty)
                    SafeArea(
                      top: false,
                      bottom: false,
                      child: Padding(
                        padding: .all(16),
                        child: StyledTile.message(
                          title: t.maps.noMatchingMaps.toText(),
                          subtitle: t.emptyStates.tryAnotherSearch.toText(),
                          leading: Symbols.search.toIcon(),
                        ),
                      ),
                    ),
                  ...?matchingMaps?.map((map) => BibleMapListItem(map: map)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
