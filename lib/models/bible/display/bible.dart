import 'package:bible/models/bible/bible_translation.dart';
import 'package:bible/models/bible/book_type.dart';
import 'package:bible/models/bible/display/book.dart';
import 'package:bible/models/bible/display/chapter.dart';
import 'package:bible/models/bible/display/verse.dart';
import 'package:bible/models/bible/study/bible.dart';
import 'package:bible/models/reference/chapter_reference.dart';
import 'package:bible/models/reference/reference.dart';
import 'package:bible/models/reference/selection.dart';
import 'package:bible/utils/extensions/collection_extensions.dart';
import 'package:bible/utils/extensions/object_extensions.dart';
import 'package:bible/utils/extensions/string_extensions.dart';
import 'package:bible/utils/range.dart';
import 'package:utils_core/utils_core.dart';

class DisplayBible {
  final BibleTranslation translation;
  final List<DisplayBook> books;

  DisplayBible({required this.translation, required this.books});

  factory DisplayBible.fromStudy(StudyBible bible) => DisplayBible(
    translation: bible.translation,
    books: bible.books
        .map(
          (book) => DisplayBook(
            bookType: book.bookType,
            chapters: book.chapters
                .map(
                  (chapter) => DisplayChapter.verses(
                    chapterNum: chapter.chapterNum,
                    verses: chapter.verses
                        .mapToIterable((verseNum, verse) => DisplayVerse(verseNum: verseNum, text: verse.text))
                        .toList(),
                  ),
                )
                .toList(),
          ),
        )
        .toList(),
  );

  List<ChapterReference> get chapterReferences => books
      .expand(
        (book) => List.generate(book.chapters.length, (i) => ChapterReference(book: book.bookType, chapterNum: i + 1)),
      )
      .toList();

  late final List<Reference> references = chapterReferences.expand((chapter) => chapter.references).toList();

  late final Map<Reference, DisplayVerse> _verseByReference = references
      .mapToMap(
        (reference) => MapEntry(
          reference,
          getBookByType(reference.book).chapters[reference.chapterNum - 1].verses[reference.verseNum],
        ),
      )
      .withoutNullValues;

  DisplayChapter getChapterByReference(ChapterReference reference) =>
      getBookByType(reference.book).chapters[reference.chapterNum - 1];

  DisplayVerse? getVerseByReference(Reference reference) => _verseByReference[reference];

  ChapterReference getChapterReferenceByPageIndex(int pageIndex) => chapterReferences[pageIndex];

  int getPageIndexByChapterReference(ChapterReference reference) =>
      chapterReferences.indexWhere((r) => r.book == reference.book && r.chapterNum == reference.chapterNum);

  late final Map<BookType, DisplayBook> _bookByType = BookType.values.mapToMap(
    (bookType) => MapEntry(bookType, books.firstWhere((book) => book.bookType == bookType)),
  );
  DisplayBook getBookByType(BookType bookType) => _bookByType[bookType]!;

  String getSelectionText(Selection selection) {
    final verseTexts = Reference.getReferencesBetween(
      selection.start.toReference(),
      selection.end.toReference(),
    ).map((reference) => getVerseByReference(reference)?.text).nonNulls.toList();
    verseTexts[verseTexts.length - 1] = verseTexts[verseTexts.length - 1].substring(
      0,
      selection.end.characterOffset + 1,
    );
    verseTexts[0] = verseTexts[0].substring(selection.start.characterOffset);

    return verseTexts.join(' ');
  }

  Selection getWordsSelection(Selection selection) {
    final startVerseText = getVerseByReference(selection.start.toReference())!.text;
    final endVerseText = getVerseByReference(selection.end.toReference())!.text;
    return Selection(
      translation: translation,
      start: SelectionWordAnchor.fromReference(
        reference: selection.start.toReference(),
        characterOffset:
            List.generate(
              selection.start.characterOffset,
              (i) => i,
            ).where((offset) => startVerseText[offset] == ' ').lastOrNull?.mapIfNonNull((offset) => offset + 1) ??
            0,
      ),
      end: SelectionWordAnchor.fromReference(
        reference: selection.end.toReference(),
        characterOffset:
            Range.generate(
              selection.end.characterOffset,
              endVerseText.length - 1,
            ).where((offset) => endVerseText[offset].isLetterOnly).firstOrNull?.mapIfNonNull((offset) => offset - 1) ??
            endVerseText.length - 1,
      ),
    );
  }
}
