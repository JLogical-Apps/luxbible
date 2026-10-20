import 'package:bible/models/annotation.dart';
import 'package:bible/models/color_enum.dart';
import 'package:bible/models/highlight_style.dart';
import 'package:bible/models/notebook.dart';
import 'package:bible/models/user/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:uuid/uuid.dart';

part 'notebook_file.freezed.dart';

class NotebookFile {
  final String? id;
  final String name;
  final ColorEnum color;
  final List<(HighlightStyle, String label)> highlightStyles;
  final List<Annotation> annotations;

  const NotebookFile({
    required this.id,
    required this.name,
    required this.color,
    required this.highlightStyles,
    required this.annotations,
  });

  factory NotebookFile.fromUser(User user, {required Notebook? notebook}) {
    final annotations = user.getNotebookAnnotations(notebook?.id);
    return NotebookFile(
      id: notebook?.id,
      name: notebook?.name ?? t.common.defaultLabel,
      color: notebook?.color ?? .stone,
      highlightStyles: user.highlightStyles
          .where((entry) => annotations.any((annotation) => annotation.style == entry.$1))
          .toList(),
      annotations: annotations,
    );
  }

  // Imported annotations count as created when they're imported, so they don't carry a time.
  factory NotebookFile.fromJson(Map<String, dynamic> json) {
    final importedAt = DateTime.now();
    return NotebookFile(
      id: json['id'] as String?,
      name: json['name'] as String,
      color: ColorEnum.values.byName(json['color'] as String? ?? ColorEnum.stone.name),
      highlightStyles: (json['highlightStyles'] as List<dynamic>? ?? [])
          .cast<Map<String, dynamic>>()
          .map((styleJson) => (HighlightStyle.fromJson(styleJson), styleJson['label'] as String))
          .toList(),
      annotations: (json['annotations'] as List<dynamic>)
          .cast<Map<String, dynamic>>()
          .map(
            (annotationJson) => Annotation(
              selection: getSelection(annotationJson),
              style: HighlightStyle.fromJson(annotationJson['style'] as Map<String, dynamic>),
              note: annotationJson['note'] as String? ?? '',
              createdAt: importedAt,
            ),
          )
          .toList(),
    );
  }

  static AnnotationSelection getSelection(Map<String, dynamic> annotationJson) =>
      switch ((annotationJson['passage'], annotationJson['text'])) {
        (String passage, null) => .verses(verseSelection: VerseSelection.fromJson(passage)),
        (null, Map<String, dynamic> text) => .text(textSelection: BibleTextSelection.fromJson(text)),
        _ => throw FormatException('An annotation needs exactly one of "passage" or "text".'),
      };

  static Map<String, dynamic> getSelectionJson(AnnotationSelection selection) => switch (selection) {
    VersesAnnotationSelection(:final verseSelection) => {'passage': verseSelection.toJson()},
    TextAnnotationSelection(:final textSelection) => {'text': textSelection.toJson()},
  };

  bool get isValid =>
      name.trim().isNotEmpty &&
      annotations.every(
        (annotation) => switch (annotation.selection) {
          VersesAnnotationSelection(:final verseSelection) =>
            verseSelection.isNotEmpty && VerseSelection.isOsisId(verseSelection.osisId()),
          TextAnnotationSelection(:final textSelection) =>
            textSelection.start <= textSelection.end &&
                VerseSelection.isOsisId(textSelection.toVerseSelection().osisId()),
        },
      );

  Map<String, dynamic> toJson() => {
    'id': ?id,
    'name': name,
    'color': color.name,
    'highlightStyles': highlightStyles
        .map((entry) => {...entry.$1.toJson().withoutNullValues, 'label': entry.$2})
        .toList(),
    'annotations': annotations
        .map(
          (annotation) => {
            ...getSelectionJson(annotation.selection),
            'style': annotation.style.toJson().withoutNullValues,
            if (annotation.note.isNotEmpty) 'note': annotation.note,
          },
        )
        .toList(),
  };

  // Keeping the file's ID lets a later export of the same notebook find it again.
  Notebook toNewNotebook(User user) => Notebook(
    id: switch (id) {
      final id? when user.getNotebookById(id) == null => id,
      _ => Uuid().v4(),
    },
    name: name,
    color: color,
  );
}

@freezed
sealed class NotebookImportTarget with _$NotebookImportTarget {
  const factory NotebookImportTarget.newNotebook(Notebook notebook) = NewNotebookImportTarget;
  const factory NotebookImportTarget.existing(String? notebookId) = ExistingNotebookImportTarget;
}

class NotebookImport {
  final NotebookImportTarget target;
  final List<(HighlightStyle, String label)> highlightStyles;
  final List<Annotation> annotations;

  const NotebookImport({required this.target, required this.highlightStyles, required this.annotations});

  factory NotebookImport.of(NotebookFile file, {required NotebookImportTarget target, required User user}) {
    final notebookId = switch (target) {
      NewNotebookImportTarget(:final notebook) => notebook.id,
      ExistingNotebookImportTarget(:final notebookId) => notebookId,
    };

    final seenContentKeys = user.annotations.map((annotation) => annotation.contentKey).toSet();
    final annotations = file.annotations
        .where((annotation) => seenContentKeys.add(annotation.contentKey))
        .map((annotation) => annotation.copyWith(notebookId: notebookId))
        .toList();

    final seenStyles = user.highlightStyles.map((entry) => entry.$1).toSet();
    final highlightStyles = file.highlightStyles
        .where((entry) => annotations.any((annotation) => annotation.style == entry.$1))
        .where((entry) => seenStyles.add(entry.$1))
        .toList();

    return NotebookImport(target: target, highlightStyles: highlightStyles, annotations: annotations);
  }

  int get changeCount => (target is NewNotebookImportTarget ? 1 : 0) + highlightStyles.length + annotations.length;
}
