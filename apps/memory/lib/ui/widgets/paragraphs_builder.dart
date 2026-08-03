import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intersperse/intersperse.dart';
import 'package:lux/lux.dart';
import 'package:style/style.dart';
import 'package:utils_core/utils_core.dart';

class ParagraphsBuilder extends HookWidget {
  final List<Paragraph> paragraphs;
  final ChapterReference chapterReference;
  final BibleTranslation translation;

  final List<Reference> underlinedReferences;

  final Map<Reference, GlobalKey>? keyByReference;

  const ParagraphsBuilder({
    super.key,
    required this.paragraphs,
    required this.chapterReference,
    required this.translation,
    this.underlinedReferences = const [],
    this.keyByReference,
  });

  @override
  Widget build(BuildContext context) {
    final chapter = Chapter(paragraphs: paragraphs);

    final paragraphSpansByParagraph = useMemoized(
      () => getParagraphSpansByParagraph(context, chapter: chapter).where((entry) => entry.value.isNotEmpty).toList(),
      [paragraphs, translation, keyByReference, context.brightness],
    );

    return MediaQuery.withNoTextScaling(
      child: Column(
        crossAxisAlignment: .stretch,
        children: paragraphSpansByParagraph
            .mapEntries(
              (paragraph, originalSpans) => ParagraphText(
                paragraph: paragraph,
                originalSpans: originalSpans,
                useParagraphLayout: true,
                overlayBuilder: (context, layout) => paragraph is VersesParagraph
                    ? buildVerseAnchorOverlays(
                        paragraphs: paragraphs,
                        paragraph: paragraph,
                        renderSpans: layout.renderSpans,
                        maxWidth: layout.maxWidth,
                        keyByReference: keyByReference,
                        getVerseReference: getVerseReference,
                      )
                    : [],
              ),
            )
            .toList(),
      ),
    );
  }

  Reference getVerseReference(Verse verse) => chapterReference.getReference(verse.verseNum);

  List<MapEntry<Paragraph, List<InlineSpan>>> getParagraphSpansByParagraph(
    BuildContext context, {
    required Chapter chapter,
    TextDirection textDirection = .ltr,
  }) {
    final bibleTextStyle = BibleTextStyle(context);

    var maxPreviousVerseNum = 0;
    return chapter.paragraphs.mapIndexed((paragraphIndex, paragraph) {
      final previousParagraph = paragraphIndex == 0 ? null : chapter.paragraphs[paragraphIndex - 1];
      return MapEntry(paragraph, [
        if (previousParagraph?.as<VersesParagraph>()?.type.isPoetic == true &&
            paragraph is VersesParagraph &&
            !paragraph.type.isPoetic)
          TextSpan(text: '\n', style: bibleTextStyle.body.copyWith(height: 1.5)),
        ...switch (paragraph) {
          SectionParagraph() => buildSectionParagraphSpans(
            paragraph: paragraph,
            paragraphIndex: paragraphIndex,
            previousParagraph: previousParagraph,
            bibleTextStyle: bibleTextStyle,
          ),
          VersesParagraph(:final verses, :final type, :final preventIndent) => [
            if (!preventIndent) SizedWidgetSpan.space(size: Size(type.hangingIndent != 0 ? 0 : type.indent, 0)),
            ...verses
                .mapIndexed<List<InlineSpan>>((verseIndex, verse) {
                  final reference = getVerseReference(verse);
                  final verseParagraphOffset = verseIndex == 0 ? paragraph.firstVerseOffset : 0;

                  final spans = [
                    if (verse.verseNum > maxPreviousVerseNum)
                      buildVerseNumberSpan(
                        reference: reference,
                        verseNumber: verse.verseNum,
                        bibleTextStyle: bibleTextStyle,
                        isUnderlined: underlinedReferences.contains(reference),
                        textDirection: textDirection,
                      ),
                    ...verse.words.mapIndexed((wordIndex, word) {
                      if (word.text == null) {
                        return null;
                      }

                      final wordParagraphOffset =
                          verseParagraphOffset + verse.words.take(wordIndex).map((word) => word.text?.length ?? 0).sum;
                      return AnnotatedTextSpan<VerseElement>(
                        annotation: VerseElement(
                          anchor: BibleTextSelectionWordAnchor.fromReference(
                            reference: reference,
                            characterOffset: wordParagraphOffset,
                          ),
                          isBoundInSelection: false,
                        ),
                        text: word.text,
                        style: bibleTextStyle.body.copyWith(
                          color: word.redLetters ? context.colors.red.dark : null,
                          fontStyle: word.italic || type.isItalic ? .italic : null,
                          decoration: underlinedReferences.contains(reference) ? .underline : null,
                        ),
                      );
                    }).nonNulls,
                  ];
                  maxPreviousVerseNum = verse.verseNum;
                  return spans;
                })
                .intersperse([TextSpan(text: ' ', style: bibleTextStyle.body)])
                .flattenedToList,
          ],
          BreakParagraph() =>
            previousParagraph is! SectionParagraph
                ? [TextSpan(text: '\n', style: bibleTextStyle.body.copyWith(height: 0.75))]
                : <InlineSpan>[],
        },
      ]);
    }).toList();
  }
}
