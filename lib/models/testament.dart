enum Testament {
  oldTestament,
  newTestament;

  String title() => switch (this) {
    oldTestament => 'Old Testament',
    newTestament => 'New Testament',
  };
}
