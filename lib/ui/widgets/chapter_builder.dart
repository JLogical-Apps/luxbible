import 'package:bible/models/annotation.dart';
import 'package:bible/models/bible/bible.dart';
import 'package:bible/models/bible/book_type.dart';
import 'package:bible/models/bible/chapter.dart';
import 'package:bible/models/bible/paragraph.dart';
import 'package:bible/models/bible/verse.dart';
import 'package:bible/models/reference/chapter_reference.dart';
import 'package:bible/models/reference/passage.dart';
import 'package:bible/models/reference/reference.dart';
import 'package:bible/models/reference/selection.dart';
import 'package:bible/models/user/user.dart';
import 'package:bible/style/style.dart';
import 'package:bible/ui/widgets/sized_widget_span.dart';
import 'package:bible/ui/widgets/underline.dart';
import 'package:bible/utils/extensions/num_extensions.dart';
import 'package:bible/utils/extensions/span_extensions.dart';
import 'package:bible/utils/extensions/string_extensions.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intersperse/intersperse.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:utils_core/utils_core.dart';

class ChapterBuilder extends ConsumerWidget {
  final ChapterReference chapterReference;
  final User user;
  final Bible bible;

  final Function(Reference)? onReferencePressed;
  final List<Reference> underlinedReferences;

  final ObjectRef<Map<Reference, GlobalKey>>? keyByReferenceRef;

  const ChapterBuilder({
    super.key,
    required this.chapterReference,
    required this.user,
    required this.bible,
    this.onReferencePressed,
    this.underlinedReferences = const [],
    this.keyByReferenceRef,
  });

