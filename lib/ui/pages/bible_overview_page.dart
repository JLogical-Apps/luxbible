import 'package:bible/extensions/build_context_extensions.dart';
import 'package:bible/providers/bible_provider.dart';
import 'package:bible/ui/pages/bible_book_overview_page.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BibleOverviewPage extends ConsumerWidget {
  const BibleOverviewPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bible = ref.watch(bibleProvider);
    return Scaffold(
      body: ListView(
        children: ListTile.divideTiles(
          context: context,
          tiles: bible.books.map(
            (book) => ListTile(
              title: Text(book.bookType.title()),
              trailing: Icon(Icons.chevron_right),
              onTap: () => context.push(BibleBookOverviewPage(book: book)),
            ),
          ),
        ).toList(),
      ),
    );
  }
}
