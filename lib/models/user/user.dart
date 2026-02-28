import 'package:bible/models/annotation.dart';
import 'package:bible/models/bible.dart';
import 'package:bible/models/bible_translation.dart';
import 'package:bible/models/book_type.dart';
import 'package:bible/models/bookmark.dart';
import 'package:bible/models/color_enum.dart';
import 'package:bible/models/reference/chapter_reference.dart';
import 'package:bible/models/reference/passage.dart';
import 'package:bible/models/reference/reference.dart';
import 'package:bible/models/reference/region.dart';
import 'package:bible/models/reference/selection.dart';
import 'package:bible/models/user/passage_configuration.dart';
import 'package:bible/models/user/selection_configuration.dart';
import 'package:bible/models/user/toolbar_configuration.dart';
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
    @Default(ToolbarConfiguration()) ToolbarConfiguration toolbar,
    @Default(PassageConfiguration()) PassageConfiguration passage,
    @Default(SelectionConfiguration()) SelectionConfiguration selection,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Bible getBible(List<Bible> bibles) => bibles.firstWhere((bible) => bible.translation == translation);

  Bookmark? getBookmark(ChapterReference reference) =>
      bookmarks.firstWhereOrNull((bookmark) => bookmark.chapter == reference);

  List<Annotation> getPassageAnnotations(Passage passage) =>
      annotations.where((annotation) => annotation.passages.any((p) => p.hasAnyOf(passage))).toList();
  bool isPassageAnnotated(Passage passage) => getPassageAnnotations(passage).isNotEmpty;

  List<(Annotation, Selection)> getSelectionAnnotationsInPassage(
    Passage passage, {
    required BibleTranslation translation,
  }) => annotations
      .expand(
        (annotation) => annotation.selections
            .where((s) => s.translation == translation && s.isInPassage(passage))
            .map((s) => (annotation, s)),
      )
      .toList();

  List<Annotation> getSelectionAnnotations(Selection selection) => annotations
      .where(
        (annotation) =>
            annotation.selections.any((s) => s.translation == selection.translation && s.intersects(selection)),
      )
      .toList();
  bool isSelectionAnnotated(Selection selection) => getSelectionAnnotations(selection).isNotEmpty;

  Map<int, List<Annotation>> getSelectionAnnotationsWithNotesByOffset({
    required Reference reference,
    required BibleTranslation translation,
  }) => annotations
      .where((annotation) => annotation.note != null)
      .expand(
        (annotation) => annotation.selections
            .where((selection) => selection.translation == translation)
            .where((selection) => selection.start.toReference() == reference)
            .map((selection) => (annotation, selection)),
      )
      .groupListsBy((records) => records.$2.start.characterOffset)
      .map((offset, records) => MapEntry(offset, records.map((record) => record.$1).toList()));

  User withBookmark(Bookmark bookmark) => copyWith(bookmarks: [...bookmarks, bookmark]);
  User withRemovedBookmark(Bookmark bookmark) => copyWith(bookmarks: bookmarks.withRemoved(bookmark));

  User withAnnotation(Annotation annotation) =>
      copyWith(annotations: [...annotations, annotation], highlightColor: annotation.color);

  User withRemovedRegionAnnotations(Region region) => region.when(
    passage: (passage) => withRemovedPassageAnnotations(passage),
    selection: (selection) => withRemovedSelectionAnnotations(selection),
    chapterReference: (reference) => throw UnimplementedError(),
  );

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
  User withRemovedAnnotation(Annotation annotation) => copyWith(annotations: annotations.withRemoved(annotation));
}
