import 'package:bible/services/local_notification_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'local_notification_schedules_provider.g.dart';

@Riverpod(keepAlive: true)
List<LocalNotificationSchedule> localNotificationSchedules(Ref ref) => [];
