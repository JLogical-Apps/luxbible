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
  BibleTranslation.htb: 'htb',
  BibleTranslation.nld1939: 'nld1939',
  BibleTranslation.sv: 'sv',
  BibleTranslation.amp: 'amp',
  BibleTranslation.asv: 'asv',
  BibleTranslation.bsb: 'bsb',
  BibleTranslation.csb: 'csb',
  BibleTranslation.kjv: 'kjv',
  BibleTranslation.msb: 'msb',
  BibleTranslation.nasb95: 'nasb95',
  BibleTranslation.niv11: 'niv11',
  BibleTranslation.nkjv: 'nkjv',
  BibleTranslation.nlt: 'nlt',
  BibleTranslation.web: 'web',
  BibleTranslation.fob: 'fob',
  BibleTranslation.martin1744: 'martin1744',
  BibleTranslation.elb1905: 'elb1905',
  BibleTranslation.hfa: 'hfa',
  BibleTranslation.lut1912: 'lut1912',
  BibleTranslation.byz: 'byz',
  BibleTranslation.lxx: 'lxx',
  BibleTranslation.statresgnt: 'statresgnt',
  BibleTranslation.tr: 'tr',
  BibleTranslation.oshb: 'oshb',
  BibleTranslation.ntr: 'ntr',
  BibleTranslation.nrt: 'nrt',
  BibleTranslation.synodal: 'synodal',
  BibleTranslation.rvg: 'rvg',
  BibleTranslation.tglulb: 'tglulb',
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
  CommentaryType.tyndale: 'tyndale',
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

LinkedResourcesStudyPanel _$LinkedResourcesStudyPanelFromJson(
  Map<String, dynamic> json,
) => LinkedResourcesStudyPanel($type: json['runtimeType'] as String?);

Map<String, dynamic> _$LinkedResourcesStudyPanelToJson(
  LinkedResourcesStudyPanel instance,
) => <String, dynamic>{'runtimeType': instance.$type};

NotesStudyPanel _$NotesStudyPanelFromJson(Map<String, dynamic> json) =>
    NotesStudyPanel($type: json['runtimeType'] as String?);

Map<String, dynamic> _$NotesStudyPanelToJson(NotesStudyPanel instance) =>
    <String, dynamic>{'runtimeType': instance.$type};
