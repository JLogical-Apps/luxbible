// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_link_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(appLinkService)
final appLinkServiceProvider = AppLinkServiceProvider._();

final class AppLinkServiceProvider
    extends $FunctionalProvider<AppLinkService, AppLinkService, AppLinkService>
    with $Provider<AppLinkService> {
  AppLinkServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appLinkServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appLinkServiceHash();

  @$internal
  @override
  $ProviderElement<AppLinkService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppLinkService create(Ref ref) {
    return appLinkService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppLinkService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppLinkService>(value),
    );
  }
}

String _$appLinkServiceHash() => r'3a7dd97c91bf88b2c2fc37dd762bd9d062b7fdec';
