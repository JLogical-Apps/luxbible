import 'package:bible/models/bible/footnote.dart';
import 'package:bible/models/bible/word.dart';
import 'package:bible/models/reference/bible_text_selection.dart';
import 'package:bible/models/reference/reference.dart';
import 'package:bible/utils/extensions/string_extensions.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:utils_core/utils_core.dart';

part 'verse.freezed.dart';
part 'verse.g.dart';

@freezed
sealed class Verse with _$Verse {
  const Verse._();

  const factory Verse({
    @JsonKey(name: 'n') required int verseNum,
    @JsonKey(name: 'w') required List<Word> words,
    @JsonKey(name: 'o', includeIfNull: false) Reference? originalVerse,
    @JsonKey(name: 'f', includeIfNull: false) List<Footnote>? footnotes,
  }) = _Verse;

  factory Verse.fromJson(Map<String, dynamic> json) => _$VerseFromJson(json);

  String get text => words.map((word) => word.text).nonNulls.join();
  List<String> get strongIds => words.map((word) => word.data?.strongId).nonNulls.toList();
  List<String> get searchTerms =>
      text.onlyLetters.toLowerCase().split(' ').where((string) => string.isNotBlank).toList();

  Verse trimStart() => Verse(
    verseNum: verseNum,
    words: words.skipWhile((word) => word.text?.isBlank == true && word.data == null).toList(),
    originalVerse: originalVerse,
    footnotes: footnotes,
  );
}

extension IterableVerseExtensions on Iterable<Verse> {
  String getTextSelectionText(BibleTextSelection selection) {
    final verseTexts = map((verse) => verse.text).toList();
    verseTexts[verseTexts.length - 1] = verseTexts[verseTexts.length - 1].substring(
      0,
      selection.end.characterOffset + 1,
    );
    verseTexts[0] = verseTexts[0].substring(selection.start.characterOffset);

    return verseTexts.join(' ');
  }

  List<Verse> trim() {
    if (isEmpty) {
      return toList();
    }

    final list = skipWhile((verse) => verse.text.isBlank).toList();
    if (list.isEmpty) {
      return list;
    }
    list[0] = list[0].trimStart();
    return list;
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
