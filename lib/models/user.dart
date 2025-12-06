import 'package:bible/models/annotation.dart';
import 'package:bible/models/bible.dart';
import 'package:bible/models/bible_translation.dart';
import 'package:bible/models/book_type.dart';
import 'package:bible/models/bookmark.dart';
import 'package:bible/models/color_enum.dart';
import 'package:bible/models/reference/chapter_reference.dart';
import 'package:bible/models/reference/passage.dart';
import 'package:bible/models/reference/reference.dart';
import 'package:bible/models/reference/selection.dart';
import 'package:bible/utils/extensions/collection_extensions.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
sealed class User with _$User {
  const User._();

  const factory User({
    @Default(BibleTranslation.asv) BibleTranslation translation,
    @Default(ChapterReference(chapterNum: 1, book: BookType.genesis)) ChapterReference lastReference,
    @Default([]) List<ChapterReference> previouslyViewed,
    @Default(ColorEnum.yellow) ColorEnum highlightColor,
    @Default([]) List<Bookmark> bookmarks,
    @Default([]) List<Annotation> annotations,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Bible getBible(List<Bible> bibles) => bibles.firstWhere((bible) => bible.translation == translation);

  Bookmark? getBookmark(ChapterReference reference) =>
      bookmarks.firstWhereOrNull((bookmark) => bookmark.key == reference.osisId());

  List<Annotation> getPassageAnnotations(Passage passage) =>
      annotations.where((annotation) => annotation.passages.any((p) => p.hasAnyOf(passage))).toList();
  bool isPassageAnnotated(Passage passage) => getPassageAnnotations(passage).isNotEmpty;

  List<Annotation> getSelectionAnnotations(Selection selection) => annotations
      .where(
        (annotation) =>
            annotation.selections.any((s) => s.translation == selection.translation && s.intersects(selection)),
      )
      .toList();
  bool isSelectionAnnotated(Selection selection) => getSelectionAnnotations(selection).isNotEmpty;

  List<int> getSelectionAnchors(Reference reference) {
    final anchors = annotations
        .expand((annotation) => annotation.selections)
        .expand(
          (selection) => [
            (selection.start, [selection.start.characterOffset]),
            (selection.end, [selection.end.characterOffset, selection.end.characterOffset + 1]),
          ].where((record) => record.$1.toReference() == reference).expand((record) => record.$2),
        )
        .distinct
        .sortedBy((e) => e)
        .toList();
    if (!anchors.contains(0)) {
      anchors.insert(0, 0);
    }
    return anchors;
  }

  User withBookmark(Bookmark bookmark) => copyWith(bookmarks: [...bookmarks, bookmark]);
  User withRemovedBookmark(Bookmark bookmark) => copyWith(bookmarks: bookmarks.withRemoved(bookmark));

  User withAnnotation(Annotation annotation) => copyWith(annotations: [...annotations, annotation]);
  User withRemovedPassageAnnotations(Passage passage) => copyWith(
    annotations: annotations
        .map(
          (annotation) =>
              annotation.copyWith(passages: annotation.passages.where((p) => !p.hasAnyOf(passage)).toList()),
        )
        .where((annotation) => annotation.isNotEmpty)
        .toList(),
  );
  User withRemovedSelectionAnnotations(Selection selection) => copyWith(
    annotations: annotations
        .map(
          (annotation) =>
              annotation.copyWith(selections: annotation.selections.where((s) => !selection.intersects(s)).toList()),
        )
        .where((annotation) => annotation.isNotEmpty)
        .toList(),
  );
}
