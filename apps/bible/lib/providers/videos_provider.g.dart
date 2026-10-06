// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'videos_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(videoCollections)
final videoCollectionsProvider = VideoCollectionsProvider._();

final class VideoCollectionsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<VideoCollection>>,
          List<VideoCollection>,
          FutureOr<List<VideoCollection>>
        >
    with
        $FutureModifier<List<VideoCollection>>,
        $FutureProvider<List<VideoCollection>> {
  VideoCollectionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'videoCollectionsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$videoCollectionsHash();

  @$internal
  @override
  $FutureProviderElement<List<VideoCollection>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<VideoCollection>> create(Ref ref) {
    return videoCollections(ref);
  }
}

String _$videoCollectionsHash() => r'811f5ef933a495343c07e323e9cf5fd604c668ce';
