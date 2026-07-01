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
          Map<CommentaryType, Commentary>,
          Map<CommentaryType, Commentary>,
          Map<CommentaryType, Commentary>
        >
    with $Provider<Map<CommentaryType, Commentary>> {
  CommentariesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'commentariesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$commentariesHash();

  @$internal
  @override
  $ProviderElement<Map<CommentaryType, Commentary>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  Map<CommentaryType, Commentary> create(Ref ref) {
    return commentaries(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<CommentaryType, Commentary> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<CommentaryType, Commentary>>(
        value,
      ),
    );
  }
}

String _$commentariesHash() => r'384be5eb1d172fad96dad1e3890c3bb03e107c11';
