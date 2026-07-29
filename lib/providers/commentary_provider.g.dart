// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commentary_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(commentary)
final commentaryProvider = CommentaryFamily._();

final class CommentaryProvider
    extends
        $FunctionalProvider<
          AsyncValue<Commentary>,
          Commentary,
          FutureOr<Commentary>
        >
    with $FutureModifier<Commentary>, $FutureProvider<Commentary> {
  CommentaryProvider._({
    required CommentaryFamily super.from,
    required CommentaryType super.argument,
  }) : super(
         retry: null,
         name: r'commentaryProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$commentaryHash();

  @override
  String toString() {
    return r'commentaryProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Commentary> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Commentary> create(Ref ref) {
    final argument = this.argument as CommentaryType;
    return commentary(ref, type: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is CommentaryProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$commentaryHash() => r'684a8103311907d7562cd734cb1e6b8cc66c23e0';

final class CommentaryFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Commentary>, CommentaryType> {
  CommentaryFamily._()
    : super(
        retry: null,
        name: r'commentaryProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  CommentaryProvider call({required CommentaryType type}) =>
      CommentaryProvider._(argument: type, from: this);

  @override
  String toString() => r'commentaryProvider';
}
