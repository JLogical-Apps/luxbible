import 'package:bible/models/reference/chapter_reference.dart';
import 'package:bible/models/reference/reference.dart';

class VerseSpanReference {
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

  static List<VerseSpanReference> listFromReferences(List<Reference> references) {
    references.sort();

    if (references.length == 1) {
      return [VerseSpanReference(start: VerseBiblePointer(reference: references.first), end: null)];
    }

    final spans = <VerseSpanReference>[];

    var runStart = references.first;
    for (var i = 1; i < references.length; i++) {
      final previousReference = references[i - 1];
      if (previousReference.next != references[i]) {
        spans.add(
          VerseSpanReference(
            start: VerseBiblePointer(reference: runStart),
            end: runStart == previousReference ? null : VerseBiblePointer(reference: previousReference),
          ),
        );
        runStart = references[i];
      }
    }

    spans.add(
      VerseSpanReference(
        start: VerseBiblePointer(reference: runStart),
        end: runStart == references.last ? null : VerseBiblePointer(reference: references.last),
      ),
    );

    return spans;
  }

  String toJson() => osisId();
  factory VerseSpanReference.fromJson(String json) = VerseSpanReference.fromOsisId;

  List<Reference> get references {
    final end = this.end;
    final references = start.references;
    if (end == null) {
      return references;
    }

    var reference = references.last;
    final lastReference = end.endReference;
    while (reference != lastReference) {
      reference = reference.next;
      references.add(reference);
    }

    return references;
  }

  String osisId() => [start, end].nonNulls.map((pointer) => pointer.osisId()).join('-');
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

class VerseBiblePointer implements BiblePointer {
  final Reference reference;

  const VerseBiblePointer({required this.reference});

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

class ChapterBiblePointer implements BiblePointer {
  final ChapterReference reference;

  const ChapterBiblePointer({required this.reference});

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
