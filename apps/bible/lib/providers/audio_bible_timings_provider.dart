import 'package:bible/models/audio_bible_verse_timing.dart';
import 'package:lux/lux.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'audio_bible_timings_provider.g.dart';

@Riverpod(keepAlive: true)
Map<BibleTranslation, Map<Reference, AudioBibleVerseTiming>> audioBibleTimings(Ref ref) => throw UnimplementedError();
