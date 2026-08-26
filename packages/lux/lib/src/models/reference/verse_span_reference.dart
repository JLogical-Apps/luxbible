import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:lux/lux_core.dart';

class VerseSpanReference extends Equatable {
  final BiblePointer start;
  final BiblePointer? end;

  const VerseSpanReference({required this.start, this.end});

  factory VerseSpanReference.fromOsisId(String id) {
    final split = id.split('-');
    if (split case [final reference]) {
      return VerseSpanReference(start: BiblePointer.fromOsisId(reference));
    } else if (split case [final reference1, final reference2]) {
      return VerseSpanReference(start: BiblePointer.fromOsisId(reference1), end: BiblePointer.fromOsisId(reference2));
    } else {
      throw Exception('Cannot convert `$id` to VerseSpanReference');
    }
  }

  factory VerseSpanReference.parse(String range, {required BookType book}) {
    ({int chapter, int? verse}) parsePart(String part) {
      final split = part.split(':');
      return (chapter: int.parse(split[0]), verse: split.length > 1 ? int.parse(split[1]) : null);
    }

    final parts = range.split('-');
    var start = parsePart(parts.first);
    var end = parts.length > 1 ? parsePart(parts[1]) : null;

    // For single-chapter books a bare number is a verse within chapter 1, not a chapter:
    // "Philemon 1-25" == Philemon 1:1-25.
    if (book.isSingleChapter) {
      ({int chapter, int? verse}) asVerse(({int chapter, int? verse}) part) =>
          part.verse == null ? (chapter: 1, verse: part.chapter) : part;
      start = asVerse(start);
      if (end != null) end = asVerse(end);
    }

    final startHasVerse = start.verse != null;
    final endHasVerse = end?.verse != null;

    final startReference = Reference(book: book, chapterNum: start.chapter, verseNum: start.verse ?? 1).clamped;

    final endReference = end == null
        ? startHasVerse
              ? startReference // Genesis 1:1
              : Reference.lastVerseFor(book: book, chapterNum: start.chapter) // Genesis 1
        : endHasVerse // Genesis 1:10-2:4
        ? Reference(book: book, chapterNum: end.chapter, verseNum: end.verse!).clamped
        : startHasVerse // Genesis 1:10-12
        ? Reference(book: book, chapterNum: start.chapter, verseNum: end.chapter).clamped
        : Reference.lastVerseFor(book: book, chapterNum: end.chapter); // Genesis 1-2

    return VerseSpanReference(
      start: VerseBiblePointer(reference: startReference),
      end: VerseBiblePointer(reference: endReference),
    );
  }

  @override
  List<Object> get props => [start, ?end];

  static List<VerseSpanReference> listFromReferences(List<Reference> references) => references
      .sorted()
      .splitBetween((previous, current) => previous.nextOrNull != current)
      .map(
        (run) => VerseSpanReference(
          start: VerseBiblePointer(reference: run.first),
          end: run.length == 1 ? null : VerseBiblePointer(reference: run.last),
        ),
      )
      .toList();

  String toJson() => osisId();
  factory VerseSpanReference.fromJson(String json) = VerseSpanReference.fromOsisId;

  List<Reference> get references =>
      Reference.getReferencesBetween(start.startReference, end?.endReference ?? start.endReference).toList();

  VerseSelection toVerseSelection() => VerseSelection(spans: [this]);

  String osisId() => [start, end].nonNulls.map((pointer) => pointer.osisId()).join('-');

  bool containsReference(Reference reference) => references.has(reference);
}

sealed class BiblePointer {
  Reference get startReference;
  Reference get endReference;
  List<Reference> get references;

  String osisId();
  String format();

  String formatDelta(BiblePointer? previous);

  static BiblePointer fromOsisId(String id) {
    if (id.split('.').length == 2) {
      return ChapterBiblePointer(reference: ChapterReference.fromOsisId(id));
    } else {
      return VerseBiblePointer(reference: Reference.fromOsisId(id));
    }
  }
}

class VerseBiblePointer extends Equatable implements BiblePointer {
  final Reference reference;

  const VerseBiblePointer({required this.reference});

  @override
  List<Object?> get props => [reference];

  @override
  Reference get startReference => reference;

  @override
  Reference get endReference => reference;

  @override
  List<Reference> get references => [reference];

  @override
  String osisId() => reference.osisId();

  @override
  String format() => reference.format();

  @override
  String formatDelta(BiblePointer? previous) {
    if (previous == null) {
      return format();
    }

    if (endReference.book != previous.startReference.book) {
      return format();
    }

    if (endReference.chapterNum != previous.startReference.chapterNum) {
      return '${endReference.chapterNum}:${endReference.verseNum}';
    }

    return endReference.verseNum.toString();
  }
}

class ChapterBiblePointer extends Equatable implements BiblePointer {
  final ChapterReference reference;

  const ChapterBiblePointer({required this.reference});

  @override
  List<Object?> get props => [reference];

  @override
  Reference get startReference => reference.getReference(1);

  @override
  Reference get endReference => reference.getReference(reference.numVerses);

  @override
  List<Reference> get references => reference.references;

  @override
  String osisId() => reference.osisId();

  @override
  String format() => reference.format();

  @override
  String formatDelta(BiblePointer? previous) {
    if (previous == null) {
      return format();
    }

    if (endReference.book != previous.startReference.book) {
      return format();
    }

    if (endReference.chapterNum != previous.startReference.chapterNum) {
      return '${endReference.chapterNum}:${endReference.verseNum}';
    }

    return endReference.verseNum.toString();
  }
}
