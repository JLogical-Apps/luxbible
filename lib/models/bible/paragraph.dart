import 'package:bible/models/bible/verse.dart';
import 'package:bible/utils/extensions/num_extensions.dart';
import 'package:bible/utils/serialization_utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

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

enum SectionType {
  ms,
  s1,
  s2,
  d,
  qa;

  bool operator >(SectionType type) => index < type.index;
}

enum ParagraphType {
  p,
  pi,
  pc,
  pr,
  q1,
  q2,
  qr,
  qc,
  m,
  li1,
  li2,
  nb;

  bool get isPoetic => this == q1 || this == q2 || this == qr || this == qc;

  double get indent => switch (this) {
    q1 || li1 || m || qc || pc || nb => 0,
    pi => 40,
    _ => 20,
  };

  double get hangingIndent => this == q1 || this == q2 ? 30 : 0;
  double get blockIndent => hangingIndent == 0 ? 0 : indent;
}

int? _firstVerseOffsetToJson(int firstVerseOffset) => firstVerseOffset.nullIfZero;
