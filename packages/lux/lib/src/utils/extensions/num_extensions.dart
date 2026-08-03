extension IntExtensions on int {
  int? get nullIfZero => this == 0 ? null : this;

  int get clampZero => this < 0 ? 0 : this;
}
