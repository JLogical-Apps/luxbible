// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rich_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RichParagraph _$RichParagraphFromJson(Map<String, dynamic> json) =>
    RichParagraph(
      text: Markdown.fromJson(json['x'] as String),
      style:
          $enumDecodeNullable(_$RichParagraphStyleEnumMap, json['s']) ??
          RichParagraphStyle.body,
      $type: json['r'] as String?,
    );

Map<String, dynamic> _$RichParagraphToJson(RichParagraph instance) =>
    <String, dynamic>{
      'x': Markdown.toJson(instance.text),
      's': _$RichParagraphStyleEnumMap[instance.style]!,
      'r': instance.$type,
    };

const _$RichParagraphStyleEnumMap = {
  RichParagraphStyle.body: 'b',
  RichParagraphStyle.quote: 'q',
  RichParagraphStyle.poetry: 'p',
  RichParagraphStyle.centered: 'c',
  RichParagraphStyle.attribution: 'a',
  RichParagraphStyle.heading: 'h',
  RichParagraphStyle.subheading: 's',
  RichParagraphStyle.indented: 'i',
  RichParagraphStyle.italic: 'e',
  RichParagraphStyle.bold: 'd',
  RichParagraphStyle.boldItalic: 'f',
};

RichTable _$RichTableFromJson(Map<String, dynamic> json) => RichTable(
  rows: Markdown.fromJsonTable(json['w'] as List),
  $type: json['r'] as String?,
);

Map<String, dynamic> _$RichTableToJson(RichTable instance) => <String, dynamic>{
  'w': Markdown.toJsonTable(instance.rows),
  'r': instance.$type,
};

RichBibleMap _$RichBibleMapFromJson(Map<String, dynamic> json) =>
    RichBibleMap(id: json['i'] as String, $type: json['r'] as String?);

Map<String, dynamic> _$RichBibleMapToJson(RichBibleMap instance) =>
    <String, dynamic>{'i': instance.id, 'r': instance.$type};

RichBox _$RichBoxFromJson(Map<String, dynamic> json) => RichBox(
  title: json['h'] as String,
  content: (json['c'] as List<dynamic>)
      .map((e) => RichContent.fromJson(e as Map<String, dynamic>))
      .toList(),
  $type: json['r'] as String?,
);

Map<String, dynamic> _$RichBoxToJson(RichBox instance) => <String, dynamic>{
  'h': instance.title,
  'c': instance.content.map((e) => e.toJson()).toList(),
  'r': instance.$type,
};
