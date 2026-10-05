import 'dart:convert';

import 'package:bible/models/bible_map.dart';
import 'package:lux/lux_core.dart';
import 'package:lux_content_tools/repository_paths.dart';
import 'package:lux_content_tools/tyndale_dictionary.dart';

void main() {
  final maps = readTyndaleMaps().map(
    (map) => BibleMap(
      id: map['id'],
      title: map['title'],
      caption: map['caption'],
      passages: (map['passages'] as List)
          .cast<String>()
          .map(
            (passage) => VerseSelection.isOsisId(passage)
                ? VerseSelection.fromOsisId(passage)
                : throw FormatException('Invalid passage `$passage` in map `${map['id']}`.'),
          )
          .toList(),
    ),
  );
  appAssetFile(
    'maps/tyndale.json',
    app: .bible,
  ).writeAsStringSync(jsonEncode(maps.map((map) => map.toJson()).toList()));
}
