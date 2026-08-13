import 'dart:convert';

import 'package:lux/lux_core.dart';
import 'package:lux_content_tools/audio_bible_timing_source.dart';
import 'package:lux_content_tools/repository_paths.dart';
import 'package:utils_core/utils_core.dart';

void main() {
  for (final translation in BibleTranslation.values.where((translation) => translation.hasAudioBible)) {
    appAssetFile('audio_bible_timings/$translation.json', app: .bible)
      ..createSync(recursive: true)
      ..writeAsStringSync(
        jsonEncode(
          BookType.values
              .expand(
                (book) => Range.generate(1, book.bookInfo.numChapters).expand((chapterNum) {
                  final raw =
                      jsonDecode(
                            sourceFile(
                              'audio_bible_timings/$translation/${book.audioBibleTimingSourceName}_$chapterNum.json',
                            ).readAsStringSync(),
                          )
                          as Map<String, dynamic>;
                  return (raw['verses'] as List).cast<Map<String, dynamic>>().map((verse) {
                    final verseNum = verse['v'] as int;
                    final start = (verse['start'] as num).toDouble();
                    final end = (verse['end'] as num).toDouble();

                    return MapEntry('${book.osisId().toUpperCase()}.$chapterNum.$verseNum', {
                      's': start.asIntOrDouble(),
                      'e': end.asIntOrDouble(),
                    });
                  });
                }),
              )
              .toMap(),
        ),
      );
  }
}
