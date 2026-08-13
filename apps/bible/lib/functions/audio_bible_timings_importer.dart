import 'dart:convert';

import 'package:bible/models/audio_bible_verse_timing.dart';
import 'package:flutter/services.dart';
import 'package:lux/lux.dart';

class AudioBibleTimingsImporter {
  Future<Map<BibleTranslation, Map<Reference, AudioBibleVerseTiming>>> import() async =>
      await <BibleTranslation>[.bsb, .kjv].map((translation) async {
        final raw =
            jsonDecode(await rootBundle.loadString('assets/audio_bible_timings/${translation.name}.json'))
                as Map<String, dynamic>;

        return MapEntry(
          translation,
          raw.map((key, value) => MapEntry(Reference.fromOsisId(key), AudioBibleVerseTiming.fromJson(value))),
        );
      }).waitToMap;
}
