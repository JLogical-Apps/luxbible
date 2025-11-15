import 'package:bible/models/reference.dart';
import 'package:collection/collection.dart';

class Passage {
  final List<Reference> references;

  const Passage({required this.references});

  List<Reference> get sortedReferences => references.sorted().toList();

  List<String> get referenceKeys => references.map((reference) => reference.toKey()).toList();

  bool hasReference(Reference reference) => references.contains(reference);

  String format() {
    // Book → Chapter → List<Reference>
    final grouped = sortedReferences
        .groupListsBy((ref) => ref.book)
        .map((book, bookRefs) => MapEntry(book, bookRefs.groupListsBy((r) => r.chapterNum)));

    final buffer = StringBuffer();

    grouped.forEach((book, chapters) {
      buffer.write(book.title());
      buffer.write(' ');

      final chapterStrings = chapters.entries
          .map((entry) {
            final chapter = entry.key;
            final verses = entry.value.map((e) => e.verseNum).toList()..sort();

            final parts = <String>[];
            int start = verses.first;
            int prev = start;

            for (var i = 1; i < verses.length; i++) {
              if (verses[i] == prev + 1) {
                prev = verses[i];
              } else {
                parts.add(start == prev ? '$start' : '$start–$prev');
                start = prev = verses[i];
              }
            }
            parts.add(start == prev ? '$start' : '$start–$prev');

            return '$chapter:${parts.join(', ')}';
          })
          .join('; ');

      buffer.write(chapterStrings);
      buffer.write('; ');
    });

    var out = buffer.toString();
    if (out.endsWith('; ')) {
      out = out.substring(0, out.length - 2);
    }
    return out;
  }
}
