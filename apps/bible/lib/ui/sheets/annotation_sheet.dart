import 'package:bible/models/annotation.dart';
import 'package:bible/models/highlight_style.dart';
import 'package:bible/providers/app_bible_provider.dart';
import 'package:bible/providers/root_ref.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/ui/pages/notebook_icon.dart';
import 'package:bible/ui/sheets/highlight_style_sheet.dart';
import 'package:bible/ui/sheets/notebook_sheet.dart';
import 'package:bible/ui/widgets/highlight_style_icon.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:flutter/material.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:port/port.dart';
import 'package:style/style.dart';

class AnnotationSheet {
  static Future<Annotation?> show(
    BuildContext context, {
    Widget? subtitle,
    Annotation? annotation,
    required AnnotationSelection selection,
    Function(BuildContext)? onRemove,
  }) {
    final user = ref.read(userProvider);
    final initialNotebookId = annotation != null
        ? annotation.notebookId
        : user.getNotebookById(user.lastNotebookId)?.id;
    final initialStyle = annotation?.style ?? user.defaultAnnotationStyle;

    final port =
        Port.of({
          'style': SimplePortField<HighlightStyle>(value: initialStyle),
          'note': PortField.string(initialValue: annotation?.note),
          'notebookId': SimplePortField<String?>(value: initialNotebookId),
        }).map(
          (values, port) => Annotation(
            createdAt: annotation?.createdAt ?? .now(),
            selection: selection,
            style: values['style'],
            note: (values['note'] as String).trim(),
            notebookId: values['notebookId'],
          ),
        );

    return context.showStyledSheet(
      (context, ref) => StyledPortSheet(
        title: (annotation == null ? t.annotationUi.annotate : t.labels.annotation).toText(),
        subtitle: subtitle,
        bodyPadding: .only(top: 16),
        trailing: onRemove == null
            ? null
            : StyledCircleButton.md(child: Symbols.ink_eraser.toIcon(), onPressed: () => onRemove(context)),
        port: port,
        childrenBuilder: (context, ref) {
          final user = ref.watch(userProvider);
          return [
            if (user.notebooks.isNotEmpty)
              StyledPortFieldBuilder<String?>(
                fieldPath: 'notebookId',
                builder: (context, value, errorText, onChanged) => StyledFormInput(
                  label: t.labels.notebook.toText(),
                  labelPadding: .symmetric(horizontal: 16),
                  error: errorText?.toText(),
                  child: SingleChildScrollView(
                    key: ValueKey(user.notebooks),
                    padding: .symmetric(horizontal: 16),
                    scrollDirection: .horizontal,
                    child: Row(
                      spacing: 8,
                      children: [
                        ...[...user.notebooks, null].map(
                          (notebook) => StyledChip(
                            leading: NotebookIcon(notebook: notebook),
                            child: (notebook?.name ?? t.common.defaultLabel).withLength(12).toText(),
                            isSelected: notebook?.id == value,
                            onPressed: () => onChanged(notebook?.id),
                          ),
                        ),
                        StyledTextButton(
                          child: t.common.addNew.toText(),
                          leading: Symbols.add.toIcon(),
                          onPressed: () async {
                            final newNotebook = await NotebookSheet.show(context);
                            if (newNotebook != null) {
                              ref.updateUser((user) => user.withNewNotebook(newNotebook));
                              port.setValue(path: 'notebookId', value: newNotebook.id);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            StyledPortFieldBuilder<HighlightStyle>(
              fieldPath: 'style',
              builder: (context, value, errorText, onChanged) => StyledFormInput(
                label: t.labels.style.toText(),
                labelPadding: .symmetric(horizontal: 16),
                error: errorText?.toText(),
                child: SingleChildScrollView(
                  key: ValueKey(user.highlightStyles),
                  padding: .symmetric(horizontal: 16),
                  scrollDirection: .horizontal,
                  child: Row(
                    spacing: 8,
                    children: [
                      ...user.highlightStyles.map(
                        (entry) => StyledChip(
                          leading: HighlightStyleIcon(style: entry.$1),
                          child: entry.$2.withLength(12).toText(),
                          isSelected: entry.$1 == value,
                          onPressed: () => onChanged(entry.$1),
                        ),
                      ),
                      StyledTextButton(
                        child: t.common.addNew.toText(),
                        leading: Symbols.add.toIcon(),
                        onPressed: () async {
                          final newStyle = await HighlightStyleSheet.show(context, otherStyles: user.highlightStyles);
                          if (newStyle != null) {
                            ref.updateUser((user) => user.withNewHighlightStyle(newStyle));
                            port.setValue(path: 'style', value: newStyle.$1);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            StyledPortFieldBuilder<String>(
              fieldPath: 'note',
              builder: (context, value, errorText, onChanged) => Padding(
                padding: .symmetric(horizontal: 16),
                child: StyledTextField.multiline(
                  text: value,
                  label: t.labels.note.toText(),
                  error: errorText?.toText(),
                  onChanged: onChanged,
                ),
              ),
            ),
          ];
        },
      ),
    );
  }

  static Future<void> edit(BuildContext context, {required Annotation annotation}) async {
    final newAnnotation = await show(
      context,
      selection: annotation.selection,
      annotation: annotation,
      subtitle: annotation.formatLocation().toText(),
      onRemove: (context) async {
        ref.updateUser((user) => user.withRemovedAnnotation(annotation));
        context.pop();
      },
    );
    if (newAnnotation != null) {
      ref.updateUser((user) => user.withAnnotationUpdated(annotation, newAnnotation));
    }
  }
}

class NewAnnotationSheet {
  static Future<Annotation?> show(
    BuildContext context, {
    required AnnotationSelection selection,
    Function()? onAnnotationsRemoved,
  }) async {
    final user = ref.read(userProvider);
    final selectionText = await ref.read(
      annotationSelectionTextProvider(translation: user.translation, selection: selection).future,
    );

    final hasAnnotation = selection.when(
      verses: (verseSelection) => user.isVerseSelectionAnnotated(verseSelection),
      text: (textSelection) => user.isTextSelectionAnnotated(textSelection),
    );

    if (!context.mounted) return null;

    return AnnotationSheet.show(
      context,
      selection: selection,
      subtitle: selectionText.toText(),
      onRemove: hasAnnotation
          ? (context) async {
              ref.updateUser((user) => user.withRemovedSelectionAnnotations(selection));
              onAnnotationsRemoved?.call();
              context.pop();
            }
          : null,
    );
  }
}
