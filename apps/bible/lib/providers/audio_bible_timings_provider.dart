import 'package:bible/models/audio_bible_verse_timing.dart';
import 'package:bible/providers/audio_bible_provider.dart';
import 'package:collection/collection.dart';
import 'package:lux/lux.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'audio_bible_timings_provider.g.dart';

@Riverpod(keepAlive: true)
Map<BibleTranslation, Map<Reference, AudioBibleVerseTiming>> audioBibleTimings(Ref ref) => throw UnimplementedError();

@riverpod
Reference? currentAudioBibleReference(Ref ref) {
  final target = ref.watch(audioBibleTargetProvider);
  final position = ref.watch(audioBiblePositionProvider).value;
  if (target == null || position == null) {
    return null;
  }

  final timings = ref.watch(audioBibleTimingsProvider)[target.translation];
  return target.passage.references.firstWhereOrNull((reference) {
    final timing = timings?[reference];
    return timing != null && position >= timing.start && position < timing.end;
  });
}
