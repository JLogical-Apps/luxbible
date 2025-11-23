import 'package:bible/models/bible.dart';
import 'package:bible/models/bible_translation.dart';
import 'package:bible/models/book_type.dart';
import 'package:bible/models/bookmark.dart';
import 'package:bible/models/chapter_reference.dart';
import 'package:bible/models/color_enum.dart';
import 'package:bible/models/passage.dart';
import 'package:bible/models/passage_note.dart';
import 'package:bible/models/reference.dart';
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
    @Default({}) Map<String, ColorEnum> highlightByKey,
    @Default(ColorEnum.yellow) ColorEnum highlightColor,
    @Default([]) List<Bookmark> bookmarks,
    @Default([]) List<PassageNote> passageNotes,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Bible getBible(List<Bible> bibles) => bibles.firstWhere((bible) => bible.translation == translation);

  bool isPassageHighlighted(Passage passage) => highlightByKey.keys.containsAny(passage.referenceKeys);

  ColorEnum? getPassageHighlight(Passage passage) =>
      highlightByKey.entries.firstWhereOrNull((entry) => passage.referenceKeys.contains(entry.key))?.value;

  Bookmark? getBookmark(ChapterReference reference) =>
      bookmarks.firstWhereOrNull((bookmark) => bookmark.key == reference.toKey());

  List<PassageNote> getReferenceNotes(Reference reference) => passageNotes.where((passageNote) => false).toList();

  User withToggledHighlight({required Passage passage, required ColorEnum color}) => isPassageHighlighted(passage)
      ? withRemovedHighlight(passage: passage)
      : withHighlight(color: color, passage: passage);

  User withRemovedHighlight({required Passage passage}) => copyWith(
    highlightByKey: {...highlightByKey}..removeWhere((key, highlight) => passage.referenceKeys.contains(key)),
  );

  User withHighlight({required Passage passage, required ColorEnum color}) =>
      copyWith(highlightByKey: {...highlightByKey, ...passage.referenceKeys.mapToMap((key) => MapEntry(key, color))});

  User withBookmark(Bookmark bookmark) => copyWith(bookmarks: [...bookmarks, bookmark]);
  User withRemovedBookmark(Bookmark bookmark) => copyWith(bookmarks: bookmarks.withRemoved(bookmark));

  User withPassageNote(PassageNote note) => copyWith(passageNotes: [...passageNotes, note]);
}
