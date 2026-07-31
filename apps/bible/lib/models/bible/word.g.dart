// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Word _$WordFromJson(Map<String, dynamic> json) => _Word(
  text: json['t'] as String?,
  data: json['d'] == null
      ? null
      : InterlinearData.fromJson(json['d'] as Map<String, dynamic>),
  redLetters: json['r'] as bool? ?? false,
  italic: json['i'] as bool? ?? false,
);

Map<String, dynamic> _$WordToJson(_Word instance) => <String, dynamic>{
  't': ?instance.text,
  'd': ?instance.data?.toJson(),
  'r': ?_onlyIfTrue(instance.redLetters),
  'i': ?_onlyIfTrue(instance.italic),
};
