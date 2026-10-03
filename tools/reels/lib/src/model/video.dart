import 'package:collection/collection.dart';
import 'package:path/path.dart' as p;
import 'package:reels/src/model/clip.dart';
import 'package:reels/src/model/clips.dart';
import 'package:reels/src/model/framing.dart';

class Video {
  const Video({required this.sources, String? name, this.media, this.headY = 0.5, this.clips = const []})
    : declaredName = name;

  /// Recordings that play back to back as one, in this order.
  final List<String> sources;

  /// A folder of screen recordings and images for `Media` modifiers to show.
  final String? media;
  final String? declaredName;

  /// Where the middle of the face usually sits in the recordings, as a fraction of their height. `.media` framing
  /// brings it down to the same place below the media whatever it is.
  final double headY;

  final List<Clip> clips;

  /// Defaults to the first source's filename; override it when the camera's name is meaningless.
  String get name => declaredName ?? p.basenameWithoutExtension(sources.first);

  List<ResolvedClip> resolve(Clips source) => clips.fold([], (resolved, clip) {
    final found = source[clip.name];
    if (found == null) throw UnknownClipException(clip.name, source.clips.map((c) => c.name).toList());

    final previous = resolved.lastOrNull;
    final zoom = getZoom(
      clip.framing,
      clip.name,
      headY: headY,
      previousZoom: previous != null && previous.endFraming.hasSamePlacement(clip.framing)
          ? previous.endCrop.zoom
          : null,
    );
    return resolved..add(
      ResolvedClip(
        name: found.name,
        take: found.keeper,
        framing: clip.framing,
        crop: Crop.framing(clip.framing, zoom: zoom, headY: headY),
        headY: headY,
        modifiers: clip.modifiers,
      ),
    );
  });
}

class UnknownClipException implements Exception {
  const UnknownClipException(this.name, this.available);

  final String name;
  final List<String> available;

  @override
  String toString() => 'Unknown clip "$name". Available: ${available.join(', ')}';
}
