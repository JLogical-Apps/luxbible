// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bible_maps_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(bibleMaps)
final bibleMapsProvider = BibleMapsProvider._();

final class BibleMapsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<BibleMap>>,
          List<BibleMap>,
          FutureOr<List<BibleMap>>
        >
    with $FutureModifier<List<BibleMap>>, $FutureProvider<List<BibleMap>> {
  BibleMapsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bibleMapsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bibleMapsHash();

  @$internal
  @override
  $FutureProviderElement<List<BibleMap>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<BibleMap>> create(Ref ref) {
    return bibleMaps(ref);
  }
}

String _$bibleMapsHash() => r'c786c6ec53def8db98c7939b4daf0cecbf20e35c';
