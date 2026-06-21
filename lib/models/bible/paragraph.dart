import 'package:bible/models/bible/verse.dart';
import 'package:bible/utils/extensions/num_extensions.dart';
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

enum SectionType { s1, s2, ms, d }

enum ParagraphType {
  p,
  pi,
  q1,
  q2,
  qr,
  li1,
  li2;

  bool get isPoetic => this == q1 || this == q2 || this == qr;
}

int? _firstVerseOffsetToJson(int firstVerseOffset) => firstVerseOffset.nullIfZero;
