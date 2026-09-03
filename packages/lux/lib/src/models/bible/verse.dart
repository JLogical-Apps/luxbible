import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lux/lux_core.dart';
import 'package:utils_core/utils_core.dart';

part 'verse.freezed.dart';
part 'verse.g.dart';

@freezed
sealed class Verse with _$Verse {
  Verse._();

  factory Verse({
    @JsonKey(name: 'n') required int verseNum,
    @JsonKey(name: 'w') required List<Word> words,
    @JsonKey(name: 'o', includeIfNull: false) Reference? originalVerse,
    @JsonKey(name: 'f', includeIfNull: false) List<Footnote>? footnotes,
  }) = _Verse;

  factory Verse.fromJson(Map<String, dynamic> json) => _$VerseFromJson(json);

  String get text => words.map((word) => word.text).nonNulls.join();
  List<String> get strongIds => words.map((word) => word.data?.strongId).nonNulls.toList();

  @override
  late final List<String> searchTerms = text.bibleSearchTerms;

  Verse trimStart() {
    final trimmedWords = words.skipWhile((word) => word.text?.isBlank == true && word.data == null).toList();
    final removedTextLength = words.take(words.length - trimmedWords.length).map((word) => word.text?.length ?? 0).sum;

    return Verse(
      verseNum: verseNum,
      words: trimmedWords,
      originalVerse: originalVerse,
      footnotes: footnotes
          ?.map((footnote) => footnote.copyWith(offset: (footnote.offset - removedTextLength).clampZero))
          .toList(),
    );
  }
}

extension IterableVerseExtensions on Iterable<Verse> {
  String getTextSelectionText(BibleTextSelection selection) {
    final verseTexts = map((verse) => verse.text).toList();
    final lastVerse = verseTexts.last;
    verseTexts[verseTexts.length - 1] = lastVerse.substring(
      0,
      (selection.end.characterOffset + 1).clamp(0, lastVerse.length),
    );
    verseTexts[0] = verseTexts[0].substring(selection.start.characterOffset);

    return verseTexts.join(' ');
  }

  List<Word> getTextSelectionWords(BibleTextSelection selection) {
    final verses = toList();
    return verses.expandIndexed((i, verse) {
      var words = verse.words;
      if (i + 1 == verses.length) {
        words = words
            .mapWithPrevious<(int, Word)>(
              (previousOffsetAndWord, word) =>
                  ((previousOffsetAndWord?.$1 ?? 0) + (previousOffsetAndWord?.$2.text?.length ?? 0), word),
            )
            .where((offsetAndWord) => offsetAndWord.$1 <= selection.end.characterOffset + 1)
            .map((offsetAndWord) => offsetAndWord.$2)
            .toList();
      }
      if (i == 0) {
        words = words
            .mapWithPrevious<(int, Word)>(
              (previousOffsetAndWord, word) =>
                  ((previousOffsetAndWord?.$1 ?? 0) + (previousOffsetAndWord?.$2.text?.length ?? 0), word),
            )
            .where(
              (offsetAndWord) =>
                  offsetAndWord.$1 + (offsetAndWord.$2.text?.length ?? 0) >= selection.start.characterOffset,
            )
            .map((offsetAndWord) => offsetAndWord.$2)
            .toList();
      }
      return words;
    }).toList();
  }

  List<Verse> trim() {
    final verses = skipWhile((verse) => verse.text.isBlank).toList();
    return [if (verses.firstOrNull case final first?) first.trimStart(), ...verses.skip(1)];
  }

  Iterable<Verse> withSameVersesCombined() => isEmpty
      ? this
      : fold<List<Verse>>([], (verses, verse) {
          final lastVerse = verses.lastOrNull;
          if (lastVerse == null) {
            return verses..add(verse);
          }

          return lastVerse.verseNum == verse.verseNum
              ? (verses
                  ..[verses.length - 1] = Verse(
                    verseNum: verse.verseNum,
                    words: lastVerse.words + verse.words,
                    originalVerse: lastVerse.originalVerse ?? verse.originalVerse,
                    footnotes: [
                      ...?lastVerse.footnotes,
                      ...?verse.footnotes?.map(
                        (footnote) => footnote.copyWith(offset: lastVerse.text.length + footnote.offset),
                      ),
                    ].nullIfEmpty?.toList(),
                  ))
              : (verses..add(verse));
        });
}
