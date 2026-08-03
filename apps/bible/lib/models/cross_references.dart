import 'package:lux/lux.dart';

class CrossReferences {
  final List<(Reference, String rawRange, int rating)> rawCrossReferences;

  CrossReferences({required this.rawCrossReferences});

  Map<VerseSpanReference, int> operator [](Reference reference) => Map.fromEntries(
    rawCrossReferences
        .where((crossReference) => crossReference.$1 == reference)
        .map((crossReference) => MapEntry(.fromOsisId(crossReference.$2), crossReference.$3)),
  );
}
