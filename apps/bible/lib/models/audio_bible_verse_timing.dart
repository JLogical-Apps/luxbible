import 'package:collection/collection.dart';
import 'package:lux/lux.dart';

class AudioBibleVerseTiming {
  final Duration start;
  final Duration end;

  AudioBibleVerseTiming({required this.start, required this.end});

  factory AudioBibleVerseTiming.fromJson(Map<String, dynamic> json) => AudioBibleVerseTiming(
    start: Duration(microseconds: ((json['s'] as num) * Duration.microsecondsPerSecond).round()),
    end: Duration(microseconds: ((json['e'] as num) * Duration.microsecondsPerSecond).round()),
  );
}

extension AudioBibleVerseTimingsExtensions on Map<Reference, AudioBibleVerseTiming> {
  Reference? getReferenceAtPosition({required VerseSelection passage, required Duration position}) {
    final timedReferences = passage.references.where(containsKey).toList();
    return timedReferences.lastWhereOrNull(
          (reference) => position >= this[reference]!.start - Duration(milliseconds: 300),
        ) ??
        timedReferences.firstOrNull;
  }
}

extension AudioBiblePassageTimingExtensions on VerseSelection {
  AudioBibleVerseTiming? getFirstAudioTiming(Map<Reference, AudioBibleVerseTiming> timings) =>
      references.map((reference) => timings[reference]).nonNulls.firstOrNull;

  AudioBibleVerseTiming? getLastAudioTiming(Map<Reference, AudioBibleVerseTiming> timings) =>
      references.map((reference) => timings[reference]).nonNulls.lastOrNull;

  Duration getAudioStartPosition(Map<Reference, AudioBibleVerseTiming> timings) =>
      references.any((reference) => reference.verseNum == 1)
      ? .zero
      : getFirstAudioTiming(timings)?.start ?? Duration.zero;

  bool hasReachedAudioEnd(Duration position, Map<Reference, AudioBibleVerseTiming> timings) =>
      !isChapter &&
      switch (getLastAudioTiming(timings)?.end) {
        final end? => position >= end,
        null => false,
      };
}
