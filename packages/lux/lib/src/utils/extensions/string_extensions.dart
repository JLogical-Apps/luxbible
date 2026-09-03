import 'package:fuzzywuzzy/fuzzywuzzy.dart';
import 'package:utils_core/utils_core.dart';

final _bibleWordPattern = RegExp(
  r"\p{N}+(?:,\p{N}{3})+|[\p{L}\p{M}\p{N}]+(?:['’ʼ\-‐‑־][\p{L}\p{M}\p{N}]+)*",
  unicode: true,
);
final _formattedNumberPattern = RegExp(r'^\p{N}+(?:,\p{N}{3})+$', unicode: true);
final _nonLetterOrNumberPattern = RegExp(r'[^\p{L}\p{M}\p{N}]', unicode: true);

extension StringExtensions on String {
  String get withCollapsedWhitespace => replaceAll(RegExp(r'\s+'), ' ').trim();
  String get withStrippedWhitespace => replaceAll(RegExp(r'\s+'), '').trim();

  String withLength(int length) => this.length > length ? '${substring(0, length - 3)}...' : this;

  List<String> get keywords =>
      trim().toLowerCase().split(RegExp(r'[\s-]+')).where((string) => string.isNotBlank).toList();

  List<String> get words => trim().split(RegExp(r'[\s-]+')).where((string) => string.isNotBlank).toList();

  bool passesSearch(List<String> searchKeywords, {double? similarityLimit = 0.88}) => keywords.every(
    (word) => searchKeywords.any(
      (keyword) =>
          keyword.startsWith(word) || (similarityLimit != null && ratio(word, keyword) / 100 > similarityLimit),
    ),
  );

  bool get isUpperCase => this == toUpperCase();
  bool get isLowerCase => this == toLowerCase();
  String get lastLetter => this[length - 1];
  bool get hasQuotationMark => contains(RegExp('["“”〝〞＂]'));

  String get onlyLetters => replaceAll(RegExp(r"[^a-zA-ZͰ-Ͽἀ-῿֐-׿ ]"), '');
  List<String> get bibleSearchTerms => _bibleWordPattern
      .allMatches(toLowerCase())
      .map((match) => match[0]!)
      .map((term) => _formattedNumberPattern.hasMatch(term) ? term : term.replaceAll(_nonLetterOrNumberPattern, ''))
      .toList();

  (int, int)? getWordRangeAt(int characterOffset) => _bibleWordPattern
      .allMatches(this)
      .where((match) => characterOffset >= match.start && characterOffset < match.end)
      .firstOrNull
      ?.mapIfNonNull((match) => (match.start, match.end - 1));

  bool get isStrongId => RegExp(r'^[GH]\d{1,4}$').hasMatch(this);

  String get withoutPunctuation =>
      replaceAll(RegExp(r'''[!"#$%&'()*+,\-./:;<=>?@\[\\\]^_`{|}~‘’‚‛“”„‟…‧‐‑‒–—―··;־׀׃׆׳״]'''), '');
  bool get isPunctuation => this != withoutPunctuation;
}
