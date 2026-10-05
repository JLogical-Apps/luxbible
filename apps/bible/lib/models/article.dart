import 'package:bible/models/linked_resource.dart';
import 'package:bible/models/rich_content.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lux/lux_core.dart';

part 'article.freezed.dart';
part 'article.g.dart';

@freezed
sealed class Article with _$Article, LinkedResource {
  Article._();

  static const dictionaryLinkPrefix = 'dictionary:';

  factory Article({
    @JsonKey(name: 'i') required String id,
    @JsonKey(name: 't') required String title,
    @JsonKey(name: 'b') required List<RichContent> body,
    @IgnoreIfEmpty(name: 'p') @Default([]) List<VerseSelection> passages,
    @IgnoreIfEmpty(name: 'd') @Default([]) List<String> dictionaryIds,
  }) = _Article;

  factory Article.fromJson(Map<String, dynamic> json) => _$ArticleFromJson(json);

  // Some dictionary entries start with a numbered list, such as one item per person with the same name.
  Markdown? get preview {
    final paragraphs = body.whereType<RichParagraph>();
    return (paragraphs.firstWhereOrNull((paragraph) => paragraph.style == .body) ??
            paragraphs.firstWhereOrNull((paragraph) => paragraph.style != .heading && paragraph.style != .subheading))
        ?.text;
  }

  @override
  late final List<VerseSelection> scriptureLinks = body
      .expand((content) => content.texts)
      .expand((text) => text.linkTargets)
      .whereNot((link) => link.startsWith(dictionaryLinkPrefix))
      .map(VerseSelection.fromOsisId)
      .toList();

  // Dictionary titles qualify repeated names, as in "Abel (Person)" and "Abel (Place)".
  bool isTitled(String name) =>
      title.replaceFirst(RegExp(r'\s*\(.*\)$'), '').toUpperCase() == name.trim().toUpperCase();
}
