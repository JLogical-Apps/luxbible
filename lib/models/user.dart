import 'package:bible/models/annotation.dart';
import 'package:bible/models/bible.dart';
import 'package:bible/models/bible_translation.dart';
import 'package:bible/models/book_type.dart';
import 'package:bible/models/bookmark.dart';
import 'package:bible/models/color_enum.dart';
import 'package:bible/models/reference/chapter_reference.dart';
import 'package:bible/models/reference/passage.dart';
import 'package:bible/models/reference/selection.dart';
import 'package:bible/utils/extensions/collection_extensions.dart';
import 'package:bible/utils/extensions/object_extensions.dart';
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

  List<Annotation> getReferenceAnnotations(Passage passage) => annotations
      .where((annotation) => annotation.selection.as<PassageSelection>()?.passage.hasAnyOf(passage) ?? false)
      .toList();
  bool isPassageAnnotated(Passage passage) => getReferenceAnnotations(passage).isNotEmpty;

  User withBookmark(Bookmark bookmark) => copyWith(bookmarks: [...bookmarks, bookmark]);
  User withRemovedBookmark(Bookmark bookmark) => copyWith(bookmarks: bookmarks.withRemoved(bookmark));

  User withAnnotation(Annotation annotation) => copyWith(annotations: [...annotations, annotation]);
  User withRemovedPassageAnnotations(Passage passage) => copyWith(
    annotations: annotations
        .map((annotation) {
          final selection = annotation.selection;
          if (selection is PassageSelection) {
            final newSelection = selection.copyWith(passage: selection.passage.withRemovedPassage(passage));
            if (newSelection.passage.isEmpty) {
              return null;
            }
            return annotation.copyWith(selection: newSelection);
          } else {
            return annotation;
          }
        })
        .nonNulls
        .toList(),
  );
}
