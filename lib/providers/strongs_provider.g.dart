// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'strongs_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(strongs)
const strongsProvider = StrongsProvider._();

final class StrongsProvider
    extends
        $FunctionalProvider<
          Map<String, Strong>,
          Map<String, Strong>,
          Map<String, Strong>
        >
    with $Provider<Map<String, Strong>> {
  const StrongsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'strongsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$strongsHash();

  @$internal
  @override
  $ProviderElement<Map<String, Strong>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  Map<String, Strong> create(Ref ref) {
    return strongs(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<String, Strong> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<String, Strong>>(value),
    );
  }
}

String _$strongsHash() => r'fdeaed10bcf0b318d27f0f3516bd4af4d8e93256';
