import 'package:bible/utils/extensions/date_time_extensions.dart';
import 'package:equatable/equatable.dart';

class CalendarDateTime extends Equatable {
  final DateTime value;

  CalendarDateTime.fromDateTime(DateTime value) : value = value.toUtc();
  CalendarDateTime.now() : value = DateTime.now().toUtc();

  factory CalendarDateTime.fromJson(String json) => CalendarDateTime.fromDateTime(DateTime.parse(json));

  DateTime toDateTime() => value.toLocal();

  bool isOnSameLocalDateAs(DateTime other) => toDateTime().isOnSameLocalDateAs(other);

  String toJson() => value.toIso8601String();

  @override
  List<Object> get props => [value];
}
