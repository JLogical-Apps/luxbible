import 'package:collection/collection.dart';
import 'package:lux/lux_core.dart';
import 'package:utils_core/utils_core.dart';

class Phrase {
  final List<Word> words;

  Phrase({required this.words});

  late final String text = words.map((word) => word.text).nonNulls.join();
  late final List<String> textWords = text
      .trim()
      .onlyLetters
      .split(RegExp(r'[\s-]+'))
      .where((string) => string.isNotBlank)
      .toList();
  late final List<String> keywords = text.onlyLetters.keywords;

  Phrase trim() {
    final start = _leadingWhitespacePattern.firstMatch(text)!.end;
    final end = _trailingWhitespacePattern.firstMatch(text)!.start;

    return Phrase(
      words: start < end ? words.positioned.wordsWithin(start: start, end: end, textLength: text.length) : [],
    );
  }

  static List<Phrase> fromVerse(Verse verse) => verse.splitIntoPhrasesAt(verse.text.phraseBreakOffsets);
}

final _wordPattern = RegExp(r"[A-Za-z0-9]+(?:[’'-][A-Za-z0-9]+)*");
final _leadingWhitespacePattern = RegExp(r'^\s*');
final _trailingWhitespacePattern = RegExp(r'\s*$');
final _whitespacePattern = RegExp(r'\s+');

final _sentenceBreakPattern = RegExp(r'''(?<=[.!?])(?=\s+)|(?<=[.!?][”’"'])(?=\s+)''');
final _softPunctuationBreakPattern = RegExp(r'(?<=[;:—])(?=\s+)|(?=\()|(?<=\))');
final _commaBreakPattern = RegExp(r'''(?<=,)(?=\s+)|(?<=,[”’"'])(?=\s+)''');
final _hardConjunctionBreakPattern = RegExp(r'(?=\s+(?:for|therefore|but|that)\b)', caseSensitive: false);
final _softConjunctionBreakPattern = RegExp(r'(?=\s+(?:and|nor)\b)', caseSensitive: false);
final _splitRules = <({RegExp pattern, int minimumWords})>[
  (pattern: _sentenceBreakPattern, minimumWords: 6),
  (pattern: _softPunctuationBreakPattern, minimumWords: 13),
  (pattern: _commaBreakPattern, minimumWords: 13),
  (pattern: _hardConjunctionBreakPattern, minimumWords: 13),
  (pattern: _softConjunctionBreakPattern, minimumWords: 13),
];

typedef _PositionedWord = ({Word word, int start, int end});

extension VersePhraseExtensions on Verse {
  List<Phrase> splitIntoPhrasesAt(List<int> breakOffsets) {
    final positionedWords = words.positioned;
    final boundaries = [0, ...breakOffsets, text.length];

    return boundaries
        .take(boundaries.length - 1)
        .mapIndexed(
          (index, start) => Phrase(
            words: positionedWords.wordsWithin(start: start, end: boundaries[index + 1], textLength: text.length),
          ).trim(),
        )
        .where((phrase) => phrase.text.isNotEmpty)
        .toList();
  }
}

extension on String {
  List<int> get phraseBreakOffsets {
    final phrases = phraseTexts;
    return phrases
        .take(phrases.length - 1)
        .fold(<int>[], (offsets, phrase) => offsets..add((offsets.lastOrNull ?? 0) + phrase.length));
  }

  List<String> get phraseTexts => _splitRules
      .fold(
        [this],
        (phrases, rule) => phrases
            .expand((phrase) => phrase.wordCount < rule.minimumWords ? [phrase] : phrase.split(rule.pattern))
            .toList()
            .withShortPhrasesMerged,
      )
      .expand((phrase) => phrase.withLongPhrasesSplit)
      .toList();

  int get wordCount => _wordPattern.allMatches(this).length;

  List<String> get withLongPhrasesSplit {
    if (wordCount <= 12) {
      return [this];
    }

    final boundary = _whitespacePattern
        .allMatches(this)
        .where((match) => substring(0, match.start).wordCount >= 3 && substring(match.end).wordCount >= 3)
        .sortedBy((match) => (substring(0, match.start).wordCount - substring(match.end).wordCount).abs())
        .firstOrNull;
    if (boundary == null) {
      return [this];
    }

    return [...substring(0, boundary.start).withLongPhrasesSplit, ...substring(boundary.start).withLongPhrasesSplit];
  }
}

extension on List<String> {
  List<String> get withShortPhrasesMerged {
    final index = indexWhereOrNull((phrase) => phrase.wordCount < 3);
    if (index == null || length == 1) {
      return this;
    }

    final neighborIndex = switch (index) {
      0 => 1,
      final index when index == length - 1 => index - 1,
      final index => this[index - 1].wordCount <= this[index + 1].wordCount ? index - 1 : index + 1,
    };

    final firstIndex = index < neighborIndex ? index : neighborIndex;
    return [
      ...take(firstIndex),
      '${this[firstIndex]}${this[firstIndex + 1]}',
      ...skip(firstIndex + 2),
    ].withShortPhrasesMerged;
  }
}

extension on List<Word> {
  List<_PositionedWord> get positioned {
    var offset = 0;
    return fold([], (words, word) {
      final start = offset;
      offset += word.text?.length ?? 0;
      return words..add((word: word, start: start, end: offset));
    });
  }
}

extension on List<_PositionedWord> {
  List<Word> wordsWithin({required int start, required int end, required int textLength}) => map((positionedWord) {
    final (:word, start: wordStart, end: wordEnd) = positionedWord;
    final text = word.text;
    if (text == null || text.isEmpty) {
      return wordStart >= start && (wordStart < end || end == textLength && wordStart == end) ? word : null;
    }

    final overlapStart = wordStart.clamp(start, end);
    final overlapEnd = wordEnd.clamp(start, end);
    return overlapStart < overlapEnd
        ? word.copyWith(text: text.substring(overlapStart - wordStart, overlapEnd - wordStart))
        : null;
  }).nonNulls.toList();
}
