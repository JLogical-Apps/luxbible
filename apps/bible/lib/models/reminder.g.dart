// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoneReminder _$NoneReminderFromJson(Map<String, dynamic> json) =>
    NoneReminder($type: json['runtimeType'] as String?);

Map<String, dynamic> _$NoneReminderToJson(NoneReminder instance) =>
    <String, dynamic>{'runtimeType': instance.$type};

DailyReminder _$DailyReminderFromJson(Map<String, dynamic> json) =>
    DailyReminder(
      time: Time.fromJson(json['time'] as String),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$DailyReminderToJson(DailyReminder instance) =>
    <String, dynamic>{
      'time': instance.time.toJson(),
      'runtimeType': instance.$type,
    };
