import 'package:equatable/equatable.dart';
import 'package:lux/i18n.dart';

class Time extends Equatable {
  final int hour;
  final int minute;

  Time({required this.hour, required this.minute}) {
    if (hour < 0 || hour > 23) throw ArgumentError.value(hour, 'hour', 'Must be between 0 and 23.');
    if (minute < 0 || minute > 59) throw ArgumentError.value(minute, 'minute', 'Must be between 0 and 59.');
  }

  factory Time.now() => Time(hour: DateTime.now().hour, minute: DateTime.now().minute);

  factory Time.fromJson(String json) {
    final parts = json.split(':');
    return Time(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }

  String toJson() => format(format: .twentyFourHour);

  int get hourOfPeriod => hour % 12;
  TimePeriod get period => hour < 12 ? .am : .pm;

  String format({required TimeFormat format}) {
    final formattedMinute = minute.toString().padLeft(2, '0');
    final formattedHour = hourOfPeriod == 0 ? 12 : hourOfPeriod;
    return format.when(
      twentyFourHour: '${hour.toString().padLeft(2, '0')}:$formattedMinute',
      amPm: '$formattedHour:$formattedMinute ${period.format()}',
    );
  }

  @override
  List<Object> get props => [hour, minute];

  @override
  String toString() => toJson();
}

enum TimeFormat {
  amPm,
  twentyFourHour;

  T when<T>({required T amPm, required T twentyFourHour}) => switch (this) {
    .amPm => amPm,
    .twentyFourHour => twentyFourHour,
  };
}

enum TimePeriod {
  am,
  pm;

  String format() => switch (this) {
    .am => t.common.am,
    .pm => t.common.pm,
  };
}
