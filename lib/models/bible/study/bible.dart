import 'package:bible/models/bible/bible_translation.dart';
import 'package:bible/models/bible/book_type.dart';
import 'package:bible/models/bible/display/bible.dart';
import 'package:bible/models/bible/study/book.dart';
import 'package:bible/models/bible/study/chapter.dart';
import 'package:bible/models/bible/study/study_verse.dart';
import 'package:bible/models/bible/study/verse_fragment.dart';
import 'package:bible/models/reference/chapter_reference.dart';
import 'package:bible/models/reference/reference.dart';
import 'package:bible/models/reference/verse_span_reference.dart';
import 'package:bible/utils/extensions/collection_extensions.dart';
import 'package:utils_core/utils_core.dart';

class StudyBible {
  final BibleTranslation translation;
  final List<StudyBook> books;

  StudyBible({required this.translation, required this.books});

  factory StudyBible.fromDisplay(DisplayBible bible) => StudyBible(
    translation: bible.translation,
    books: bible.books
        .map(
          (book) => StudyBook(
            bookType: book.bookType,
            chapters: book.chapters
                .map(
                  (chapter) => StudyChapter(
                    chapterNum: chapter.chapterNum,
                    verses: chapter.verses.values.mapToMap(
                      (verse) => MapEntry(verse.verseNum, StudyVerse(fragments: [VerseFragment(text: verse.text)])),
                    ),
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

  late final Map<Reference, StudyVerse> _verseByReference = references
      .mapToMap(
        (reference) => MapEntry(
          reference,
          getBookByType(reference.book).chapters[reference.chapterNum - 1].verses[reference.verseNum],
        ),
      )
      .withoutNullValues;

  StudyVerse? getVerseByReference(Reference reference) => _verseByReference[reference];

  List<StudyVerse> getVersesBySpan(VerseSpanReference reference) =>
      reference.references.map((reference) => getVerseByReference(reference)).nonNulls.toList();

  late final Map<BookType, StudyBook> _bookByType = BookType.values.mapToMap(
    (bookType) => MapEntry(bookType, books.firstWhere((book) => book.bookType == bookType)),
  );
  StudyBook getBookByType(BookType bookType) => _bookByType[bookType]!;
}
