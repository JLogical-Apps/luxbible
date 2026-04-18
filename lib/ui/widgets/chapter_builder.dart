import 'package:bible/models/bible/chapter.dart';
import 'package:bible/models/bible/paragraph.dart';
import 'package:bible/style/style_context_extensions.dart';
import 'package:bible/style/text_style_extensions.dart';
import 'package:bible/ui/widgets/sized_widget_span.dart';
import 'package:bible/utils/extensions/object_extensions.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intersperse/intersperse.dart';

class ChapterBuilder extends ConsumerWidget {
  final Chapter chapter;

  const ChapterBuilder({super.key, required this.chapter});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var maxPreviousVerseNum = 0;
    return Text.rich(
      TextSpan(
        children: chapter.paragraphs.expandIndexed((paragraphIndex, paragraph) {
          final previousParagraph = paragraphIndex == 0
              ? null
              : chapter.paragraphs[paragraphIndex - 1].as<VersesParagraph>();
          final children = [
            if (previousParagraph?.type.isPoetic == true && paragraph is VersesParagraph && !paragraph.type.isPoetic)
              TextSpan(text: '\n', style: TextStyle(fontSize: 24, height: 1)),
            ...switch (paragraph) {
              SectionParagraph(:final text) => [
                if (paragraphIndex != 0) TextSpan(text: '\n', style: TextStyle(fontSize: 24, height: 1)),
                TextSpan(text: '$text\n', style: context.textStyle.bibleSection),
                TextSpan(text: '\n', style: TextStyle(fontSize: 12, height: 1)),
              ],
              VersesParagraph(:final verses, :final type) => [
                SizedWidgetSpan(
                  child: SizedBox.shrink(),
                  size: Size(switch (type) {
                    .q1 || .q2 => 0,
                    _ => 20,
                  }, 0),
                ),
                ...verses
                    .mapIndexed(
                      (verseIndex, verse) => [
                        if (verses.take(verseIndex).none((v) => v.verseNum == verse.verseNum) &&
                            verse.verseNum > maxPreviousVerseNum)
                          SizedWidgetSpan(
                            size: Size(
                              context.textStyle.bibleVerseNumber.getWidth(verse.verseNum.toString()) + 6,
                              context.textStyle.bibleBody.fontSize!,
                            ),
                            alignment: .middle,
                            child: Padding(
                              padding: .only(right: 6),
                              child: Text(verse.verseNum.toString(), style: context.textStyle.bibleVerseNumber),
                            ),
                          ),
                        TextSpan(text: verse.text, style: TextStyle()),
                      ],
                    )
                    .intersperse([TextSpan(text: ' ')])
                    .flattenedToList,
                TextSpan(text: ' \n'),
              ],
              BreakParagraph() => [TextSpan(text: '\n', style: TextStyle(fontSize: 24, height: 1))],
            },
          ];

          maxPreviousVerseNum = [
            maxPreviousVerseNum,
            if (paragraph is VersesParagraph) paragraph.verses.last.verseNum,
          ].max;

          return children;
        }).toList(),
      ),
      style: context.textStyle.bibleBody,
    );
  }
}
