import 'dart:convert';

import 'package:collection/collection.dart';
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

  static final markdownHeadingPattern = RegExp(r'^#{1,6}\s+');

  // Blank lines separate paragraphs, and headings and quotes are blocks of their own. Inline Markdown stays as written.
  static List<RichContent> listFromMarkdown(String markdown) => LineSplitter.split(markdown)
      .map((line) => line.trim())
      .splitBetween(
        (first, second) =>
            first.isEmpty != second.isEmpty ||
            [first, second].any(markdownHeadingPattern.hasMatch) ||
            first.startsWith('>') != second.startsWith('>'),
      )
      .where((lines) => lines.first.isNotEmpty)
      .map(
        (lines) => switch (lines) {
          [final line] when markdownHeadingPattern.hasMatch(line) => RichContent.paragraph(
            text: Markdown(line.replaceFirst(markdownHeadingPattern, '')),
            style: .subheading,
          ),
          _ when lines.first.startsWith('>') => RichContent.paragraph(
            text: Markdown(lines.map((line) => line.replaceFirst(RegExp(r'^>\s?'), '').trim()).join(' ')),
            style: .quote,
          ),
          _ => RichContent.paragraph(text: Markdown(lines.join(' '))),
        },
      )
      .toList();
}

extension RichContentExtensions on RichContent {
  Iterable<Markdown> get texts => switch (this) {
    RichParagraph(:final text) => [text],
    RichTable(:final rows) => rows.flattened,
    RichBibleMap() => [],
    RichBox(:final content) => content.expand((content) => content.texts),
  };
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
  @JsonValue('s')
  subheading,
  @JsonValue('i')
  indented,
  @JsonValue('e')
  italic,
  @JsonValue('d')
  bold,
  @JsonValue('f')
  boldItalic,
}
