// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bible_plan_local_notification_schedules_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(biblePlanLocalNotifications)
final biblePlanLocalNotificationsProvider =
    BiblePlanLocalNotificationsProvider._();

final class BiblePlanLocalNotificationsProvider
    extends
        $FunctionalProvider<
          List<LocalNotification>,
          List<LocalNotification>,
          List<LocalNotification>
        >
    with $Provider<List<LocalNotification>> {
  BiblePlanLocalNotificationsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'biblePlanLocalNotificationsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$biblePlanLocalNotificationsHash();

  @$internal
  @override
  $ProviderElement<List<LocalNotification>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<LocalNotification> create(Ref ref) {
    return biblePlanLocalNotifications(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<LocalNotification> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<LocalNotification>>(value),
    );
  }
}

String _$biblePlanLocalNotificationsHash() =>
    r'eb9e9d3f0068332323db54f3426e0ef5bc1fd3e0';
