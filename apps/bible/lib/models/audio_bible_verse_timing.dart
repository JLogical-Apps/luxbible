class AudioBibleVerseTiming {
  final Duration start;
  final Duration end;

  AudioBibleVerseTiming({required this.start, required this.end});

  factory AudioBibleVerseTiming.fromJson(Map<String, dynamic> json) => AudioBibleVerseTiming(
    start: Duration(microseconds: ((json['s'] as num) * Duration.microsecondsPerSecond).round()),
    end: Duration(microseconds: ((json['e'] as num) * Duration.microsecondsPerSecond).round()),
  );
}
