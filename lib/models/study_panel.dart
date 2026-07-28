import 'package:bible/models/bible/bible.dart';
import 'package:bible/models/bible/bible_translation.dart';
import 'package:bible/models/commentary_type.dart';
import 'package:bible/models/reference/verse_selection.dart';
import 'package:bible/models/study_action.dart';
import 'package:bible/models/user/user.dart';
import 'package:bible/providers/bibles_provider.dart';
import 'package:bible/style/style.dart';
import 'package:bible/ui/sheets/commentary_sheet.dart';
import 'package:bible/ui/sheets/compare_sheet.dart';
import 'package:bible/ui/sheets/interlinear_sheet.dart';
import 'package:bible/ui/widgets/colored_circle.dart';
import 'package:bible/ui/widgets/interlinear_word_tile.dart';
import 'package:bible/utils/extensions/flutter_string_extensions.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

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
    CompareStudyPanel(:final translation) => 'Compare with ${translation.title()}',
    InterlinearStudyPanel(:final direction) => '${direction.title()} Interlinear',
    CommentaryStudyPanel(:final type) => '${type.title()} Commentary',
    NotesStudyPanel() => 'Notes',
    _ => studyAction?.title() ?? '',
  };

  List<Widget> buildSheetChildren(
    BuildContext context,
    WidgetRef ref, {
    required VerseSelection verseSelection,
    required Function(VerseSelection) onNavigateToVerseSelection,
    required User user,
    required Bible studyBible,
  }) => switch (this) {
    CompareStudyPanel(:final translation) => CompareSheet.buildSheetChildren(
      context,
      verseSelection: verseSelection,
      user: user,
      translation: translation,
    ),
    InterlinearStudyPanel(:final direction) => InterlinearSheet.buildSheetChildren(
      context,
      verseSelection: verseSelection,
      onNavigateToVerseSelection: onNavigateToVerseSelection,
      user: user,
      studyBible: studyBible,
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
                child: StyledBanner(message: 'No Notes Found'.toText()),
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

  String title() => studyAction?.title() ?? 'Notes';
  String description() =>
      studyAction?.description(regionFormat: null, regionType: .visibleVerses) ?? 'View your notes in visible verses.';
  IconData get icon => studyAction?.icon ?? Symbols.note_stack;
}
