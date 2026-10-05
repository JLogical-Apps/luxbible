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

@ProviderFor(relatedArticles)
final relatedArticlesProvider = RelatedArticlesFamily._();

final class RelatedArticlesProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<ArticleCollection, List<Article>>>,
          Map<ArticleCollection, List<Article>>,
          FutureOr<Map<ArticleCollection, List<Article>>>
        >
    with
        $FutureModifier<Map<ArticleCollection, List<Article>>>,
        $FutureProvider<Map<ArticleCollection, List<Article>>> {
  RelatedArticlesProvider._({
    required RelatedArticlesFamily super.from,
    required ({ArticleCollection collection, Article article}) super.argument,
  }) : super(
         retry: null,
         name: r'relatedArticlesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$relatedArticlesHash();

  @override
  String toString() {
    return r'relatedArticlesProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<Map<ArticleCollection, List<Article>>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Map<ArticleCollection, List<Article>>> create(Ref ref) {
    final argument =
        this.argument as ({ArticleCollection collection, Article article});
    return relatedArticles(
      ref,
      collection: argument.collection,
      article: argument.article,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is RelatedArticlesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$relatedArticlesHash() => r'3a284496b4d230e53005a49daeda2f236d6717d4';

final class RelatedArticlesFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<Map<ArticleCollection, List<Article>>>,
          ({ArticleCollection collection, Article article})
        > {
  RelatedArticlesFamily._()
    : super(
        retry: null,
        name: r'relatedArticlesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  RelatedArticlesProvider call({
    required ArticleCollection collection,
    required Article article,
  }) => RelatedArticlesProvider._(
    argument: (collection: collection, article: article),
    from: this,
  );

  @override
  String toString() => r'relatedArticlesProvider';
}
