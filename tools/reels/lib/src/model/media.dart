import 'dart:io';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:path/path.dart' as p;

// Screen recordings tend to open and close on a few janky frames.
const mediaEdgeTrim = 10;

/// A file in the media folder, normalized to the video's frame rate so tags can be frame numbers.
class MediaFile {
  const MediaFile({required this.name, required this.normalized, required this.preview, required this.frameCount});

  final String name;
  final File normalized;

  /// The same frames as [normalized] in a format the app's player can decode, which excludes ProRes.
  final File preview;

  final int frameCount;
}

class MediaLibrary {
  const MediaLibrary({required this.files, this.tags = const {}});

  static const empty = MediaLibrary(files: []);

  final List<MediaFile> files;

  /// Tool-owned, keyed by filename. `start` and `end` are implicit, and only stored once moved.
  final Map<String, Map<String, int>> tags;

  MediaFile operator [](String name) =>
      files.firstWhereOrNull((f) => f.name == name) ?? (throw UnknownMediaException(name, files.map((f) => f.name)));

  Map<String, int> getTags(String name) {
    final file = this[name];
    return {
      'start': mediaEdgeTrim,
      'end': file.frameCount - 1 - mediaEdgeTrim,
      ...?tags[name],
    }.map((tag, frame) => MapEntry(tag, frame.clamp(0, max(0, file.frameCount - 1))));
  }

  List<MapEntry<String, int>> getSortedTags(String name) => getTags(name).entries.sortedBy<num>((tag) => tag.value);

  int getFrame(String name, String tag) =>
      getTags(name)[tag] ?? (throw UnknownTagException(name, tag, getSortedTags(name).map((t) => t.key)));

  MediaLibrary withTags(String name, Map<String, int> fileTags) =>
      MediaLibrary(files: files, tags: {...tags, name: fileTags}..removeWhere((_, t) => t.isEmpty));
}

/// A stretch of the output timeline showing one media file, playing from [from] towards [to] at [speed], then holding
/// wherever it got to. A hold is `from == to`.
class MediaSegment {
  const MediaSegment({
    required this.media,
    required this.outputStart,
    required this.outputEnd,
    required this.from,
    required this.to,
    this.speed = 1,
  });

  final MediaFile media;
  final int outputStart;
  final int outputEnd;
  final int from;
  final int to;
  final double speed;

  int get frameCount => outputEnd - outputStart;

  int getFrameAt(int output) => min(to, from + ((output - outputStart) * speed).floor());

  MediaSegment? clipped(int start, int end) {
    final clippedStart = max(start, outputStart);
    final clippedEnd = min(end, outputEnd);
    if (clippedStart >= clippedEnd) return null;
    return MediaSegment(
      media: media,
      outputStart: clippedStart,
      outputEnd: clippedEnd,
      from: getFrameAt(clippedStart),
      to: to,
      speed: speed,
    );
  }

  @override
  String toString() =>
      '${p.basename(media.normalized.path)}:$outputStart-$outputEnd:$from-$to@${speed.toStringAsFixed(3)}';
}

class UnknownMediaException implements Exception {
  const UnknownMediaException(this.name, this.available);

  final String name;
  final Iterable<String> available;

  @override
  String toString() => available.isEmpty
      ? 'Unknown media "$name". Link a folder with Video(media: ...), or add the file to it.'
      : 'Unknown media "$name". Available: ${available.join(', ')}';
}

class UnknownTagException implements Exception {
  const UnknownTagException(this.file, this.tag, this.available);

  final String file;
  final String tag;
  final Iterable<String> available;

  @override
  String toString() => 'Unknown tag "$tag" in $file. Available: ${available.join(', ')}';
}

class BackwardsPlayException implements Exception {
  const BackwardsPlayException(this.file, {required this.from, required this.to, required this.tag});

  final String file;
  final int from;
  final int to;
  final String tag;

  @override
  String toString() =>
      'Play("$tag") in $file would play backwards, from frame $from to $to. Give it a `from:` tag to jump first.';
}
