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
