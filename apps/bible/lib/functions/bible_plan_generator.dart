import 'package:bible/models/bible_plan.dart';
import 'package:collection/collection.dart';
import 'package:lux/lux.dart';
import 'package:utils_core/utils_core.dart';

class BiblePlanGenerator {
  const BiblePlanGenerator();

  List<BiblePlanDay> generate({required Bible bible, required Set<BookType> selectedBooks, required int duration}) {
    final selectedBookData = bible.books.where((book) => selectedBooks.contains(book.bookType)).toList();
    final references = selectedBookData
        .expand(
          (book) => book.chapters.mapIndexed(
            (chapterIndex, chapter) =>
                chapter.paragraphs.getReferences(ChapterReference(book: book.bookType, chapterNum: chapterIndex + 1)),
          ),
        )
        .flattened
        .distinct
        .sorted()
        .toList();
    final availableReferences = references.toSet();
    final readingDayCount = duration.clamp(1, references.length);
    final boundaryByReference = selectedBookData
        .expand(
          (book) => book.chapters.mapIndexed(
            (chapterIndex, chapter) => _getBoundaries(
              chapter: chapter,
              chapterReference: ChapterReference(book: book.bookType, chapterNum: chapterIndex + 1),
            ),
          ),
        )
        .expand((boundaries) => boundaries.entries)
        .toMap();

    var start = 0;
    final readingDays = Range.generate(1, readingDayCount).map((dayNumber) {
      final remainingReadingDays = readingDayCount - dayNumber + 1;
      final end = remainingReadingDays == 1
          ? references.length
          : _getEndIndex(
              references: references,
              boundaryByReference: boundaryByReference,
              start: start,
              remainingReadingDays: remainingReadingDays,
            );
      final dayReferences = _getReferencesWithCanonicalGaps(
        references: references.sublist(start, end),
        availableReferences: availableReferences,
      );
      start = end;
      return BiblePlanDay(passages: VerseSelection.fromReferences(dayReferences).splitByChapter());
    }).toList();

    return [...readingDays, ...List.generate(duration - readingDayCount, (_) => BiblePlanDay())];
  }

  List<Reference> _getReferencesWithCanonicalGaps({
    required List<Reference> references,
    required Set<Reference> availableReferences,
  }) => references.expand((reference) {
    final chapterReferences = reference.toChapterReference().references;
    final previousReferences = chapterReferences.take(reference.verseNum - 1);
    final leadingMissingReferences = previousReferences.any(availableReferences.contains)
        ? <Reference>[]
        : previousReferences;
    final followingMissingReferences = chapterReferences
        .skip(reference.verseNum)
        .takeWhile((reference) => !availableReferences.contains(reference));
    return [...leadingMissingReferences, reference, ...followingMissingReferences];
  }).toList();

  Map<Reference, _BiblePlanBoundary> _getBoundaries({
    required Chapter chapter,
    required ChapterReference chapterReference,
  }) {
    final chapterStart = chapterReference.getReference(1);
    final sectionStarts = chapter.paragraphs.indexed
        .map((entry) => chapter.paragraphs.getVerseIntroducedBySectionAt(entry.$1))
        .nonNulls
        .map((verse) => chapterReference.getReference(verse.verseNum));
    final paragraphStarts = chapter.paragraphs
        .whereType<VersesParagraph>()
        .where((paragraph) => paragraph.firstVerseOffset == 0 && !paragraph.type.isPoetic)
        .map((paragraph) => paragraph.verses.firstOrNull)
        .nonNulls
        .map((verse) => chapterReference.getReference(verse.verseNum));

    return <Reference, _BiblePlanBoundary>{
      ...Map.fromEntries(paragraphStarts.map((reference) => MapEntry(reference, _BiblePlanBoundary.paragraph))),
      ...Map.fromEntries(sectionStarts.map((reference) => MapEntry(reference, _BiblePlanBoundary.section))),
      chapterStart: _BiblePlanBoundary.chapter,
    };
  }

  int _getEndIndex({
    required List<Reference> references,
    required Map<Reference, _BiblePlanBoundary> boundaryByReference,
    required int start,
    required int remainingReadingDays,
  }) {
    final remainingVerseCount = references.length - start;
    final target = remainingVerseCount / remainingReadingDays;
    final tolerance = (target * .25).clamp(1, double.infinity);
    final minimumLength = (target - tolerance).ceil().clamp(1, remainingVerseCount - remainingReadingDays + 1);
    final maximumLength = (target + tolerance).floor().clamp(
      minimumLength,
      remainingVerseCount - remainingReadingDays + 1,
    );
    final lengths = Range.generate(minimumLength, maximumLength);

    final preferredLengths = _BiblePlanBoundary.values
        .map((boundary) => lengths.where((length) => boundaryByReference[references[start + length]] == boundary))
        .firstWhereOrNull((lengths) => lengths.isNotEmpty);
    return _getClosestLength(preferredLengths ?? lengths, target) + start;
  }

  int _getClosestLength(Iterable<int> lengths, double target) => lengths.fold<int?>(null, (closest, length) {
    if (closest == null) return length;
    final distance = (length - target).abs();
    final closestDistance = (closest - target).abs();
    return distance < closestDistance || (distance == closestDistance && length < closest) ? length : closest;
  })!;
}

enum _BiblePlanBoundary { chapter, section, paragraph }
