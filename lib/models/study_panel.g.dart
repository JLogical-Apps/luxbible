// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'study_panel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompareStudyPanel _$CompareStudyPanelFromJson(Map<String, dynamic> json) =>
    CompareStudyPanel(
      translation: $enumDecode(_$BibleTranslationEnumMap, json['translation']),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$CompareStudyPanelToJson(CompareStudyPanel instance) =>
    <String, dynamic>{
      'translation': _$BibleTranslationEnumMap[instance.translation]!,
      'runtimeType': instance.$type,
    };

const _$BibleTranslationEnumMap = {
  BibleTranslation.bsb: 'bsb',
  BibleTranslation.nasb95: 'nasb95',
  BibleTranslation.niv11: 'niv11',
  BibleTranslation.csb: 'csb',
  BibleTranslation.nlt: 'nlt',
  BibleTranslation.nkjv: 'nkjv',
  BibleTranslation.kjv: 'kjv',
  BibleTranslation.asv: 'asv',
  BibleTranslation.lxx: 'lxx',
  BibleTranslation.tr: 'tr',
  BibleTranslation.byz: 'byz',
  BibleTranslation.statresgnt: 'statresgnt',
  BibleTranslation.oshb: 'oshb',
  BibleTranslation.sv: 'sv',
};

InterlinearStudyPanel _$InterlinearStudyPanelFromJson(
  Map<String, dynamic> json,
) => InterlinearStudyPanel(
  direction: $enumDecode(_$InterlinearDirectionEnumMap, json['direction']),
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$InterlinearStudyPanelToJson(
  InterlinearStudyPanel instance,
) => <String, dynamic>{
  'direction': _$InterlinearDirectionEnumMap[instance.direction]!,
  'runtimeType': instance.$type,
};

const _$InterlinearDirectionEnumMap = {
  InterlinearDirection.reverse: 'reverse',
  InterlinearDirection.forward: 'forward',
};

CommentaryStudyPanel _$CommentaryStudyPanelFromJson(
  Map<String, dynamic> json,
) => CommentaryStudyPanel(
  type: $enumDecode(_$CommentaryTypeEnumMap, json['type']),
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$CommentaryStudyPanelToJson(
  CommentaryStudyPanel instance,
) => <String, dynamic>{
  'type': _$CommentaryTypeEnumMap[instance.type]!,
  'runtimeType': instance.$type,
};

const _$CommentaryTypeEnumMap = {
  CommentaryType.matthewHenry: 'matthewHenry',
  CommentaryType.jamiesonFaussetBrown: 'jamiesonFaussetBrown',
  CommentaryType.calvin: 'calvin',
};

CrossReferencesStudyPanel _$CrossReferencesStudyPanelFromJson(
  Map<String, dynamic> json,
) => CrossReferencesStudyPanel($type: json['runtimeType'] as String?);

Map<String, dynamic> _$CrossReferencesStudyPanelToJson(
  CrossReferencesStudyPanel instance,
) => <String, dynamic>{'runtimeType': instance.$type};

NotesStudyPanel _$NotesStudyPanelFromJson(Map<String, dynamic> json) =>
    NotesStudyPanel($type: json['runtimeType'] as String?);

Map<String, dynamic> _$NotesStudyPanelToJson(NotesStudyPanel instance) =>
    <String, dynamic>{'runtimeType': instance.$type};
