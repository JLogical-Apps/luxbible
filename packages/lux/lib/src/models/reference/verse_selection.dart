import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:lux/lux_core.dart';
import 'package:utils_core/utils_core.dart';

class VerseSelection extends Equatable {
  final List<VerseSpanReference> spans;

  VerseSelection({required this.spans});

  factory VerseSelection.fromOsisId(String key) =>
      VerseSelection(spans: key.split(' ').map((span) => VerseSpanReference.fromOsisId(span)).toList());

  static bool isOsisId(String value) {
    try {
      final selection = VerseSelection.fromOsisId(value);
      return selection.osisId() == value &&
          selection.spans.every(
            (span) =>
                [span.start, ?span.end].every((pointer) {
                  final reference = pointer.startReference;
                  return reference == reference.clamped;
                }) &&
                (span.end == null || span.start.startReference <= span.end!.endReference),
          );
    } catch (_) {
      return false;
    }
  }

  factory VerseSelection.fromUsxId(String value) => VerseSelection.fromOsisId(
    value
        .split('+')
        .map((reference) {
          final match = RegExp(r'^([1-3]?[A-Z]{2,3})[ .](.+)$').firstMatch(reference.trim().toUpperCase());
          if (match == null) {
            throw FormatException('Invalid USX reference: $reference');
          }

          final usxCode = match.group(1)!;
          final book = BookType.values.firstWhereOrNull((book) => book.usxCode() == usxCode);
          if (book == null) throw FormatException('Unknown USX book: $usxCode');

          final range = match.group(2)!.replaceAll('$usxCode.', '').replaceAll('.', ':');
          final parts = range.split('-');
          if (parts.length > 2) {
            throw FormatException('Invalid USX range: $range');
          }

          final start = parts.first.split(':');
          final startOsis = [book.osisId(), ...start].join('.');
          if (parts.length == 1) return startOsis;

          final end = parts.last.split(':');
          final endOsis = end.length == 1 && start.length == 2
              ? [book.osisId(), start.first, end.first].join('.')
              : [book.osisId(), ...end].join('.');
          return '$startOsis-$endOsis';
        })
        .join(' '),
  );

  static VerseSelection? tryFromUsxId(String? value) {
    if (value == null) return null;

    try {
      return VerseSelection.fromUsxId(value);
    } catch (_) {
      return null;
    }
  }

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

  bool get isChapter => spans.length == 1 && spans.first.start is ChapterBiblePointer;

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
