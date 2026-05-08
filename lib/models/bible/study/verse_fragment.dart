class VerseFragment {
  final String text;
  final VerseFragmentStudy? study;

  const VerseFragment({required this.text, this.study});

  bool get isEmptyText => ['', '-', 'vvv', '. . .'].contains(text.trim());
}

class VerseFragmentStudy {
  final int originalPosition;
  final String? inflection;
  final String? strongId;
  final String? morphology;

  const VerseFragmentStudy({required this.originalPosition, required this.inflection, this.strongId, this.morphology});
}
