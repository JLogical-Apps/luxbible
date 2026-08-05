// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cross_references_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(crossReferences)
final crossReferencesProvider = CrossReferencesProvider._();

final class CrossReferencesProvider extends $FunctionalProvider<CrossReferences, CrossReferences, CrossReferences>
    with $Provider<CrossReferences> {
  CrossReferencesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'crossReferencesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$crossReferencesHash();

  @$internal
  @override
  $ProviderElement<CrossReferences> $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  CrossReferences create(Ref ref) {
    return crossReferences(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CrossReferences value) {
    return $ProviderOverride(origin: this, providerOverride: $SyncValueProvider<CrossReferences>(value));
  }
}

String _$crossReferencesHash() => r'1fc18e429e03fc0541e0af7b3c3b2fc1be522247';
