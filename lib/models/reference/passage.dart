import 'package:bible/models/reference/reference.dart';
import 'package:bible/models/reference/region.dart';
import 'package:bible/models/reference/verse_span_reference.dart';
import 'package:bible/utils/extensions/collection_extensions.dart';
import 'package:collection/collection.dart';

class Passage implements ReferencesRegion {
  final List<VerseSpanReference> spans;

  const Passage({required this.spans});

  factory Passage.fromOsisId(String key) =>
      Passage(spans: key.split(' ').map((span) => VerseSpanReference.fromOsisId(span)).toList());

  factory Passage.fromReferences(List<Reference> references) =>
      Passage(spans: VerseSpanReference.listFromReferences(references));

  factory Passage.reference(Reference reference) => Passage(
    spans: [VerseSpanReference(start: VerseBiblePointer(reference: reference))],
  );

  factory Passage.fromJson(String json) = Passage.fromOsisId;
  String toJson() => osisId();

  String osisId() => spans.map((span) => span.osisId()).join(' ');

  @override
  List<Reference> get references =>
      spans.expand((span) => span.references).distinct.sortedBy((reference) => reference).toList();

  bool get isEmpty => spans.isEmpty;
  bool get isNotEmpty => spans.isNotEmpty;

  bool hasReference(Reference reference) => spans.any((span) => span.containsReference(reference));
  bool hasAnyOf(Passage passage) => passage.references.any((reference) => hasReference(reference));

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

  Passage withReference(Reference reference) =>
      hasReference(reference) ? this : Passage.fromReferences(references + [reference]);
}
