// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'footnote.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Footnote _$FootnoteFromJson(Map<String, dynamic> json) =>
    _Footnote(offset: (json['o'] as num).toInt(), text: Markdown.fromJson(json['t'] as String));

Map<String, dynamic> _$FootnoteToJson(_Footnote instance) => <String, dynamic>{
  'o': instance.offset,
  't': Markdown.toJson(instance.text),
};
