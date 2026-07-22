import 'package:fuzzywuzzy/fuzzywuzzy.dart';
import 'package:utils_core/utils_core.dart';

extension StringExtensions on String {
  String get onlyLetters => replaceAll(RegExp(r"[^a-zA-ZͰ-Ͽἀ-῿֐-׿ ]"), "");
  bool get isLetterOnly => contains(RegExp(r"[^a-zA-ZͰ-Ͽἀ-῿֐-׿'\-]"));

  String get withCollapsedWhitespace => replaceAll(RegExp(r'\s+'), ' ').trim();
  String get withStrippedWhitespace => replaceAll(RegExp(r'\s+'), '').trim();

  String withLength(int length) => this.length > length ? '${substring(0, length - 3)}...' : this;

  bool get isStrongId => RegExp(r'^[GH]\d{1,4}$').hasMatch(this);

  List<String> get keywords =>
      trim().toLowerCase().split(RegExp(r'[\s-]+')).where((string) => string.isNotBlank).toList();

  bool passesSearch(List<String> searchKeywords, {double? similarityLimit = 0.88}) => keywords.every(
    (word) => searchKeywords.any(
      (sk) => sk.startsWith(word) || (similarityLimit != null && ratio(word, sk) / 100 > similarityLimit),
    ),
  );
}
