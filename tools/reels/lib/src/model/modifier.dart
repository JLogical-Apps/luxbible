/// Something added to a clip.
sealed class Modifier {
  const Modifier();
}

/// A card of text over the clip. Titles sharing a `y` share one card, one after another in the order given.
class Title extends Modifier {
  const Title(this.text, {this.y = 0.25, this.start = .clipStart, this.end = .clipEnd, this.opacity = 1});

  final String text;

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
