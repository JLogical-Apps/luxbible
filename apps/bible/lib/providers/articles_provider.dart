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
