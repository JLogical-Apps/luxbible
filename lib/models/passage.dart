import 'package:bible/models/bible.dart';
import 'package:bible/models/book_type.dart';
import 'package:bible/models/chapter_reference.dart';
import 'package:bible/models/reference.dart';
import 'package:bible/utils/extensions/collection_extensions.dart';
import 'package:bible/utils/range.dart';
import 'package:collection/collection.dart';

class Passage {
  final List<Reference> references;

  const Passage({required this.references});

  static Passage fromKey(String key, {required Bible bible}) {
    final items = key.split('-');
    final ref1Items = items.first.split('.');
    final book = BookType.fromOsisId(ref1Items.first);
    final chapterNum = int.parse(ref1Items[1]);
    final allVerses = items.length >= 2
        ? Range.generate(int.parse(ref1Items[2]), int.parse(items.last.split('.').last))
        : ref1Items.length == 2
        ? List.generate(
            bible.getChapterByReference(ChapterReference(book: book, chapterNum: chapterNum)).verses.length,
            (i) => i + 1,
          )
        : [int.parse(ref1Items[2])];
    return Passage(
      references: allVerses
          .map((verseNum) => Reference(book: book, chapterNum: chapterNum, verseNum: verseNum))
          .toList(),
    );
  }

  List<Reference> get sortedReferences => references.sorted().toList();

  List<String> get referenceKeys => references.map((reference) => reference.toKey()).toList();

  bool hasReference(Reference reference) => references.contains(reference);

  String format() => sortedReferences
      .groupListsBy((ref) => ref.book)
      .map(
        (book, bookRefs) => MapEntry(
          book,
          bookRefs
              .groupListsBy((ref) => ref.chapterNum)
              .mapToIterable(
                (chapter, verseRefs) => [
                  chapter.toString(),
                  verseRefs
                      .map((ref) => ref.verseNum)
                      .batchedByRuns()
                      .map(
                        (run) =>
                            run.length == 1 ? run.first.toString() : '${run.first.toString()}-${run.last.toString()}',
                      )
                      .join(', '),
                ].join(':'),
              )
              .join('; '),
        ),
      )
      .mapToIterable((book, chapterText) => '${book.title()} $chapterText')
      .join('; ');
}
