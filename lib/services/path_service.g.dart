// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'path_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(pathService)
final pathServiceProvider = PathServiceProvider._();

final class PathServiceProvider extends $FunctionalProvider<Paths, Paths, Paths>
    with $Provider<Paths> {
  PathServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pathServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pathServiceHash();

  @$internal
  @override
  $ProviderElement<Paths> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Paths create(Ref ref) {
    return pathService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Paths value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Paths>(value),
    );
  }
}

String _$pathServiceHash() => r'5bd5762484a9febc71c9b7038f2c013e6247c80a';
