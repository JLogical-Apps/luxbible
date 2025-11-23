import 'package:bible/models/reference/reference.dart';
import 'package:bible/models/reference/verse_span_reference.dart';
import 'package:bible/utils/extensions/collection_extensions.dart';
import 'package:collection/collection.dart';

class Passage {
  final List<VerseSpanReference> spans;

  const Passage({required this.spans});

  factory Passage.fromOsisId(String key) =>
      Passage(spans: key.split(' ').map((span) => VerseSpanReference.fromOsisId(span)).toList());

  factory Passage.fromJson(String json) = Passage.fromOsisId;
  String toJson() => osisId();

  String osisId() => spans.map((span) => span.osisId()).join(' ');

  List<Reference> get references =>
      spans.expand((span) => span.references).distinct.sortedBy((reference) => reference).toList();

  bool hasReference(Reference reference) => references.contains(reference);

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
