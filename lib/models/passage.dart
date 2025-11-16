import 'package:bible/models/book_type.dart';
import 'package:bible/models/reference.dart';
import 'package:bible/utils/extensions/collection_extensions.dart';
import 'package:bible/utils/range.dart';
import 'package:collection/collection.dart';

class Passage {
  final List<Reference> references;

  const Passage({required this.references});

  static Passage fromOsisId(String key) => Passage(
    references: key
        .split(' ')
        .expand((span) {
          final items = key.split('-');
          final ref1Items = items.first.split('.');
          final book = BookType.fromOsisId(ref1Items.first);
          final chapterNum = int.parse(ref1Items[1]);
          final allVerses = items.length >= 2
              ? Range.generate(int.parse(ref1Items[2]), int.parse(items.last.split('.').last))
              : ref1Items.length == 2
              ? List.generate(book.bookInfo.getNumVerses(chapterNum), (i) => i + 1)
              : [int.parse(ref1Items[2])];
          return allVerses
              .map((verseNum) => Reference(book: book, chapterNum: chapterNum, verseNum: verseNum))
              .toList();
        })
        .sortedBy((e) => e)
        .toList(),
  );

  String osisId() => sortedReferences
      .groupListsBy((ref) => ref.book)
      .mapToIterable(
        (book, bookRefs) => bookRefs
            .groupListsBy((ref) => ref.chapterNum)
            .mapToIterable(
              (chapter, verseRefs) => verseRefs
                  .map((ref) => ref.verseNum)
                  .batchedByRuns()
                  .map((run) => run.length == 1 ? [run.first] : [run.first, run.last])
                  .map((verses) => verses.map((verse) => '${book.osisId()}.$chapter.$verse').join('-'))
                  .join(' '),
            )
            .join(' '),
      )
      .join(' ');

  List<Reference> get sortedReferences => references.sorted().toList();

  List<String> get referenceKeys => references.map((reference) => reference.toKey()).toList();

  bool hasReference(Reference reference) => references.contains(reference);

  String format() => sortedReferences
      .groupListsBy((ref) => ref.book)
      .mapToIterable(
        (book, bookRefs) => [
          book.title(),
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
              .join(' '),
        ].join(' '),
      )
      .join('; ');
}
