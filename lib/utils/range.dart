class Range {
  static Iterable<T> generate<T extends num>(T min, T max, {T? step, bool inclusiveMax = true}) sync* {
    for (T i = min; inclusiveMax ? i <= max : i < max; i = (i + (step ?? 1)) as T) {
      yield i;
    }
  }
}
