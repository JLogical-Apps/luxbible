import 'package:bible/models/rich_content.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bible_plan_study_note.freezed.dart';
part 'bible_plan_study_note.g.dart';

@freezed
sealed class BiblePlanStudyNote with _$BiblePlanStudyNote {
  const factory BiblePlanStudyNote({
    @JsonKey(name: 't') required String title,
    @JsonKey(name: 'b') required List<RichContent> body,
  }) = _BiblePlanStudyNote;

  factory BiblePlanStudyNote.fromJson(Map<String, dynamic> json) => _$BiblePlanStudyNoteFromJson(json);
}
