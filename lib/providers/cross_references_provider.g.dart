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
          Map<Reference, List<VerseSpanReference>>,
          Map<Reference, List<VerseSpanReference>>,
          Map<Reference, List<VerseSpanReference>>
        >
    with $Provider<Map<Reference, List<VerseSpanReference>>> {
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
  $ProviderElement<Map<Reference, List<VerseSpanReference>>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  Map<Reference, List<VerseSpanReference>> create(Ref ref) {
    return crossReferences(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<Reference, List<VerseSpanReference>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<Map<Reference, List<VerseSpanReference>>>(value),
    );
  }
}

String _$crossReferencesHash() => r'534733eaf3c6b1e8da9cf1157bf020c6f6ab4aea';
