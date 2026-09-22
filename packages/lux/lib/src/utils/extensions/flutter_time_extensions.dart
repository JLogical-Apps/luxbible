import 'package:flutter/material.dart';
import 'package:lux/src/models/time.dart';

extension FlutterTimeExtensions on Time {
  TimeOfDay get timeOfDay => TimeOfDay(hour: hour, minute: minute);
}

extension TimeOfDayExtensions on TimeOfDay {
  Time get time => Time(hour: hour, minute: minute);
}
