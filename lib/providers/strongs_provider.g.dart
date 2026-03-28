// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'strongs_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(strongs)
final strongsProvider = StrongsProvider._();

final class StrongsProvider
    extends
        $FunctionalProvider<
          Map<String, Strong>,
          Map<String, Strong>,
          Map<String, Strong>
        >
    with $Provider<Map<String, Strong>> {
  StrongsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'strongsProvider',
        isAutoDispose: false,
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

String _$strongsHash() => r'edb10ae9ae3191aeb638dc6d4cada2f432852e08';
