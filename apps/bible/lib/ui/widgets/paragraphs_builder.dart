import 'package:bible/models/annotation.dart';
import 'package:bible/models/user/user.dart';
import 'package:bible/providers/app_bible_provider.dart';
import 'package:bible/ui/sheets/annotation_sheet.dart';
import 'package:bible/ui/sheets/preview_passage_sheet.dart';
import 'package:bible/ui/widgets/bible_selection.dart';
import 'package:bible/ui/widgets/highlight_underline.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';
import 'package:utils_core/utils_core.dart';

class ParagraphsBuilder extends HookWidget {
  final List<Paragraph> paragraphs;
  final ChapterReference chapterReference;
  final User user;
  final BibleTranslation translation;

  final List<Reference> underlinedReferences;

  final BibleSelection? selection;
  final Function(VerseSelection)? onNavigateToVerseSelection;

  final PassageController? controller;
  final EdgeInsetsGeometry? padding;
  final bool shrinkWrap;

  final Widget? header;
  final Widget? footer;

  const ParagraphsBuilder({
    super.key,
    required this.paragraphs,
    required this.chapterReference,
    required this.user,
    required this.translation,
    this.underlinedReferences = const [],
    this.selection,
    this.onNavigateToVerseSelection,
    this.controller,
    this.padding,
    this.shrinkWrap = false,
    this.header,
    this.footer,
  });

  List<Reference> get highlightedReferences => selection?.references ?? underlinedReferences;

  @override
  Widget build(BuildContext context) {
    final sizeMultiplier =
        BibleTextStyle.baseMultiplier *
        user.themeLayout.getFontSizeSpacingFor(translation.bibleLanguage, context.textScaling).multiplier;

    final selection = this.selection;
    final onNavigateToVerseSelection = this.onNavigateToVerseSelection;

    return BibleParagraphsBuilder(
      paragraphs: paragraphs,
      chapterReference: chapterReference,
      translation: translation,
      configuration: BibleParagraphsConfiguration(
        fontFamily: user.themeLayout.font.fontFamily,
        sizeMultiplier: sizeMultiplier,
        useParagraphs: user.themeLayout.paragraphs,
        showVerseNumbers: user.themeLayout.verseNumbers,
        showRedLetters: user.themeLayout.redLetters,
        showSection: (type) => user.themeLayout.sections.showFor(translation: translation, sectionType: type),
      ),
      underlinedReferences: highlightedReferences,
      textSelection: selection?.textSelection,
      decorations: [
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
                  sizeMultiplier: sizeMultiplier,
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
                  sizeMultiplier: sizeMultiplier,
                ),
              ),
            ),
      ],
      markersBuilder: (reference, verse, verseParagraphOffset) {
        final leadingAnnotations = user
            .getVerseSelectionAnnotations(VerseSelection.reference(reference))
            .where(
              (annotation) =>
                  annotation.note.isNotEmpty && annotation.verseSelection?.references.firstOrNull == reference,
            )
            .toList();

        return [
          if (leadingAnnotations.isNotEmpty)
            BibleInlineMarker.leading(builder: (context) => buildNotesButton(context, annotations: leadingAnnotations)),
          ...user
              .getTextSelectionAnnotationsWithNotesByOffset(reference: reference, translation: translation)
              .where((offset, annotations) => offset >= verseParagraphOffset)
              .mapToIterable(
                (offset, annotations) => BibleInlineMarker(
                  offset: offset - verseParagraphOffset,
                  anchorOffset: offset,
                  isBoundInSelection: true,
                  builder: (context) => buildNotesButton(context, annotations: annotations),
                ),
              ),
          if (user.themeLayout.footnotes)
            ...(verse.footnotes ?? [])
                .groupListsBy((footnote) => footnote.offset.clamp(0, verse.text.length))
                .mapToIterable(
                  (offset, footnotes) => BibleInlineMarker(
                    offset: offset,
                    anchorOffset: verseParagraphOffset + offset,
                    builder: (context) => buildFootnotesButton(context, footnotes: footnotes),
                  ),
                ),
        ];
      },
      onReferencePressed: selection == null ? null : (reference) => selection.onReferencePressed(reference, user: user),
      onTextSelectionLongPressed: selection == null || onNavigateToVerseSelection == null
          ? null
          : (textSelection) => selection.onHandleLongPress(
              context,
              selection: textSelection,
              onNavigateToVerseSelection: onNavigateToVerseSelection,
              user: user,
            ),
      onTextSelectionUpdated: selection == null
          ? null
          : (textSelection, isNewSelection) =>
                selection.onTextSelectionUpdated(selection: textSelection, isNewSelection: isNewSelection, user: user),
      controller: controller,
      padding: padding,
      shrinkWrap: shrinkWrap,
      header: header,
      footer: footer,
    );
  }

  Widget buildAnnotationChild(
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

  Widget buildNotesButton(BuildContext context, {required List<Annotation> annotations}) => Padding(
    padding: .only(bottom: 4),
    child: StyledCircleButton.sm(
      onPressed: () => context.showStyledSheet(
        (context) => StyledSheet(
          title: t.labels.notes.toText(),
          children: annotations
              .map(
                (annotation) => Consumer(
                  builder: (context, ref, child) {
                    final annotationText = ref
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

  Widget buildFootnotesButton(BuildContext context, {required List<Footnote> footnotes}) => Padding(
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
                          onNavigateToVerseSelection?.call(selection);
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
