import 'dart:io';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:path/path.dart' as p;
import 'package:reels/src/model/modifier.dart';

// Screen recordings tend to open and close on a few janky frames.
const mediaEdgeTrim = 10;

const imageExtensions = {'.jpg', '.jpeg', '.png'};

bool isImage(String name) => imageExtensions.contains(p.extension(name).toLowerCase());

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
  const MediaLibrary({required this.files, this.images = const [], this.tags = const {}});

  static const empty = MediaLibrary(files: []);

  final List<MediaFile> files;

  /// Stills in the media folder, which are shown as they are, with no ingest or tags.
  final List<File> images;

  /// Tool-owned, keyed by filename. `start` and `end` are implicit, and only stored once moved.
  final Map<String, Map<String, int>> tags;

  Iterable<String> get names => [...files.map((f) => f.name), ...images.map((image) => p.basename(image.path))];

  MediaFile operator [](String name) =>
      files.firstWhereOrNull((f) => f.name == name) ?? (throw UnknownMediaException(name, names));

  File getImage(String name) =>
      images.firstWhereOrNull((image) => p.basename(image.path) == name) ?? (throw UnknownMediaException(name, names));

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
      MediaLibrary(files: files, images: images, tags: {...tags, name: fileTags}..removeWhere((_, t) => t.isEmpty));
}

/// A stretch of the output timeline showing the media [name] from [file], playing from [from] towards [to] at [speed],
/// then holding wherever it got to, styled by its [showing]. A hold is `from == to`, and an image is a hold on frame 0.
class MediaSegment {
  const MediaSegment({
    required this.name,
    required this.file,
    required this.outputStart,
    required this.outputEnd,
    required this.from,
    required this.to,
    this.speed = 1,
    this.showing,
  });

  final String name;
  final File file;
  final int outputStart;
  final int outputEnd;
  final int from;
  final int to;
  final double speed;
  final MediaShowing? showing;

  int get frameCount => outputEnd - outputStart;

  int getFrameAt(int output) => min(to, from + ((output - outputStart) * speed).floor());

  MediaSegment? clipped(MediaShowing showing) {
    final clippedStart = max(showing.start, outputStart);
    final clippedEnd = min(showing.end, outputEnd);
    if (clippedStart >= clippedEnd) return null;
    return MediaSegment(
      name: name,
      file: file,
      outputStart: clippedStart,
      outputEnd: clippedEnd,
      from: getFrameAt(clippedStart),
      to: to,
      speed: speed,
      showing: showing,
    );
  }

  @override
  String toString() => '${p.basename(file.path)}:$outputStart-$outputEnd:$from-$to@${speed.toStringAsFixed(3)}';
}

/// A [media] modifier on the [clip] at that index, showing from [start] to [end] on the output timeline.
class MediaShowing {
  const MediaShowing(this.media, {required this.clip, required this.start, required this.end});

  final Media media;
  final int clip;
  final int start;
  final int end;
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

class ImagePlayException implements Exception {
  const ImagePlayException(this.file);

  final String file;

  @override
  String toString() => 'Media("$file") is an image, which has nothing to play. Remove its `play:`.';
}
