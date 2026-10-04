// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'articles_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(articles)
final articlesProvider = ArticlesFamily._();

final class ArticlesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Article>>,
          List<Article>,
          FutureOr<List<Article>>
        >
    with $FutureModifier<List<Article>>, $FutureProvider<List<Article>> {
  ArticlesProvider._({
    required ArticlesFamily super.from,
    required ArticleCollection super.argument,
  }) : super(
         retry: null,
         name: r'articlesProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$articlesHash();

  @override
  String toString() {
    return r'articlesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Article>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Article>> create(Ref ref) {
    final argument = this.argument as ArticleCollection;
    return articles(ref, collection: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ArticlesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$articlesHash() => r'bb9ba5a2827a178ccd849d17e4715c5c16ca6c63';

final class ArticlesFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Article>>, ArticleCollection> {
  ArticlesFamily._()
    : super(
        retry: null,
        name: r'articlesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  ArticlesProvider call({required ArticleCollection collection}) =>
      ArticlesProvider._(argument: collection, from: this);

  @override
  String toString() => r'articlesProvider';
}
