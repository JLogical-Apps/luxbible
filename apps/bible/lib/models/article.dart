import 'package:bible/models/commentary.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lux/lux_core.dart';

part 'article.freezed.dart';
part 'article.g.dart';

@freezed
sealed class Article with _$Article {
  const Article._();

  const factory Article({
    @JsonKey(name: 'i') required String id,
    @JsonKey(name: 't') required String title,
    @JsonKey(name: 'b') required List<CommentaryContent> body,
    @JsonKey(name: 'p') required List<VerseSelection> passages,
  }) = _Article;

  factory Article.fromJson(Map<String, dynamic> json) => _$ArticleFromJson(json);

  Markdown? get preview =>
      body.whereType<CommentaryParagraph>().firstWhereOrNull((paragraph) => paragraph.style == .body)?.text;

  int? getNarrowestOverlap(VerseSelection selection) =>
      passages.where((passage) => passage.hasAnyOf(selection)).map((passage) => passage.references.length).minOrNull;
}

extension ArticleListExtensions on List<Article> {
  List<Article> getLinkedTo(VerseSelection selection) =>
      map((article) => (article: article, overlap: article.getNarrowestOverlap(selection)))
          .where((entry) => entry.overlap != null)
          .sorted((a, b) => a.overlap!.compareTo(b.overlap!).nullIfZero ?? a.article.title.compareTo(b.article.title))
          .map((entry) => entry.article)
          .toList();
}
