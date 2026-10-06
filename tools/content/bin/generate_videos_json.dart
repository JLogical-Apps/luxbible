import 'dart:convert';

import 'package:bible/models/video.dart';
import 'package:lux/lux_core.dart';
import 'package:lux_content_tools/repository_paths.dart';

void main() {
  final collections = (jsonDecode(sourceFile('videos/bibleproject.json').readAsStringSync()) as List).map(
    (collection) => VideoCollection(
      title: collection['title'],
      videos: (collection['videos'] as List)
          .map(
            (video) => Video(
              id: video['id'],
              title: video['title'],
              durationSeconds: video['durationSeconds'],
              muxPlaybackId: video['muxPlaybackId'],
              thumbnailUrl: video['thumbnailUrl'],
              passages: (video['passages'] as List)
                  .cast<String>()
                  .map(
                    (passage) => VerseSelection.isOsisId(passage)
                        ? VerseSelection.fromOsisId(passage)
                        : throw FormatException('Invalid passage `$passage` in video `${video['id']}`.'),
                  )
                  .toList(),
            ),
          )
          .toList(),
    ),
  );
  appAssetFile('videos/bibleproject.json', app: .bible)
    ..createSync(recursive: true)
    ..writeAsStringSync(jsonEncode(collections.map((collection) => collection.toJson()).toList()));
}
