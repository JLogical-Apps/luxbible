// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commentary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Commentary _$CommentaryFromJson(Map<String, dynamic> json) => _Commentary(
  type: $enumDecode(_$CommentaryTypeEnumMap, json['t']),
  notes: _notesFromJson(json['v'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CommentaryToJson(_Commentary instance) =>
    <String, dynamic>{
      't': _$CommentaryTypeEnumMap[instance.type]!,
      'v': _notesToJson(instance.notes),
    };

const _$CommentaryTypeEnumMap = {CommentaryType.matthewHenry: 'matthewHenry'};
