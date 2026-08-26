import 'package:bible/models/commentary_type.dart';
import 'package:bible/models/study_action.dart';
import 'package:bible/models/user/user.dart';
import 'package:bible/providers/app_bible_provider.dart';
import 'package:bible/ui/sheets/commentary_sheet.dart';
import 'package:bible/ui/sheets/compare_sheet.dart';
import 'package:bible/ui/sheets/interlinear_sheet.dart';
import 'package:bible/ui/widgets/interlinear_word_tile.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:style/style.dart';

part 'study_panel.freezed.dart';
part 'study_panel.g.dart';

@freezed
sealed class StudyPanel with _$StudyPanel {
  const StudyPanel._();

  const factory StudyPanel.compare({required BibleTranslation translation}) = CompareStudyPanel;
  const factory StudyPanel.interlinear({required InterlinearDirection direction}) = InterlinearStudyPanel;
  const factory StudyPanel.commentary({required CommentaryType type}) = CommentaryStudyPanel;
  const factory StudyPanel.crossReferences() = CrossReferencesStudyPanel;
  const factory StudyPanel.notes() = NotesStudyPanel;

  factory StudyPanel.fromJson(Map<String, dynamic> json) => _$StudyPanelFromJson(json);

  StudyAction? get studyAction => switch (this) {
    CompareStudyPanel() => .compare,
    InterlinearStudyPanel() => .interlinear,
    CommentaryStudyPanel() => .commentary,
    CrossReferencesStudyPanel() => .crossReferences,
    _ => null,
  };

  String title() => switch (this) {
    CompareStudyPanel(:final translation) => t.studyPanels.compareWith(translation: translation.title()),
    InterlinearStudyPanel(:final direction) => t.studyPanels.directionInterlinear(direction: direction.title()),
    CommentaryStudyPanel(:final type) => t.studyPanels.commentaryName(commentary: type.title()),
    NotesStudyPanel() => t.studyPanels.notes,
    _ => studyAction?.title() ?? '',
  };

  List<Widget> buildSheetChildren(
    BuildContext context,
    WidgetRef ref, {
    required VerseSelection verseSelection,
    required Function(VerseSelection) onNavigateToVerseSelection,
    required User user,
  }) => switch (this) {
    CompareStudyPanel(:final translation) => CompareSheet.buildSheetChildren(
      context,
      verseSelection: verseSelection,
      user: user,
      translation: translation,
    ),
    InterlinearStudyPanel(:final direction) => InterlinearSheet.buildSheetChildren(
      context,
      ref,
      verseSelection: verseSelection,
      onNavigateToVerseSelection: onNavigateToVerseSelection,
      user: user,
      direction: direction,
      showDirectionBanner: false,
      popOnAction: false,
    ),
    CommentaryStudyPanel(:final type) => CommentarySheet.buildSheetChildren(
      context,
      ref,
      verseSelection: verseSelection,
      commentaryType: type,
      onNavigateToVerseSelection: onNavigateToVerseSelection,
    ),
    NotesStudyPanel() => () {
      final noteAnnotations = [
        ...user.getVerseSelectionAnnotations(verseSelection),
        ...user
            .getTextSelectionAnnotationsInVerseSelection(verseSelection, translation: user.translation)
            .map((record) => record.$1),
      ].where((annotation) => annotation.note.isNotEmpty).sortedBy((a) => a.selection);

      return noteAnnotations.isEmpty
          ? [
              Padding(
                padding: .all(16),
                child: StyledBanner(message: t.studyPanels.noNotes.toText()),
              ),
            ]
          : noteAnnotations
                .map(
                  (annotation) => Consumer(
                    key: ValueKey(annotation),
                    builder: (context, ref, child) {
                      final annotationText = ref
                          .watch(
                            annotationSelectionTextProvider(
                              translation: user.translation,
                              selection: annotation.selection,
                            ),
                          )
                          .value;
                      return StyledListItem(
                        leading: ColoredCircle(color: annotation.color.toHue(context.colors).primary),
                        title: annotation.note.toText(),
                        subtitle: StyledLoading(
                          child: annotationText == null ? null : Text(annotationText, maxLines: 1, overflow: .ellipsis),
                        ),
                      );
                    },
                  ),
                )
                .toList();
    }(),
    _ => studyAction!.buildSheetChildren(
      context,
      verseSelection: verseSelection,
      onNavigateToVerseSelection: onNavigateToVerseSelection,
      user: user,
      popOnAction: false,
    ),
  };
}

enum StudyPanelType {
  compare,
  interlinear,
  commentary,
  crossReferences,
  notes;

  StudyAction? get studyAction => switch (this) {
    compare => .compare,
    interlinear => .interlinear,
    commentary => .commentary,
    crossReferences => .crossReferences,
    _ => null,
  };

  String title() => studyAction?.title() ?? t.studyPanels.notes;
  String description() =>
      studyAction?.description(regionFormat: null, regionType: .visibleVerses) ?? t.studyPanels.notesDescription;
  IconData get icon => studyAction?.icon ?? Symbols.note_stack;
}
