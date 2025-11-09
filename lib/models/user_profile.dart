import 'package:bible/models/bible.dart';
import 'package:bible/models/bible_translation.dart';
import 'package:bible/models/chapter_reference.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile.freezed.dart';
part 'user_profile.g.dart';

@freezed
sealed class UserProfile with _$UserProfile {
  const UserProfile._();

  const factory UserProfile({
    @Default(BibleTranslation.asv) BibleTranslation translation,
    @Default([]) List<ChapterReference> tabs,
    @Default([]) List<ChapterReference> previouslyViewed,
  }) = _UserProfile;

  Bible getBible(List<Bible> bibles) =>
      bibles.firstWhere((bible) => bible.translation == translation);

  factory UserProfile.fromJson(Map<String, dynamic> json) => _$UserProfileFromJson(json);
}
