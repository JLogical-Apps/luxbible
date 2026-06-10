// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paragraph.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VersesParagraph _$VersesParagraphFromJson(Map<String, dynamic> json) =>
    VersesParagraph(
      verses: (json['v'] as List<dynamic>)
          .map((e) => Verse.fromJson(e as Map<String, dynamic>))
          .toList(),
      firstVerseOffset: (json['o'] as num?)?.toInt() ?? 0,
      type: $enumDecode(_$ParagraphTypeEnumMap, json['t']),
      $type: json['r'] as String?,
    );

Map<String, dynamic> _$VersesParagraphToJson(VersesParagraph instance) =>
    <String, dynamic>{
      'v': instance.verses.map((e) => e.toJson()).toList(),
      'o': ?_firstVerseOffsetToJson(instance.firstVerseOffset),
      't': _$ParagraphTypeEnumMap[instance.type]!,
      'r': instance.$type,
    };

const _$ParagraphTypeEnumMap = {
  ParagraphType.p: 'p',
  ParagraphType.pi: 'pi',
  ParagraphType.d: 'd',
  ParagraphType.q1: 'q1',
  ParagraphType.q2: 'q2',
  ParagraphType.qr: 'qr',
  ParagraphType.li1: 'li1',
  ParagraphType.li2: 'li2',
};

SectionParagraph _$SectionParagraphFromJson(Map<String, dynamic> json) =>
    SectionParagraph(
      text: json['x'] as String,
      type: $enumDecode(_$SectionTypeEnumMap, json['t']),
      $type: json['r'] as String?,
    );

Map<String, dynamic> _$SectionParagraphToJson(SectionParagraph instance) =>
    <String, dynamic>{
      'x': instance.text,
      't': _$SectionTypeEnumMap[instance.type]!,
      'r': instance.$type,
    };

const _$SectionTypeEnumMap = {SectionType.s1: 's1', SectionType.s2: 's2'};

BreakParagraph _$BreakParagraphFromJson(Map<String, dynamic> json) =>
    BreakParagraph($type: json['r'] as String?);

Map<String, dynamic> _$BreakParagraphToJson(BreakParagraph instance) =>
    <String, dynamic>{'r': instance.$type};
