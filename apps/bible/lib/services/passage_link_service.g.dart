// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'passage_link_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(passageLinkService)
final passageLinkServiceProvider = PassageLinkServiceProvider._();

final class PassageLinkServiceProvider
    extends
        $FunctionalProvider<
          PassageLinkService,
          PassageLinkService,
          PassageLinkService
        >
    with $Provider<PassageLinkService> {
  PassageLinkServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'passageLinkServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$passageLinkServiceHash();

  @$internal
  @override
  $ProviderElement<PassageLinkService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PassageLinkService create(Ref ref) {
    return passageLinkService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PassageLinkService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PassageLinkService>(value),
    );
  }
}

String _$passageLinkServiceHash() =>
    r'76114277ac3d604ff9251fd3c8244e5a32244a58';
