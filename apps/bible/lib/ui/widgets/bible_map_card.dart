import 'package:bible/providers/bible_maps_provider.dart';
import 'package:bible/ui/pages/bible_map_page.dart';
import 'package:bible/ui/widgets/bible_map_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';

class BibleMapCard extends ConsumerWidget {
  final String mapId;

  const BibleMapCard({super.key, required this.mapId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final map = ref.watch(bibleMapsProvider).value?.firstWhereOrNull((map) => map.id == mapId);
    if (map == null) return SizedBox.shrink();

    return StyledTile(
      onPressed: () => context.push(BibleMapPage(map: map)),
      child: Column(
        crossAxisAlignment: .stretch,
        children: [
          BibleMapImage(map: map, cacheWidth: 1200),
          Padding(
            padding: .all(12),
            child: Row(
              spacing: 8,
              children: [
                Expanded(child: Text(map.title, style: context.textStyle.labelMd)),
                Symbols.zoom_in.toIcon(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
