// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_notification_scheduler_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(localNotificationScheduler)
final localNotificationSchedulerProvider =
    LocalNotificationSchedulerProvider._();

final class LocalNotificationSchedulerProvider
    extends $FunctionalProvider<void, void, void>
    with $Provider<void> {
  LocalNotificationSchedulerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localNotificationSchedulerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localNotificationSchedulerHash();

  @$internal
  @override
  $ProviderElement<void> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  void create(Ref ref) {
    return localNotificationScheduler(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$localNotificationSchedulerHash() =>
    r'5a7e2c36675df164501f151d20b2b41e729e7275';
