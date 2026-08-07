extension DurationExtensions on Duration {
  String format() {
    final minutes = inMinutes.remainder(60).toString().padLeft(inHours > 0 ? 2 : 1, '0');
    final seconds = inSeconds.remainder(60).toString().padLeft(2, '0');
    return inHours > 0 ? '$inHours:$minutes:$seconds' : '$minutes:$seconds';
  }

  Duration clamp(Duration min, Duration max) => this < min
      ? min
      : this > max
      ? max
      : this;

  Duration get clampZero => this < .zero ? .zero : this;

  Duration operator /(double num) => Duration(microseconds: (inMicroseconds / num).toInt());
}
