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

String _$creedsHash() => r'dccd3c3b1f829e5ac204e7e648f148e7eee357f9';
