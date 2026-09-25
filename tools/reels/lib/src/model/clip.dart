import 'package:reels/src/model/clips.dart';
import 'package:reels/src/model/framing.dart';
import 'package:reels/src/model/modifier.dart';

/// A reference to a source clip, placed in the finished video.
///
/// Timing lives entirely in `<video>.clips.json`; this only says which clip
/// plays and what modifiers apply to it.
class Clip {
  // Dart can't mix optional positional and named parameters, so modifiers are named to leave room for `framing`.
  const Clip(this.name, {this.modifiers = const [], Framing? framing}) : declaredFraming = framing;

  final String name;
  final List<Modifier> modifiers;

  final Framing? declaredFraming;

  Framing get framing =>
      declaredFraming ??
      (modifiers.any((m) => m is Media)
          ? .media
          : modifiers.any((m) => m is Title)
          ? .title
          : .none);

  String toDart() => switch (declaredFraming) {
    null => "Clip('$name')",
    final framing => "Clip('$name', framing: .${framing.name})",
  };
}

class ResolvedClip {
  const ResolvedClip({
    required this.name,
    required this.take,
    required this.framing,
    required this.crop,
    required this.modifiers,
  });

  final String name;
  final Take take;
  final Framing framing;
  final Crop crop;
  final List<Modifier> modifiers;

  Iterable<Title> get titles => modifiers.whereType<Title>();

  Iterable<Media> get media => modifiers.whereType<Media>();
}
