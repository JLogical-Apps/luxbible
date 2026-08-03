extension BibleStringExtensions on String {
  String get onlyLetters => replaceAll(RegExp(r"[^a-zA-ZͰ-Ͽἀ-῿֐-׿ ]"), '');
  bool get isLetterOnly => contains(RegExp(r"[^a-zA-ZͰ-Ͽἀ-῿֐-׿'\-]"));
  bool get isStrongId => RegExp(r'^[GH]\d{1,4}$').hasMatch(this);
}
