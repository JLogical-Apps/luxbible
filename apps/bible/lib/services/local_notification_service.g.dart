// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_notification_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(localNotificationService)
final localNotificationServiceProvider = LocalNotificationServiceProvider._();

final class LocalNotificationServiceProvider
    extends
        $FunctionalProvider<
          LocalNotificationService,
          LocalNotificationService,
          LocalNotificationService
        >
    with $Provider<LocalNotificationService> {
  LocalNotificationServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localNotificationServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localNotificationServiceHash();

  @$internal
  @override
  $ProviderElement<LocalNotificationService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LocalNotificationService create(Ref ref) {
    return localNotificationService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocalNotificationService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocalNotificationService>(value),
    );
  }
}

String _$localNotificationServiceHash() =>
    r'6ec0c66f939d20ffff99f8b619894bdebea8c178';

@ProviderFor(localNotificationAvailability)
final localNotificationAvailabilityProvider =
    LocalNotificationAvailabilityFamily._();

final class LocalNotificationAvailabilityProvider
    extends
        $FunctionalProvider<
          AsyncValue<LocalNotificationAvailability>,
          LocalNotificationAvailability,
          FutureOr<LocalNotificationAvailability>
        >
    with
        $FutureModifier<LocalNotificationAvailability>,
        $FutureProvider<LocalNotificationAvailability> {
  LocalNotificationAvailabilityProvider._({
    required LocalNotificationAvailabilityFamily super.from,
    required String? super.argument,
  }) : super(
         retry: null,
         name: r'localNotificationAvailabilityProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$localNotificationAvailabilityHash();

  @override
  String toString() {
    return r'localNotificationAvailabilityProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<LocalNotificationAvailability> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<LocalNotificationAvailability> create(Ref ref) {
    final argument = this.argument as String?;
    return localNotificationAvailability(ref, androidChannelId: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is LocalNotificationAvailabilityProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$localNotificationAvailabilityHash() =>
    r'c5e4367711a436b022cc56068ea6b6a918b9866b';

final class LocalNotificationAvailabilityFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<LocalNotificationAvailability>,
          String?
        > {
  LocalNotificationAvailabilityFamily._()
    : super(
        retry: null,
        name: r'localNotificationAvailabilityProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  LocalNotificationAvailabilityProvider call({String? androidChannelId}) =>
      LocalNotificationAvailabilityProvider._(
        argument: androidChannelId,
        from: this,
      );

  @override
  String toString() => r'localNotificationAvailabilityProvider';
}
