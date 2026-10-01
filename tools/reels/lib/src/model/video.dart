import 'package:collection/collection.dart';
import 'package:path/path.dart' as p;
import 'package:reels/src/model/clip.dart';
import 'package:reels/src/model/clips.dart';
import 'package:reels/src/model/framing.dart';

class Video {
  const Video({required this.sources, String? name, this.media, this.clips = const []}) : declaredName = name;

  /// Recordings that play back to back as one, in this order.
  final List<String> sources;

  /// A folder of screen recordings for `Media` modifiers to show.
  final String? media;
  final String? declaredName;

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
      previousZoom: previous != null && previous.endFraming.headY == clip.framing.headY ? previous.endCrop.zoom : null,
    );
    return resolved..add(
      ResolvedClip(
        name: found.name,
        take: found.keeper,
        framing: clip.framing,
        crop: Crop.framing(clip.framing, zoom: zoom),
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
