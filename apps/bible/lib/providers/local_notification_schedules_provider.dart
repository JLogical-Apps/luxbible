import 'package:bible/providers/bible_plan_local_notification_schedules_provider.dart';
import 'package:bible/providers/verse_of_the_day_local_notification_schedules_provider.dart';
import 'package:bible/services/local_notification_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'local_notification_schedules_provider.g.dart';

@Riverpod(keepAlive: true)
Future<List<LocalNotification>> localNotifications(Ref ref) async => [
  ...ref.watch(biblePlanLocalNotificationsProvider),
  ...await ref.watch(verseOfTheDayLocalNotificationsProvider.future),
];
