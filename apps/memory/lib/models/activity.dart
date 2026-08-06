import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:memory/models/activity_plan.dart';

part 'activity.freezed.dart';
part 'activity.g.dart';

@freezed
sealed class Activity with _$Activity {
  const Activity._();

  const factory Activity.phraseRead({required PhraseReadActivityPlan plan}) = PhraseReadActivity;
  const factory Activity.readContext({required ReadContextActivityPlan plan}) = ReadContextActivity;
  const factory Activity.phraseSelection({required PhraseSelectionActivityPlan plan}) = PhraseSelectionActivity;
  const factory Activity.wordSelection({required WordSelectionActivityPlan plan}) = WordSelectionActivity;
  const factory Activity.wordType({required WordTypeActivityPlan plan}) = WordTypeActivity;
  const factory Activity.referenceSelection({required ReferenceSelectionActivityPlan plan}) =
      ReferenceSelectionActivity;
  const factory Activity.referenceType({required ReferenceTypeActivityPlan plan}) = ReferenceTypeActivity;

  factory Activity.fromJson(Map<String, dynamic> json) => _$ActivityFromJson(json);
}
