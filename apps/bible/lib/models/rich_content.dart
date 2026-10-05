import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lux/lux_core.dart';

part 'rich_content.freezed.dart';
part 'rich_content.g.dart';

@Freezed(unionKey: 'r')
sealed class RichContent with _$RichContent {
  @FreezedUnionValue('p')
  const factory RichContent.paragraph({
    @JsonKey(name: 'x', toJson: Markdown.toJson, fromJson: Markdown.fromJson) required Markdown text,
    @JsonKey(name: 's') @Default(RichParagraphStyle.body) RichParagraphStyle style,
  }) = RichParagraph;

  @FreezedUnionValue('t')
  const factory RichContent.table({
    @JsonKey(name: 'w', toJson: Markdown.toJsonTable, fromJson: Markdown.fromJsonTable)
    required List<List<Markdown>> rows,
  }) = RichTable;

  @FreezedUnionValue('m')
  const factory RichContent.bibleMap({@JsonKey(name: 'i') required String id}) = RichBibleMap;

  @FreezedUnionValue('b')
  const factory RichContent.box({
    @JsonKey(name: 'h') required String title,
    @JsonKey(name: 'c') required List<RichContent> content,
  }) = RichBox;

  factory RichContent.fromJson(Map<String, dynamic> json) => _$RichContentFromJson(json);
}

enum RichParagraphStyle {
  @JsonValue('b')
  body,
  @JsonValue('q')
  quote,
  @JsonValue('p')
  poetry,
  @JsonValue('c')
  centered,
  @JsonValue('a')
  attribution,
  @JsonValue('h')
  heading,
  @JsonValue('i')
  indented,
  @JsonValue('e')
  italic,
  @JsonValue('d')
  bold,
  @JsonValue('f')
  boldItalic,
}
