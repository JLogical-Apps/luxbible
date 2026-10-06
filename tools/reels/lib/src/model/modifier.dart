import 'package:reels/src/model/framing.dart';

/// Something added to a clip.
sealed class Modifier {
  const Modifier();
}

/// A card of text over the clip. Titles sharing an `x` and `y` share one card, one after another in the order given.
class Title extends Modifier {
  const Title(this.text, {this.x, this.y = 0.25, this.start = .clipStart, this.end = .clipEnd, this.opacity = 1});

  final String text;

  /// Center of the card, as a fraction of the frame's width. Without it the card spans the frame; with it the card
  /// fits its text, like a label.
  final double? x;

  /// Center of the card, as a fraction of the frame's height.
  final double y;

  final ClipTime start;
  final ClipTime end;
  final double opacity;
}

/// A video or image from the video's `media` folder, shown above the head.
///
/// Consecutive clips showing the same video form a run, and its playhead carries across their cuts. A run with no
/// [play] plays the video once, from its `start` tag to its `end` tag, fit to the run. An image just shows, with no
/// [play].
class Media extends Modifier {
  const Media(
    this.file, {
    this.play = const [],
    this.start = .clipStart,
    this.end = .clipEnd,
    this.mask,
    this.enter,
    this.effect,
    this.scale = 1,
  });

  /// A filename within the media folder.
  final String file;
  final List<Play> play;
  final Mask? mask;

  /// Shrinks the space the media fits inside around its center, so 0.5 shows it at most half as wide and tall.
  final double scale;

  final ClipTime start;
  final ClipTime end;

  /// How the media arrives at [start]. Without it, the media cuts in.
  final Slide? enter;

  final Effect? effect;
}

/// Slides in from beyond the frame's [from] edge, easing into place over [frames].
class Slide {
  const Slide(this.from, {this.frames = 12, this.easing = .quarticInOut});

  final Edge from;
  final int frames;
  final Easing easing;
}

enum Edge { top, bottom, left, right }

/// A filter over a `Media`, animated over its whole showing.
sealed class Effect {
  const Effect();

  const factory Effect.pixelate({int blocks, int posterize}) = Pixelate;
}

/// Breaks the media into square blocks, [blocks] across its width, on a grid that jumps to a random offset every
/// [posterize] frames.
class Pixelate extends Effect {
  const Pixelate({this.blocks = 6, this.posterize = 4});

  final int blocks;
  final int posterize;
}

/// A shape cut around a `Media`.
sealed class Mask {
  const Mask();

  const factory Mask.bevel({double radius, double border}) = Bevel;

  const factory Mask.rounded({double radius}) = Rounded;
}

/// Rounds the media's corners by [radius], a fraction of its width, with no border.
class Rounded extends Mask {
  const Rounded({this.radius = 0.22});

  final double radius;
}

/// Rounds the media's corners by [radius] and frames it in a black device bezel [border] thick, both as fractions of
/// the media's width, for screenshots without a device frame of their own.
class Bevel extends Mask {
  const Bevel({this.radius = 0.14, this.border = 0.035});

  final double radius;
  final double border;
}

/// Eases the clip's crop into [framing] over [frames], starting [at] a moment in the clip. A clip's zooms are given in
/// the order they happen. [zoom] replaces the framing's magnification and the clip's random jitter on it.
class Zoom extends Modifier {
  const Zoom(this.framing, {this.zoom, required this.at, this.frames = 12, this.easing = .quarticInOut});

  final Framing framing;
  final double? zoom;
  final ClipTime at;
  final int frames;
  final Easing easing;
}

/// Starts the clip [from] times further in than its framing, holds until [at], then eases out to its framing over
/// [frames].
class ZoomOut extends Modifier {
  const ZoomOut({this.from = 1.45, this.at = .clipStart, this.frames = 30, this.easing = .quarticInOut});

  final double from;
  final ClipTime at;
  final int frames;
  final Easing easing;
}

/// Images from the video's `media` folder whose names match [pattern], where `*` matches anything. They appear one at a
/// time in their natural order, the first at [start] and the last at [by], coming slowly at first, then quickly until
/// the last. Each lands at a random spot above the head, turned a little, and they pile up until [end]. [sound]
/// plays as each one appears.
class Scatter extends Modifier {
  const Scatter(this.pattern, {this.start = .clipStart, this.by = .clipEnd, this.end = .clipEnd, this.sound});

  final String pattern;
  final ClipTime start;
  final ClipTime by;
  final ClipTime end;
  final Sound? sound;
}

/// A track from the video's `media` folder, playing under the whole video, lined up so [cue] into the track plays [at]
/// a moment in this clip. A video has at most one.
class Music extends Modifier {
  const Music(this.file, {this.cue = Duration.zero, this.at = .clipStart, this.volume = -20});

  final String file;
  final Duration cue;
  final ClipTime at;

  /// Gain in dB.
  final double volume;
}

/// A sound effect from the video's `media` folder, starting at its first sound so it lands on its moment.
class Sound {
  const Sound(this.file, {this.volume = -10});

  final String file;

  /// Gain in dB.
  final double volume;
}

/// Plays the media to the tag [to], starting [at] a moment in its clip, or when the media appears.
///
/// It gets until the next [Play] of the same file, the end of its run, or [by], whichever is first. Unless [speed] is
/// given, it plays at 1x and holds on [to] if that fits, or speeds up just enough to reach [to] at the end. [fit] slows
/// it down too, so it reaches [to] right at the end.
class Play {
  const Play(this.to, {this.from, this.at, this.by, this.speed, this.fit = false});

  final String to;

  /// A tag to jump to first, instead of continuing from wherever the playhead is.
  final String? from;

  final ClipTime? at;
  final ClipTime? by;
  final double? speed;
  final bool fit;
}

/// A moment within a clip, relative to the clip rather than the recording so trimming never needs it rewritten.
sealed class ClipTime {
  const ClipTime();

  static const clipStart = ClipFrames(0);
  static const clipEnd = ClipEnd();

  const factory ClipTime.frames(int frames) = ClipFrames;

  /// When the first occurrence of [phrase], one or more words, lights up in the clip's captions.
  const factory ClipTime.word(String phrase) = ClipWord;
}

class ClipFrames extends ClipTime {
  const ClipFrames(this.frames);

  final int frames;
}

class ClipEnd extends ClipTime {
  const ClipEnd();
}

class ClipWord extends ClipTime {
  const ClipWord(this.phrase);

  final String phrase;
}
