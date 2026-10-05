import 'package:bible/models/bible_map.dart';
import 'package:bible/ui/pages/bible_map_page.dart';
import 'package:flutter/material.dart';
import 'package:lux/lux.dart';
import 'package:style/style.dart';

class BibleMapListItem extends StatelessWidget {
  final BibleMap map;

  const BibleMapListItem({super.key, required this.map});

  @override
  Widget build(BuildContext context) => StyledListItem.navigation(
    size: .lg,
    leadingWidth: 88,
    leading: ClipRRect(
      borderRadius: .circular(8),
      // Decoding the full map for every thumbnail would hold dozens of multi-megabyte bitmaps in memory.
      child: Image.asset(map.imagePath, width: 72, height: 56, fit: .cover, cacheWidth: 256),
    ),
    title: map.title.toText(),
    onPressed: () => context.push(BibleMapPage(map: map)),
  );
}
