import 'package:flutter/material.dart';
import 'package:lux/lux.dart';

extension TimeExtensions on Time {
  TimeOfDay get timeOfDay => TimeOfDay(hour: hour, minute: minute);
}

extension TimeOfDayExtensions on TimeOfDay {
  Time get time => Time(hour: hour, minute: minute);
}
