// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commentary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CommentaryBook _$CommentaryBookFromJson(
  Map<String, dynamic> json,
) => _CommentaryBook(
  introduction:
      (json['i'] as List<dynamic>?)
          ?.map((e) => CommentaryContent.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  blocksByChapter:
      (json['c'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(
          int.parse(k),
          (e as List<dynamic>)
              .map((e) => CommentaryBlock.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      ) ??
      const {},
);

Map<String, dynamic> _$CommentaryBookToJson(_CommentaryBook instance) =>
    <String, dynamic>{
      'i': instance.introduction.map((e) => e.toJson()).toList(),
      'c': instance.blocksByChapter.map(
        (k, e) => MapEntry(k.toString(), e.map((e) => e.toJson()).toList()),
      ),
    };

CommentaryOutline _$CommentaryOutlineFromJson(Map<String, dynamic> json) =>
    CommentaryOutline(
      items: (json['i'] as List<dynamic>)
          .map((e) => CommentaryOutlineItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      $type: json['r'] as String?,
    );

Map<String, dynamic> _$CommentaryOutlineToJson(CommentaryOutline instance) =>
    <String, dynamic>{
      'i': instance.items.map((e) => e.toJson()).toList(),
      'r': instance.$type,
    };

CommentarySection _$CommentarySectionFromJson(Map<String, dynamic> json) =>
    CommentarySection(
      selection: VerseSelection.fromJson(json['v'] as String),
      content: (json['b'] as List<dynamic>)
          .map((e) => CommentaryContent.fromJson(e as Map<String, dynamic>))
          .toList(),
      $type: json['r'] as String?,
    );

Map<String, dynamic> _$CommentarySectionToJson(CommentarySection instance) =>
    <String, dynamic>{
      'v': instance.selection.toJson(),
      'b': instance.content.map((e) => e.toJson()).toList(),
      'r': instance.$type,
    };

CommentaryParagraph _$CommentaryParagraphFromJson(Map<String, dynamic> json) =>
    CommentaryParagraph(
      text: Markdown.fromJson(json['x'] as String),
      style:
          $enumDecodeNullable(_$CommentaryParagraphStyleEnumMap, json['s']) ??
          CommentaryParagraphStyle.body,
      $type: json['r'] as String?,
    );

Map<String, dynamic> _$CommentaryParagraphToJson(
  CommentaryParagraph instance,
) => <String, dynamic>{
  'x': Markdown.toJson(instance.text),
  's': _$CommentaryParagraphStyleEnumMap[instance.style]!,
  'r': instance.$type,
};

const _$CommentaryParagraphStyleEnumMap = {
  CommentaryParagraphStyle.body: 'b',
  CommentaryParagraphStyle.quote: 'q',
  CommentaryParagraphStyle.poetry: 'p',
  CommentaryParagraphStyle.centered: 'c',
  CommentaryParagraphStyle.attribution: 'a',
  CommentaryParagraphStyle.heading: 'h',
  CommentaryParagraphStyle.indented: 'i',
  CommentaryParagraphStyle.italic: 'e',
  CommentaryParagraphStyle.bold: 'd',
  CommentaryParagraphStyle.boldItalic: 'f',
};

CommentaryTable _$CommentaryTableFromJson(Map<String, dynamic> json) =>
    CommentaryTable(
      rows: Markdown.fromJsonTable(json['w'] as List),
      $type: json['r'] as String?,
    );

Map<String, dynamic> _$CommentaryTableToJson(CommentaryTable instance) =>
    <String, dynamic>{
      'w': Markdown.toJsonTable(instance.rows),
      'r': instance.$type,
    };

_CommentaryOutlineItem _$CommentaryOutlineItemFromJson(
  Map<String, dynamic> json,
) => _CommentaryOutlineItem(
  selection: VerseSelection.fromJson(json['v'] as String),
  text: Markdown.fromJson(json['x'] as String),
);

Map<String, dynamic> _$CommentaryOutlineItemToJson(
  _CommentaryOutlineItem instance,
) => <String, dynamic>{
  'v': instance.selection.toJson(),
  'x': Markdown.toJson(instance.text),
};
