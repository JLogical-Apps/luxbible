import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lux/lux_core.dart';

part 'verse_of_the_day_widget_payload.freezed.dart';
part 'verse_of_the_day_widget_payload.g.dart';

@freezed
sealed class VerseOfTheDayWidgetEntry with _$VerseOfTheDayWidgetEntry {
  const factory VerseOfTheDayWidgetEntry({
    @isoDate required DateTime date,
    required String reference,
    required String translation,
    required String text,
  }) = _VerseOfTheDayWidgetEntry;

  factory VerseOfTheDayWidgetEntry.fromJson(Map<String, Object?> json) => _$VerseOfTheDayWidgetEntryFromJson(json);
}

@freezed
sealed class VerseOfTheDayWidgetPayload with _$VerseOfTheDayWidgetPayload {
  const VerseOfTheDayWidgetPayload._();

  const factory VerseOfTheDayWidgetPayload({required List<VerseOfTheDayWidgetEntry> entries}) =
      _VerseOfTheDayWidgetPayload;

  factory VerseOfTheDayWidgetPayload.fromJson(Map<String, Object?> json) => _$VerseOfTheDayWidgetPayloadFromJson(json);

  String encode() => jsonEncode(toJson());
}
