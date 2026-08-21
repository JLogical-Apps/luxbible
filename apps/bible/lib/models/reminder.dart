import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lux/lux.dart';
import 'package:utils_core/utils_core.dart';

part 'reminder.freezed.dart';
part 'reminder.g.dart';

@freezed
sealed class Reminder with _$Reminder {
  const Reminder._();

  const factory Reminder.none() = NoneReminder;
  const factory Reminder.daily({required Time time}) = DailyReminder;

  factory Reminder.fromJson(Map<String, dynamic> json) => _$ReminderFromJson(json);

  Time? get dailyTime => as<DailyReminder>()?.time;
}
