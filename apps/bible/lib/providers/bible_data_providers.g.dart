// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bible_data_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(localBook)
final localBookProvider = LocalBookFamily._();

final class LocalBookProvider
    extends $FunctionalProvider<AsyncValue<Book>, Book, FutureOr<Book>>
    with $FutureModifier<Book>, $FutureProvider<Book> {
  LocalBookProvider._({
    required LocalBookFamily super.from,
    required ({BibleTranslation translation, BookType book}) super.argument,
  }) : super(
         retry: null,
         name: r'localBookProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$localBookHash();

  @override
  String toString() {
    return r'localBookProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<Book> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Book> create(Ref ref) {
    final argument =
        this.argument as ({BibleTranslation translation, BookType book});
    return localBook(
      ref,
      translation: argument.translation,
      book: argument.book,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is LocalBookProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$localBookHash() => r'1d0087c39e4783be0c13e129dd938a9c222c7783';

final class LocalBookFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<Book>,
          ({BibleTranslation translation, BookType book})
        > {
  LocalBookFamily._()
    : super(
        retry: null,
        name: r'localBookProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  LocalBookProvider call({
    required BibleTranslation translation,
    required BookType book,
  }) => LocalBookProvider._(
    argument: (translation: translation, book: book),
    from: this,
  );

  @override
  String toString() => r'localBookProvider';
}
