// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commentaries_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(commentaries)
final commentariesProvider = CommentariesProvider._();

final class CommentariesProvider
    extends
        $FunctionalProvider<
          List<Commentary>,
          List<Commentary>,
          List<Commentary>
        >
    with $Provider<List<Commentary>> {
  CommentariesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'commentariesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$commentariesHash();

  @$internal
  @override
  $ProviderElement<List<Commentary>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<Commentary> create(Ref ref) {
    return commentaries(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Commentary> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Commentary>>(value),
    );
  }
}

String _$commentariesHash() => r'3092bd90cfd2a86c3d3147cbf5fb08befd7b3d6d';
