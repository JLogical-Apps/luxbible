import 'dart:convert';
import 'dart:isolate';

import 'package:bible/models/article.dart';
import 'package:bible/models/article_collection.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'articles_provider.g.dart';

@Riverpod(keepAlive: true)
Future<List<Article>> articles(Ref ref, {required ArticleCollection collection}) async {
  final json = await rootBundle.loadString(collection.assetPath);
  return Isolate.run(() => (jsonDecode(json) as List).map((article) => Article.fromJson(article)).toList());
}

@riverpod
Future<Map<ArticleCollection, List<Article>>> relatedArticles(
  Ref ref, {
  required ArticleCollection collection,
  required Article article,
}) async {
  Future<List<Article>> getArticles(ArticleCollection collection, bool Function(Article) isRelated) async =>
      (await ref.watch(articlesProvider(collection: collection).future)).where(isRelated).toList();

  return switch (collection) {
    .dictionary => {
      .people: await getArticles(.people, (profile) => profile.dictionaryIds.contains(article.id)),
      .themes: await getArticles(.themes, (theme) => theme.dictionaryIds.contains(article.id)),
    },
    // Avoids decoding the whole dictionary for an article that links to none of it.
    _ when article.dictionaryIds.isEmpty => {},
    _ => {.dictionary: await getArticles(.dictionary, (entry) => article.dictionaryIds.contains(entry.id))},
  };
}
