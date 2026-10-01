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

/// A video from the video's `media` folder, shown above the head.
///
/// Consecutive clips showing the same file form a run, and its playhead carries across their cuts. A run with no
/// [play] plays the file once, from its `start` tag to its `end` tag, fit to the run.
class Media extends Modifier {
  const Media(this.file, {this.play = const [], this.start = .clipStart, this.end = .clipEnd});

  /// A filename within the media folder.
  final String file;
  final List<Play> play;

  final ClipTime start;
  final ClipTime end;
}

/// Eases the clip's crop into [framing] over [frames], starting [at] a moment in the clip. A clip's zooms are given in
/// the order they happen.
class Zoom extends Modifier {
  const Zoom(this.framing, {required this.at, this.frames = 12, this.easing = .quarticInOut});

  final Framing framing;
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
/// given, it plays at 1x and holds on [to] if that fits, or speeds up just enough to reach [to] at the end.
class Play {
  const Play(this.to, {this.from, this.at, this.by, this.speed});

  final String to;

  /// A tag to jump to first, instead of continuing from wherever the playhead is.
  final String? from;

  final ClipTime? at;
  final ClipTime? by;
  final double? speed;
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
