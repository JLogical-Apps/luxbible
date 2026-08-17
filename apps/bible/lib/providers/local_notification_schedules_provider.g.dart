// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_notification_schedules_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(localNotificationSchedules)
final localNotificationSchedulesProvider =
    LocalNotificationSchedulesProvider._();

final class LocalNotificationSchedulesProvider
    extends
        $FunctionalProvider<
          List<LocalNotificationSchedule>,
          List<LocalNotificationSchedule>,
          List<LocalNotificationSchedule>
        >
    with $Provider<List<LocalNotificationSchedule>> {
  LocalNotificationSchedulesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localNotificationSchedulesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localNotificationSchedulesHash();

  @$internal
  @override
  $ProviderElement<List<LocalNotificationSchedule>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<LocalNotificationSchedule> create(Ref ref) {
    return localNotificationSchedules(ref);
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

String _$localNotificationSchedulesHash() =>
    r'bae6c8af00bcc0c127175070ebbf0f387c41d515';
