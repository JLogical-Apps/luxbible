import 'package:bible/models/annotation.dart';
import 'package:bible/models/user/user.dart';
import 'package:bible/providers/app_bible_provider.dart';
import 'package:bible/providers/root_ref.dart';
import 'package:bible/ui/sheets/annotation_sheet.dart';
import 'package:bible/ui/sheets/preview_passage_sheet.dart';
import 'package:bible/ui/widgets/font_size_spacing_zoom_gesture.dart';
import 'package:bible/ui/widgets/highlight_underline.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';
import 'package:utils_core/utils_core.dart';

class BibleReaderConfiguration {
  static LuxReaderConfiguration build(User user) => LuxReaderConfiguration(
    translationForChapter: (reference) => user.getTranslationFor(reference.book),
    selectedTranslation: user.translation,
    fallbackTranslation: user.studyTranslation,
    onSwitchToFallback: () => ref.updateUser((user) => user.withTranslation(user.studyTranslation)),
    selection: PassageSelectionConfiguration(
      referencesAfterPress: (references, pressedReference) => references.withPressedReference(
        pressedReference: pressedReference,
        rangeSelection: user.verseSelection.rangeSelection,
        expandReferences: user.verseSelection.expandToAnnotation ? user.getExpandedReferences : null,
      ),
      textSelectionAfterUpdate: (selection, isNewSelection) =>
          isNewSelection && user.textSelection.expandToAnnotation && selection != null
          ? user.getExpandedTextSelection(selection)
          : selection,
      onLongPress:
          (context, verseSelection, textSelection, selection, onNavigateToVerseSelection, clearVerses, clearText) {
            if (verseSelection != null && selection.isInVerseSelection(verseSelection)) {
              user.verseSelection.longPressShortcut.onPressed(
                context,
                verseSelection: verseSelection,
                onDeselect: clearVerses,
                onNavigateToVerseSelection: onNavigateToVerseSelection,
              );
              return false;
            }
            if (textSelection != null && textSelection.intersects(selection)) {
              user.textSelection.longPressShortcut.onPressed(
                context,
                textSelection: textSelection,
                onDeselect: clearText,
                onNavigateToVerseSelection: onNavigateToVerseSelection,
              );
              return false;
            }
            return true;
          },
    ),
    paragraphsConfiguration: (context, translation) => BibleParagraphsConfiguration(
      fontFamily: user.themeLayout.font.fontFamily,
      sizeMultiplier:
          BibleTextStyle.baseMultiplier *
          user.themeLayout.getFontSizeSpacingFor(translation.bibleLanguage, context.textScaling).multiplier,
      useParagraphs: user.themeLayout.paragraphs,
      showVerseNumbers: user.themeLayout.verseNumbers,
      showRedLetters: user.themeLayout.redLetters,
      showSection: (type) => user.themeLayout.sections.showFor(translation: translation, sectionType: type),
    ),
    decorationsBuilder: (context, chapterReference, translation) => [
      ...user.visibleAnnotations
          .where((annotation) => annotation.verseSelection != null)
          .map(
            (annotation) => BibleVerseDecoration(
              key: annotation,
              selection: annotation.verseSelection!,
              builder: (context, isDimmed) => buildAnnotationChild(
                context,
                annotation: annotation,
                isDimmed: isDimmed,
                sizeMultiplier:
                    BibleTextStyle.baseMultiplier *
                    user.themeLayout.getFontSizeSpacingFor(translation.bibleLanguage, context.textScaling).multiplier,
              ),
            ),
          ),
      ...user
          .getTextSelectionAnnotationsInVerseSelection(chapterReference.toVerseSelection(), translation: translation)
          .map(
            (record) => BibleTextDecoration(
              key: record.$1,
              selection: record.$2,
              builder: (context, isDimmed) => buildAnnotationChild(
                context,
                annotation: record.$1,
                isDimmed: isDimmed,
                sizeMultiplier:
                    BibleTextStyle.baseMultiplier *
                    user.themeLayout.getFontSizeSpacingFor(translation.bibleLanguage, context.textScaling).multiplier,
              ),
            ),
          ),
    ],
    markersBuilder: (context, translation, reference, verse, verseParagraphOffset, onNavigate) {
      final leadingAnnotations = user
          .getVerseSelectionAnnotations(VerseSelection.reference(reference))
          .where(
            (annotation) =>
                annotation.note.isNotEmpty && annotation.verseSelection?.references.firstOrNull == reference,
          )
          .toList();

      return [
        if (leadingAnnotations.isNotEmpty)
          BibleInlineMarker.leading(
            builder: (context) => buildNotesButton(context, annotations: leadingAnnotations, translation: translation),
          ),
        ...user
            .getTextSelectionAnnotationsWithNotesByOffset(reference: reference, translation: translation)
            .where((offset, annotations) => offset >= verseParagraphOffset)
            .mapToIterable(
              (offset, annotations) => BibleInlineMarker(
                offset: offset - verseParagraphOffset,
                anchorOffset: offset,
                isBoundInSelection: true,
                builder: (context) => buildNotesButton(context, annotations: annotations, translation: translation),
              ),
            ),
        if (user.themeLayout.footnotes)
          ...(verse.footnotes ?? [])
              .groupListsBy((footnote) => footnote.offset.clamp(0, verse.text.length))
              .mapToIterable(
                (offset, footnotes) => BibleInlineMarker(
                  offset: offset,
                  anchorOffset: verseParagraphOffset + offset,
                  builder: (context) =>
                      buildFootnotesButton(context, footnotes: footnotes, onNavigateToVerseSelection: onNavigate),
                ),
              ),
      ];
    },
    chapterWrapper: (context, translation, child) =>
        FontSizeSpacingZoomGesture(language: translation.bibleLanguage, child: child),
  );

