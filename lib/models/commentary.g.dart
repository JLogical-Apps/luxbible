// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commentary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Commentary _$CommentaryFromJson(Map<String, dynamic> json) => _Commentary(
  name: json['n'] as String,
  notes: _notesFromJson(json['v'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CommentaryToJson(_Commentary instance) =>
    <String, dynamic>{'n': instance.name, 'v': _notesToJson(instance.notes)};
