import 'package:bible/models/book.dart';
import 'package:bible/models/chapter.dart';
import 'package:bible/style/gap.dart';
import 'package:bible/style/style_context_extensions.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class BibleChapterPage extends StatelessWidget {
  final Book book;
  final int chapterIndex;

  const BibleChapterPage({
    super.key,
    required this.book,
    required this.chapterIndex,
  });

  Chapter get chapter => book.chapters[chapterIndex];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.backgroundPrimary,
      body: ListView(
        padding:
            EdgeInsets.symmetric(horizontal: 20, vertical: 8) +
            EdgeInsets.only(
              top: MediaQuery.paddingOf(context).top + 24,
              bottom: MediaQuery.paddingOf(context).bottom,
            ),
        children: [
          Text(
            '${book.bookType.title()} ${chapterIndex + 1}',
            style: context.textStyle.bibleChapter,
          ),
          gapH8,
          ...chapter.verses.mapIndexed(
            (i, verse) => Text.rich(
              TextSpan(
                children: [
                  WidgetSpan(
                    child: Transform.translate(
                      offset: Offset(0, -3),
                      child: Text(
                        (i + 1).toString(),
                        style: context.textStyle.bibleVerseNumber,
                      ),
                    ),
                    alignment: PlaceholderAlignment.top,
                  ),
                  TextSpan(
                    text: ' ${verse.text}',
                    style: context.textStyle.bibleBody,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
