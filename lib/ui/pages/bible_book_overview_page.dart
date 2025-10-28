import 'package:bible/extensions/build_context_extensions.dart';
import 'package:bible/models/book.dart';
import 'package:bible/ui/pages/bible_chapter_page.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class BibleBookOverviewPage extends StatelessWidget {
  final Book book;

  const BibleBookOverviewPage({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(book.bookType.title())),
      body: ListView(
        children: ListTile.divideTiles(
          context: context,
          tiles: book.chapters.mapIndexed(
            (i, chapter) => ListTile(
              title: Text((i + 1).toString()),
              trailing: Icon(Icons.chevron_right),
              onTap: () =>
                  context.push(BibleChapterPage(book: book, chapterIndex: i)),
            ),
          ),
        ).toList(),
      ),
    );
  }
}
