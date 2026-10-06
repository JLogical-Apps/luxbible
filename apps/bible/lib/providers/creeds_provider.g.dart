// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creeds_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(creeds)
final creedsProvider = CreedsProvider._();

final class CreedsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Creed>>,
          List<Creed>,
          FutureOr<List<Creed>>
        >
    with $FutureModifier<List<Creed>>, $FutureProvider<List<Creed>> {
  CreedsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'creedsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$creedsHash();

  @$internal
  @override
  $FutureProviderElement<List<Creed>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Creed>> create(Ref ref) {
    return creeds(ref);
  }
}

String _$creedsHash() => r'c33963eb47b4e24b5e2289cd7e0fc39ec488d238';
