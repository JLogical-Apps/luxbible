import 'package:bible/models/bible/word.dart';
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
  }) = _Verse;

  factory Verse.fromJson(Map<String, dynamic> json) => _$VerseFromJson(json);

  String get text => words.map((word) => word.text).nonNulls.join();
  List<String> get strongIds => words.map((word) => word.data?.strongId).nonNulls.toList();
  List<String> get searchTerms =>
      text.trim().toLowerCase().split(RegExp(r'[\s-]+')).where((string) => string.isNotBlank).toList();

  Verse trimStart() => Verse(
    verseNum: verseNum,
    words: words.skipWhile((word) => word.text?.isBlank == true && word.data == null).toList(),
  );
}
