// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cross_references_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(crossReferences)
final crossReferencesProvider = CrossReferencesProvider._();

final class CrossReferencesProvider
    extends
        $FunctionalProvider<
          Map<Reference, Map<VerseSpanReference, int>>,
          Map<Reference, Map<VerseSpanReference, int>>,
          Map<Reference, Map<VerseSpanReference, int>>
        >
    with $Provider<Map<Reference, Map<VerseSpanReference, int>>> {
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
  $ProviderElement<Map<Reference, Map<VerseSpanReference, int>>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  Map<Reference, Map<VerseSpanReference, int>> create(Ref ref) {
    return crossReferences(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(
    Map<Reference, Map<VerseSpanReference, int>> value,
  ) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<Map<Reference, Map<VerseSpanReference, int>>>(
            value,
          ),
    );
  }
}

String _$crossReferencesHash() => r'778f912ac1871d3d50df0f669e0849d4282943e7';
