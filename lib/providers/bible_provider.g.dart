// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bible_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(bibles)
const biblesProvider = BiblesProvider._();

final class BiblesProvider
    extends $FunctionalProvider<List<Bible>, List<Bible>, List<Bible>>
    with $Provider<List<Bible>> {
  const BiblesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'biblesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$biblesHash();

  @$internal
  @override
  $ProviderElement<List<Bible>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<Bible> create(Ref ref) {
    return bibles(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Bible> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Bible>>(value),
    );
  }
}

String _$biblesHash() => r'd9b5f3b04a77a7a337c9394fc946d2fba0e2f388';
