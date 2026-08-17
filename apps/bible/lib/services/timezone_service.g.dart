// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timezone_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(timezoneService)
final timezoneServiceProvider = TimezoneServiceProvider._();

final class TimezoneServiceProvider
    extends
        $FunctionalProvider<TimezoneService, TimezoneService, TimezoneService>
    with $Provider<TimezoneService> {
  TimezoneServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'timezoneServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$timezoneServiceHash();

  @$internal
  @override
  $ProviderElement<TimezoneService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TimezoneService create(Ref ref) {
    return timezoneService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TimezoneService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TimezoneService>(value),
    );
  }
}

String _$timezoneServiceHash() => r'2ab38f361eab51930157854780010b5c4d244fd3';