  static Widget buildAnnotationChild(
    BuildContext context, {
    required Annotation annotation,
    required bool isDimmed,
    required double sizeMultiplier,
  }) {
    final color = annotation.color.toHue(context.colors).primary;
    return annotation.style.type == .highlight
        ? AnimatedContainer(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOutCubic,
            decoration: BoxDecoration(
              borderRadius: .circular(4),
              color: color.withValues(alpha: isDimmed ? 0.2 : 0.5),
            ),
          )
        : HighlightUnderline(
            color: color.withValues(alpha: isDimmed ? 0.35 : 0.9),
            wavy: annotation.style.type == .wavyUnderline,
            thickness: 4 * sizeMultiplier,
          );
  }

  static Widget buildNotesButton(
    BuildContext context, {
    required List<Annotation> annotations,
    required BibleTranslation translation,
  }) => Padding(
    padding: .only(bottom: 4),
    child: StyledCircleButton.sm(
      onPressed: () => context.showStyledSheet(
        (context) => StyledSheet(
          title: t.labels.notes.toText(),
          children: annotations
              .map(
                (annotation) => Consumer(
                  builder: (context, sheetRef, child) {
                    final annotationText = sheetRef
                        .watch(
                          annotationSelectionTextProvider(translation: translation, selection: annotation.selection),
                        )
                        .value;
                    return StyledSwipeable(
                      key: ValueKey(annotation),
                      actions: [
                        .delete(
                          onPressed: () async {
                            final confirmed = await context.showStyledDialog(
                              (context) => StyledDialog.confirmDelete(
                                cancelLabel: t.common.nevermind.toText(),
                                title: t.annotationUi.deleteAnnotation.toText(),
                                body: t.annotationUi.deleteConfirmation.toText(),
                              ),
                            );
                            if (confirmed == true && context.mounted) {
                              context.pop();
                              ref.updateUser((user) => user.withRemovedAnnotation(annotation));
                            }
                          },
                        ),
                      ],
                      child: StyledListItem(
                        title: annotation.note.toText(),
                        subtitle: StyledLoading(
                          child: annotationText == null ? null : Text(annotationText, maxLines: 1, overflow: .ellipsis),
                        ),
                        trailing: StyledCircleButton.md(
                          child: Symbols.more_vert.toIcon(),
                          onPressed: () => context.showStyledSheet(
                            (context) => StyledSheet(
                              title: t.labels.annotation.toText(),
                              children: [
                                StyledListItem(
                                  title: t.common.edit.toText(),
                                  leading: Symbols.edit.toIcon(),
                                  onPressed: () async {
                                    context.pop();
                                    context.pop();
                                    final newAnnotation = await AnnotationSheet.show(
                                      context,
                                      selection: annotation.selection,
                                      annotation: annotation,
                                    );
                                    if (newAnnotation != null) {
                                      ref.updateUser((user) => user.withAnnotationUpdated(annotation, newAnnotation));
                                    }
                                  },
                                ),
                                StyledListItem(
                                  title: t.common.delete.toText(),
                                  leading: Icon(Symbols.delete, color: context.colors.contentCritical),
                                  onPressed: () async {
                                    final confirmed = await context.showStyledDialog(
                                      (context) => StyledDialog.confirmDelete(
                                        cancelLabel: t.common.nevermind.toText(),
                                        title: t.annotationUi.deleteAnnotation.toText(),
                                        body: t.annotationUi.deleteConfirmation.toText(),
                                      ),
                                    );
                                    if (confirmed == true && context.mounted) {
                                      context.pop();
                                      context.pop();
                                      ref.updateUser((user) => user.withRemovedAnnotation(annotation));
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
              .toList(),
        ),
      ),
      child: Icon(Symbols.note_stack, color: context.colors.contentTertiary),
    ),
  );

  static Widget buildFootnotesButton(
    BuildContext context, {
    required List<Footnote> footnotes,
    required Function(VerseSelection)? onNavigateToVerseSelection,
  }) => Padding(
    padding: .only(bottom: 4),
    child: StyledCircleButton.sm(
      onPressed: () => context.showStyledSheet(
        (context) => StyledSheet(
          title: t.labels.footnotes.toText(),
          children: footnotes
              .map(
                (footnote) => StyledListItem(
                  title: MarkdownBuilder(
                    footnote.text,
                    onLinkPressed: (text, link) => PreviewPassageSheet.show(
                      context,
                      verseSelection: VerseSelection.fromOsisId(link),
                      onNavigateToVerseSelection: (selection) {
                        if (onNavigateToVerseSelection != null) {
                          context.pop();
                          onNavigateToVerseSelection(selection);
                        }
                      },
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
      child: Icon(Symbols.article, color: context.colors.contentDisabled),
    ),
  );
}
