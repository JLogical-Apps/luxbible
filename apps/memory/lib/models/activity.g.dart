// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PhraseReadActivity _$PhraseReadActivityFromJson(Map<String, dynamic> json) =>
    PhraseReadActivity(
      plan: PhraseReadActivityPlan.fromJson(
        json['plan'] as Map<String, dynamic>,
      ),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$PhraseReadActivityToJson(PhraseReadActivity instance) =>
    <String, dynamic>{
      'plan': instance.plan.toJson(),
      'runtimeType': instance.$type,
    };

ReadContextActivity _$ReadContextActivityFromJson(Map<String, dynamic> json) =>
    ReadContextActivity(
      plan: ReadContextActivityPlan.fromJson(
        json['plan'] as Map<String, dynamic>,
      ),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$ReadContextActivityToJson(
  ReadContextActivity instance,
) => <String, dynamic>{
  'plan': instance.plan.toJson(),
  'runtimeType': instance.$type,
};

PhraseSelectionActivity _$PhraseSelectionActivityFromJson(
  Map<String, dynamic> json,
) => PhraseSelectionActivity(
  plan: PhraseSelectionActivityPlan.fromJson(
    json['plan'] as Map<String, dynamic>,
  ),
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$PhraseSelectionActivityToJson(
  PhraseSelectionActivity instance,
) => <String, dynamic>{
  'plan': instance.plan.toJson(),
  'runtimeType': instance.$type,
};

WordSelectionActivity _$WordSelectionActivityFromJson(
  Map<String, dynamic> json,
) => WordSelectionActivity(
  plan: WordSelectionActivityPlan.fromJson(
    json['plan'] as Map<String, dynamic>,
  ),
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$WordSelectionActivityToJson(
  WordSelectionActivity instance,
) => <String, dynamic>{
  'plan': instance.plan.toJson(),
  'runtimeType': instance.$type,
};

WordTypeActivity _$WordTypeActivityFromJson(Map<String, dynamic> json) =>
    WordTypeActivity(
      plan: WordTypeActivityPlan.fromJson(json['plan'] as Map<String, dynamic>),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$WordTypeActivityToJson(WordTypeActivity instance) =>
    <String, dynamic>{
      'plan': instance.plan.toJson(),
      'runtimeType': instance.$type,
    };

ReferenceSelectionActivity _$ReferenceSelectionActivityFromJson(
  Map<String, dynamic> json,
) => ReferenceSelectionActivity(
  plan: ReferenceSelectionActivityPlan.fromJson(
    json['plan'] as Map<String, dynamic>,
  ),
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$ReferenceSelectionActivityToJson(
  ReferenceSelectionActivity instance,
) => <String, dynamic>{
  'plan': instance.plan.toJson(),
  'runtimeType': instance.$type,
};

ReferenceTypeActivity _$ReferenceTypeActivityFromJson(
  Map<String, dynamic> json,
) => ReferenceTypeActivity(
  plan: ReferenceTypeActivityPlan.fromJson(
    json['plan'] as Map<String, dynamic>,
  ),
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$ReferenceTypeActivityToJson(
  ReferenceTypeActivity instance,
) => <String, dynamic>{
  'plan': instance.plan.toJson(),
  'runtimeType': instance.$type,
};
