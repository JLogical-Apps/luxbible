import 'package:bible/models/book.dart';
import 'package:bible/models/chapter.dart';
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
      appBar: AppBar(
        title: Text('${book.bookType.title()} ${chapterIndex + 1}'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 8),
        children: chapter.verses
            .mapIndexed(
              (i, verse) => Text.rich(
                TextSpan(
                  style: TextTheme.of(context).bodyLarge,
                  children: [
                    TextSpan(
                      text: (i + 1).toString(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: ' ${verse.text}'),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
