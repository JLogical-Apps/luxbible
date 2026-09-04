import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:timezone/data/latest_all.dart' as timezone_data;
import 'package:timezone/timezone.dart' as timezone;

part 'timezone_service.g.dart';

class TimezoneService {
  Future<void> initialize() async {
    timezone_data.initializeTimeZones();
    await updateLocalTimezone();
  }

  Future<void> updateLocalTimezone() async {
    final deviceTimezone = await FlutterTimezone.getLocalTimezone();
    timezone.setLocalLocation(timezone.getLocation(deviceTimezone.identifier));
  }
}

@Riverpod(keepAlive: true)
TimezoneService timezoneService(Ref ref) => throw UnimplementedError();
