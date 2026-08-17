// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bible_plan_local_notification_schedules_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(biblePlanLocalNotificationSchedules)
final biblePlanLocalNotificationSchedulesProvider =
    BiblePlanLocalNotificationSchedulesProvider._();

final class BiblePlanLocalNotificationSchedulesProvider
    extends
        $FunctionalProvider<
          List<LocalNotificationSchedule>,
          List<LocalNotificationSchedule>,
          List<LocalNotificationSchedule>
        >
    with $Provider<List<LocalNotificationSchedule>> {
  BiblePlanLocalNotificationSchedulesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'biblePlanLocalNotificationSchedulesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$biblePlanLocalNotificationSchedulesHash();

  @$internal
  @override
  $ProviderElement<List<LocalNotificationSchedule>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<LocalNotificationSchedule> create(Ref ref) {
    return biblePlanLocalNotificationSchedules(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<LocalNotificationSchedule> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<LocalNotificationSchedule>>(
        value,
      ),
    );
  }
}

String _$biblePlanLocalNotificationSchedulesHash() =>
    r'77308a2d56cc244c476dabced1c5925ce4a7824f';
