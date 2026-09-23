import 'package:collection/collection.dart';

/// One attempt at saying a line, as detected in the source recording.
class Take {
  const Take({required this.start, required this.end, this.text});

  factory Take.fromJson(Map<String, dynamic> json) =>
      Take(start: json['start'] as int, end: json['end'] as int, text: json['text'] as String?);

  final int start;
  final int end;

  /// Null until transcribed; empty when the span turned out to hold no speech.
  final String? text;

  int get frameCount => end - start;

  bool get isSilent => text != null && text!.isEmpty;

  /// The transcript survives a nudge: trimming adjusts breathing room by a few
  /// frames, which does not change the sentence.
  Take shifted({int start = 0, int end = 0}) => Take(start: this.start + start, end: this.end + end, text: text);

  Take transcribed(String text) => Take(start: start, end: end, text: text);

  Map<String, dynamic> toJson() => {'start': start, 'end': end, if (text != null) 'text': text};
}

/// A named moment in the video, plus every take of it. The last take is the keeper.
class SourceClip {
  const SourceClip({required this.name, required this.takes});

  factory SourceClip.fromJson(Map<String, dynamic> json) => SourceClip(
    name: json['name'] as String,
    takes: (json['takes'] as List).map((t) => Take.fromJson(t as Map<String, dynamic>)).toList(),
  );

  final String name;
  final List<Take> takes;

  Take get keeper => takes.last;

  SourceClip renamed(String name) => SourceClip(name: name, takes: takes);

  SourceClip withKeeper(Take keeper) => SourceClip(name: name, takes: [...takes.take(takes.length - 1), keeper]);

  SourceClip trimmed({int start = 0, int end = 0}) => withKeeper(keeper.shifted(start: start, end: end));

  Map<String, dynamic> toJson() => {'name': name, 'takes': takes.map((t) => t.toJson()).toList()};
}

class Clips {
  const Clips({required this.fps, required this.clips});

  factory Clips.fromJson(Map<String, dynamic> json) => Clips(
    fps: json['fps'] as int,
    clips: (json['clips'] as List).map((c) => SourceClip.fromJson(c as Map<String, dynamic>)).toList(),
  );

  final int fps;
  final List<SourceClip> clips;

  Iterable<Take> get takes => clips.expand((c) => c.takes);

  SourceClip? operator [](String name) => clips.firstWhereOrNull((c) => c.name == name);

  Clips replacing(String name, SourceClip clip) =>
      Clips(fps: fps, clips: clips.map((c) => c.name == name ? clip : c).toList());

  /// Drops spans that turned out to hold no speech, then renumbers. Only safe
  /// while names are still auto-generated, i.e. right after detection.
  Clips withoutSilence() => Clips(
    fps: fps,
    clips: clips
        .where((c) => !c.keeper.isSilent)
        .mapIndexed((index, c) => SourceClip(name: 'clip_${(index + 1).toString().padLeft(2, '0')}', takes: c.takes))
        .toList(),
  );

  Map<String, dynamic> toJson() => {'fps': fps, 'clips': clips.map((c) => c.toJson()).toList()};
}
