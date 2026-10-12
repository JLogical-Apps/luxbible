import 'package:collection/collection.dart';
import 'package:reels/src/model/clips.dart';
import 'package:reels/src/model/framing.dart';
import 'package:reels/src/model/modifier.dart';

/// A reference to a source clip, placed in the finished video.
///
/// Timing lives entirely in `<video>.clips.json`; this only says which clip
/// plays and what modifiers apply to it.
class Clip {
  // Dart can't mix optional positional and named parameters, so modifiers are named to leave room for `framing`.
  const Clip(this.name, {this.modifiers = const [], Framing? framing, this.speed = 1}) : declaredFraming = framing;

  final String name;
  final List<Modifier> modifiers;

  /// How much faster than recorded the clip plays, voice included.
  final double speed;

  final Framing? declaredFraming;

  Framing get framing =>
      declaredFraming ??
      (modifiers.any((m) => m is Media || m is Scatter)
          ? .media
          : modifiers.any((m) => m is Title)
          ? .title
          : .none);

  String toDart() {
    final arguments = [
      "'$name'",
      if (declaredFraming case final framing?) 'framing: ${framing.toDart()}',
      if (speed != 1) 'speed: $speed',
    ];
    return 'Clip(${arguments.join(', ')})';
  }
}

class ResolvedClip {
  const ResolvedClip({
    required this.name,
    required this.take,
    required this.framing,
    required this.crop,
    required this.headY,
    required this.modifiers,
    this.speed = 1,
  });

  final String name;
  final Take take;
  final double speed;
  final Framing framing;
  final Crop crop;
  final double headY;
  final List<Modifier> modifiers;

  /// The clip's length on the output timeline, after its [speed].
  int get frameCount => (take.frameCount / speed).round();

  Iterable<Title> get titles => modifiers.whereType<Title>();

  Iterable<Media> get media => modifiers.whereType<Media>();

  Iterable<Scatter> get scatters => modifiers.whereType<Scatter>();

  Iterable<Zoom> get zooms => modifiers.whereType<Zoom>();

  Iterable<Music> get music => modifiers.whereType<Music>();

  ZoomOut? get zoomOut => modifiers.whereType<ZoomOut>().firstOrNull;

  Crop get startCrop => switch (zoomOut) {
    final zoomOut? => Crop.framing(framing, zoom: crop.zoom * zoomOut.from, headY: headY),
    null => crop,
  };

  Framing get endFraming => zooms.lastOrNull?.framing ?? framing;

  Crop get endCrop => switch (zooms.lastOrNull) {
    final zoom? => getZoomCrop(zoom),
    null => crop,
  };

  Crop getZoomCrop(Zoom zoom) => Crop.framing(
    zoom.framing,
    zoom: zoom.zoom ?? getZoom(zoom.framing, name, headY: headY),
    headY: headY,
  );
}
