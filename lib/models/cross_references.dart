import 'package:bible/models/reference/reference.dart';
import 'package:bible/models/reference/verse_span_reference.dart';

class CrossReferences {
  final List<(Reference, String rawRange, int rating)> rawCrossReferences;

  CrossReferences({required this.rawCrossReferences});

  Map<VerseSpanReference, int> operator [](Reference reference) => Map.fromEntries(
    rawCrossReferences
        .where((crossReference) => crossReference.$1 == reference)
        .map((crossReference) => MapEntry(.fromOsisId(crossReference.$2), crossReference.$3)),
  );
}
