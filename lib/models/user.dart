import 'package:bible/models/bible.dart';
import 'package:bible/models/bible_translation.dart';
import 'package:bible/models/chapter_reference.dart';
import 'package:bible/models/passage.dart';
import 'package:bible/models/reference.dart';
import 'package:bible/utils/extensions/collection_extensions.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
sealed class User with _$User {
  const User._();

  const factory User({
    @Default(BibleTranslation.asv) BibleTranslation translation,
    @Default([]) List<ChapterReference> tabs,
    @Default([]) List<ChapterReference> previouslyViewed,
    @Default([]) List<Reference> highlightedReferences,
  }) = _User;

  Bible getBible(List<Bible> bibles) =>
      bibles.firstWhere((bible) => bible.translation == translation);

  bool isPassageHighlighted(Passage passage) =>
      highlightedReferences.containsAny(passage.references);

  User withToggledHighlight(Passage passage) => isPassageHighlighted(passage)
      ? copyWith(
          highlightedReferences: highlightedReferences
              .where((ref) => !passage.references.contains(ref))
              .toList(),
        )
      : copyWith(
          highlightedReferences: [
            ...highlightedReferences,
            ...passage.references,
          ].distinct,
        );

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
