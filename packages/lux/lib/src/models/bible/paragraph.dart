import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lux/lux_core.dart';
import 'package:utils_core/utils_core.dart';

part 'paragraph.freezed.dart';
part 'paragraph.g.dart';

@Freezed(unionKey: 'r')
sealed class Paragraph with _$Paragraph {
  const Paragraph._();

  @FreezedUnionValue('v')
  const factory Paragraph.verses({
    @JsonKey(name: 'v') required List<Verse> verses,
    @JsonKey(name: 'o', toJson: _firstVerseOffsetToJson, includeIfNull: false) @Default(0) int firstVerseOffset,
    @JsonKey(name: 't') required ParagraphType type,
    @jsonIgnore @Default(false) bool preventIndent,
  }) = VersesParagraph;

  @FreezedUnionValue('s')
  const factory Paragraph.section({
    @JsonKey(name: 'x') required String text,
    @JsonKey(name: 't') required SectionType type,
  }) = SectionParagraph;

  @FreezedUnionValue('b')
  const factory Paragraph.lineBreak() = BreakParagraph;

  factory Paragraph.fromJson(Map<String, dynamic> json) => _$ParagraphFromJson(json);
}

extension ParagraphListExtensions on List<Paragraph> {
  Verse? getVerseIntroducedBySectionAt(int index) {
    final versesParagraph = this[index] is SectionParagraph
        ? skip(index + 1).whereType<VersesParagraph>().firstOrNull
        : null;
    return versesParagraph?.firstVerseOffset == 0 ? versesParagraph?.verses.firstOrNull : null;
  }

  int? getSectionIndexForVerse(int verseNum) => indexed
      .where((entry) => entry.$2 is SectionParagraph)
      .firstWhereOrNull((entry) => getVerseIntroducedBySectionAt(entry.$1)?.verseNum == verseNum)
      ?.$1;

  SectionType? getSectionTypeForVerse(int verseNum) =>
      getSectionIndexForVerse(verseNum)?.mapIfNonNull((index) => this[index] as SectionParagraph)?.type;

  bool verseHasSection(int verseNum) => getSectionIndexForVerse(verseNum) != null;

  int? getIndexForVerse(int verseNum) => indexWhereOrNull(
    (paragraph) => paragraph is VersesParagraph && paragraph.verses.any((verse) => verse.verseNum == verseNum),
  );
}

enum SectionType {
  ms,
  s1,
  s2,
  d,
  qa,
  sp;

  bool operator >(SectionType type) => index < type.index;
}

enum ParagraphType {
  p,
  pm,
  pi,
  pc,
  pr,
  q1,
  q2,
  qr,
  qs,
  qc,
  m,
  li1,
  li2,
  nb;

  bool get isPoetic => this == q1 || this == q2 || this == qr || this == qs || this == qc;
  bool get isItalic => this == qs;

  double get indent => switch (this) {
    q1 || li1 || pm || m || qc || pc || nb => 0,
    pi => 40,
    _ => 20,
  };

  double get hangingIndent => this == q1 || this == q2 || this == li1 ? 30 : 0;
  double get blockIndent => this == q2 ? 20 : 0;
}

int? _firstVerseOffsetToJson(int firstVerseOffset) => firstVerseOffset.nullIfZero;
