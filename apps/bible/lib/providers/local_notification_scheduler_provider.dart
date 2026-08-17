import 'package:bible/providers/local_notification_schedules_provider.dart';
import 'package:bible/services/local_notification_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'local_notification_scheduler_provider.g.dart';

@Riverpod(keepAlive: true)
void localNotificationScheduler(Ref ref) {
  ref.listen(
    localNotificationSchedulesProvider,
    (previous, next) => ref.read(localNotificationServiceProvider).synchronize(next),
    fireImmediately: true,
  );
}
