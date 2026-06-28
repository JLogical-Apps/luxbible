import 'package:bible/models/bible/bible_translation.dart';
import 'package:bible/models/commentary_type.dart';
import 'package:bible/models/reference/verse_selection.dart';
import 'package:bible/models/study_action.dart';
import 'package:bible/models/user/user.dart';
import 'package:bible/ui/sheets/compare_sheet.dart';
import 'package:bible/ui/sheets/interlinear_sheet.dart';
import 'package:bible/ui/widgets/interlinear_word_tile.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'study_panel.freezed.dart';
part 'study_panel.g.dart';

@freezed
sealed class StudyPanel with _$StudyPanel {
  const StudyPanel._();

  const factory StudyPanel.compare({required BibleTranslation translation}) = CompareStudyPanel;
  const factory StudyPanel.interlinear({required InterlinearDirection direction}) = InterlinearStudyPanel;
  const factory StudyPanel.commentary({required CommentaryType type}) = CommentaryStudyPanel;
  const factory StudyPanel.crossReferences() = CrossReferencesStudyPanel;

  factory StudyPanel.fromJson(Map<String, dynamic> json) => _$StudyPanelFromJson(json);

  StudyAction get studyAction => switch (this) {
    CompareStudyPanel() => .compare,
    InterlinearStudyPanel() => .interlinear,
    CommentaryStudyPanel() => .commentary,
    CrossReferencesStudyPanel() => .crossReferences,
  };

  String title() => switch (this) {
    CompareStudyPanel(:final translation) => 'Compare with ${translation.title()}',
    InterlinearStudyPanel(:final direction) => '${direction.title()} Interlinear',
    _ => studyAction.title(),
  };

  List<Widget> buildSheetChildren(
    BuildContext context, {
    required VerseSelection verseSelection,
    required Function(VerseSelection) onNavigateToVerseSelection,
    required User user,
  }) => switch (this) {
    CompareStudyPanel(:final translation) => CompareSheet.buildSheetChildren(
      context,
      verseSelection: verseSelection,
      onNavigateToVerseSelection: onNavigateToVerseSelection,
      user: user,
      translation: translation,
    ),
    InterlinearStudyPanel(:final direction) => InterlinearSheet.buildSheetChildren(
      context,
      verseSelection: verseSelection,
      onNavigateToVerseSelection: onNavigateToVerseSelection,
      user: user,
      direction: direction,
      showDirectionBanner: false,
    ),
    _ => studyAction.buildSheetChildren(
      context,
      verseSelection: verseSelection,
      onNavigateToVerseSelection: onNavigateToVerseSelection,
      user: user,
    ),
  };
}