  Chapter get chapter => bible.getChapterByReference(chapterReference);
  BookType get book => chapterReference.book;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: .stretch,
      children: getParagraphSpansByParagraph(context, ref)
          .mapEntries(
            (paragraph, paragraphSpan) => Padding(
              padding: paragraph.as<VersesParagraph>()?.type.padding ?? .zero,
              child: LayoutBuilder(
                builder: (context, constraints) => GestureDetector(
                  onTapUp: (details) {
                    if (paragraph is! VersesParagraph) {
                      return;
                    }

                    final offset = paragraphSpan.getCharacterOffsetFromPosition(
                      width: constraints.maxWidth,
                      localPosition: details.localPosition,
                      textAlign: paragraph.type.textAlign,
                    );

                    final anchor = getOffsetAnchor(characterOffset: offset, paragraph: paragraph);
                    if (anchor != null) {
                      onReferencePressed?.call(anchor.toReference());
                    }
                  },
                  child: Text.rich(
                    TextSpan(children: paragraphSpan),
                    style: TextStyle(fontStyle: paragraph.as<VersesParagraph>()?.type.fontStyle ?? .normal),
                    textAlign: paragraph.as<VersesParagraph>()?.type.textAlign ?? .start,
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Reference getReferenceByVerse(Verse verse) => chapterReference.getReference(verse.verseNum);

  List<MapEntry<Paragraph, List<InlineSpan>>> getParagraphSpansByParagraph(BuildContext context, WidgetRef ref) {
    var maxPreviousVerseNum = 0;
    return chapter.paragraphs.mapIndexed((paragraphIndex, paragraph) {
      final previousParagraph = paragraphIndex == 0
          ? null
          : chapter.paragraphs[paragraphIndex - 1].as<VersesParagraph>();
      return MapEntry(paragraph, [
        if (previousParagraph?.type.isPoetic == true && paragraph is VersesParagraph && !paragraph.type.isPoetic)
          TextSpan(text: '\n', style: context.textStyle.bibleBody.copyWith(height: 1.5)),
        ...switch (paragraph) {
          SectionParagraph(:final text) => [
            if (paragraphIndex != 0) TextSpan(text: '\n', style: context.textStyle.bibleBody.copyWith(height: 1.5)),
            TextSpan(text: text, style: context.textStyle.bibleSection),
          ],
          VersesParagraph(:final verses, :final type) => [
            SizedWidgetSpan.space(size: Size(type.indent, 0)),
            ...verses
                .mapIndexed((verseIndex, verse) {
                  final reference = getReferenceByVerse(verse);

                  final passageAnnotations = user.getPassageAnnotations(Passage.reference(reference));
                  final passageAnnotationsWithNote = passageAnnotations
                      .where(
                        (annotation) =>
                            annotation.note != null &&
                            annotation.passages.any((passage) => passage.references.firstOrNull == reference),
                      )
                      .toList();

                  final spans = [
                    if (verse.verseNum > maxPreviousVerseNum) ...[
                      SizedWidgetSpan(
                        size: Size(
                          context.textStyle.bibleVerseNumber.getWidth(verse.verseNum.toString()) + 6,
                          context.textStyle.bibleBody.fontSize!,
                        ),
                        alignment: .middle,
                        child: Padding(
                          padding: .only(right: 6),
                          child: Text(
                            verse.verseNum.toString(),
                            style: context.textStyle.bibleVerseNumber.copyWith(
                              decoration: underlinedReferences.contains(reference) ? .underline : null,
                            ),
                          ),
                        ),
                      ),
                      if (passageAnnotationsWithNote.isNotEmpty)
                        notesButtonSpan(
                          context,
                          ref,
                          annotations: passageAnnotationsWithNote,
                          isUnderlined: underlinedReferences.contains(reference),
                          bible: bible,
                        ),
                    ],
                    TextSpan(
                      text: verse.text,
                      style: context.textStyle.bibleBody.copyWith(
                        decoration: underlinedReferences.contains(reference) ? .underline : null,
                      ),
                    ),
                  ];
                  maxPreviousVerseNum = verse.verseNum;
                  return spans;
                })
                .intersperse([TextSpan(text: ' ', style: context.textStyle.bibleBody)])
                .flattenedToList,
          ],
          BreakParagraph() => [TextSpan(text: '\n', style: context.textStyle.bibleBody.copyWith(height: 0.75))],
        },
      ]);
    }).toList();
  }

  SelectionWordAnchor? getOffsetAnchor({required int characterOffset, required VersesParagraph paragraph}) {
    var offsetCount = 0;
    for (final verse in paragraph.verses) {
      final referenceLength = verse.text.length;
      if (characterOffset < offsetCount + referenceLength) {
        return SelectionWordAnchor.fromReference(
          reference: getReferenceByVerse(verse),
          characterOffset: (characterOffset - offsetCount).clampZero,
        );
      }

      offsetCount += referenceLength + 1;
    }
    return null;
  }

  WidgetSpan notesButtonSpan(
    BuildContext context,
    WidgetRef ref, {
    required List<Annotation> annotations,
    required bool isUnderlined,
    Color? color,
    required Bible bible,
  }) {
    return SizedWidgetSpan(
      size: Size(30, context.textStyle.bibleBody.fontSize!),
      alignment: .middle,
      child: OverflowBox(
        maxHeight: context.textStyle.bibleBody.totalHeight + 4,
        maxWidth: 30,
        child: Underline(
          isUnderlined: isUnderlined,
          child: Container(
            color: color,
            margin: .only(bottom: 4),
            child: StyledCircleButton.sm(
              onPressed: () => context.showStyledSheet(
                (context) => StyledSheet(
                  title: 'Notes'.toText(),
                  children: annotations
                      .map(
                        (annotation) => StyledListItem(
                          title: (annotation.note ?? '').toText(),
                          subtitle: Column(
                            children: [
                              annotation.passages.map((passage) => passage.format()).join('; ').nullIfBlank,
                              ...annotation.selections.map((selection) => '"${bible.getSelectionText(selection)}"'),
                            ].nonNulls.map((text) => Text(text, maxLines: 1, overflow: .ellipsis)).toList(),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              child: Icon(Symbols.note_stack, color: context.colors.contentTertiary),
            ),
          ),
        ),
      ),
    );
  }
}
