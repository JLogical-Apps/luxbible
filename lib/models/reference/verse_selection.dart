import 'package:bible/models/bible/bible_translation.dart';
import 'package:bible/models/bible/book_type.dart';
import 'package:bible/models/reference/reference.dart';
import 'package:bible/models/reference/verse_span_reference.dart';
import 'package:bible/utils/extensions/collection_extensions.dart';
import 'package:bible/utils/extensions/string_extensions.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:utils_core/utils_core.dart';

class VerseSelection extends Equatable {
  final List<VerseSpanReference> spans;

  VerseSelection({required this.spans});

  factory VerseSelection.fromOsisId(String key) =>
      VerseSelection(spans: key.split(' ').map((span) => VerseSpanReference.fromOsisId(span)).toList());

  factory VerseSelection.fromReferences(List<Reference> references) =>
      VerseSelection(spans: VerseSpanReference.listFromReferences(references));

  factory VerseSelection.reference(Reference reference) => VerseSelection(
    spans: [VerseSpanReference(start: VerseBiblePointer(reference: reference))],
  );

  factory VerseSelection.empty() => VerseSelection(spans: []);

  factory VerseSelection.parse(String input, {Map<BookType, String> bookToName = const {}}) {
    /// Captures the book name (group 1) and an optional chapter/verse range (group 2).
    final referencePattern = RegExp(r'^(.*?)\s*(\d+(?::\d+)?(?:\s*-\s*\d+(?::\d+)?)?)?$');

    final match = referencePattern.firstMatch(input.trim());
    if (match == null) {
      throw FormatException('Could not parse reference: "$input"');
    }

    final (rawBook, range) = (match.group(1)!.normalized, match.group(2));

    final book =
        BookType.values.firstWhereOrNull((type) => type.title().normalized == rawBook) ??
        BookType.values.firstWhereOrNull((type) => type.osisId().toLowerCase().normalized == rawBook) ??
        BookType.values.firstWhereOrNull((type) => bookToName[type]?.normalized == rawBook) ??
        (throw FormatException('Unknown book "$rawBook" in reference "$input"'));

    if (range == null || range.isEmpty) {
      return VerseSelection.fromReferences(book.allReferences);
    }

    return VerseSpanReference.parse(range, book: book).toVerseSelection();
  }

  @override
  List<Object?> get props => [spans];

  factory VerseSelection.fromJson(String json) = VerseSelection.fromOsisId;
  String toJson() => osisId();

  String osisId() => spans.map((span) => span.osisId()).join(' ');

  late final List<Reference> references = spans
      .expand((span) => span.references)
      .distinct
      .sortedBy((reference) => reference)
      .toList();

  bool get isEmpty => spans.isEmpty;
  bool get isNotEmpty => spans.isNotEmpty;

  bool hasReference(Reference reference) => spans.any((span) => span.containsReference(reference));
  bool hasAnyOf(VerseSelection verseSelection) => verseSelection.references.any((reference) => hasReference(reference));

  List<VerseSelection> splitByChapter() => references
      .groupListsBy((reference) => reference.toChapterReference())
      .mapToIterable(
        (chapter, references) => chapter.numVerses == references.length
            ? chapter.toVerseSelection()
            : VerseSelection.fromReferences(references),
      )
      .toList();

  bool isInTranslation(BibleTranslation translation) =>
      references.isEmpty ||
      (translation.containsBook(references.first.book) && translation.containsBook(references.last.book));

  String format() => spans.mapIndexed((spanIndex, span) {
    final previousSpan = spanIndex == 0 ? null : spans[spanIndex - 1];
    final previousEnd = previousSpan?.end?.endReference ?? previousSpan?.start.endReference;
    return [
      if (previousEnd != null)
        previousEnd.book != span.start.startReference.book ||
                previousEnd.chapterNum != span.start.startReference.chapterNum
            ? ';'
            : ',',
      [
        span.start.formatDelta(previousSpan?.end ?? previousSpan?.start),
        if (span.end case final end?) end.formatDelta(span.start),
      ].join('-'),
    ].join(' ');
  }).join();
}

extension on String {
  String get normalized => withStrippedWhitespace.toLowerCase();
}
