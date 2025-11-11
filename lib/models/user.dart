import 'package:bible/models/bible.dart';
import 'package:bible/models/bible_translation.dart';
import 'package:bible/models/chapter_reference.dart';
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
  }) = _User;

  Bible getBible(List<Bible> bibles) =>
      bibles.firstWhere((bible) => bible.translation == translation);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
