// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verse_of_the_day_widget_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VerseOfTheDayWidgetEntry _$VerseOfTheDayWidgetEntryFromJson(
  Map<String, dynamic> json,
) => _VerseOfTheDayWidgetEntry(
  date: decodeIsoDate(json['date'] as String),
  reference: json['reference'] as String,
  translation: json['translation'] as String,
  text: json['text'] as String,
);

Map<String, dynamic> _$VerseOfTheDayWidgetEntryToJson(
  _VerseOfTheDayWidgetEntry instance,
) => <String, dynamic>{
  'date': encodeIsoDate(instance.date),
  'reference': instance.reference,
  'translation': instance.translation,
  'text': instance.text,
};

_VerseOfTheDayWidgetPayload _$VerseOfTheDayWidgetPayloadFromJson(
  Map<String, dynamic> json,
) => _VerseOfTheDayWidgetPayload(
  entries: (json['entries'] as List<dynamic>)
      .map((e) => VerseOfTheDayWidgetEntry.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$VerseOfTheDayWidgetPayloadToJson(
  _VerseOfTheDayWidgetPayload instance,
) => <String, dynamic>{
  'entries': instance.entries.map((e) => e.toJson()).toList(),
};
