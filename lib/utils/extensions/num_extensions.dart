extension IntExtensions on int {
  int? get nullIfZero => this == 0 ? null : this;
}
