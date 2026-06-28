import 'package:bible/models/reference/reference.dart';
import 'package:bible/models/reference/verse_span_reference.dart';
import 'package:collection/collection.dart';
import 'package:flutter/services.dart';
import 'package:utils_core/utils_core.dart';

class CrossReferencesImporter {
  Future<Map<Reference, Map<VerseSpanReference, int>>> import() async {
    final crossReferencesRaw = await rootBundle.loadString('assets/cross_references/cross_references.txt');
    return crossReferencesRaw
        .split('\n')
        .skip(1)
        .where((line) => line.isNotEmpty)
        .map((line) => line.split('\t'))
        .where((line) => line[2].isNotEmpty)
        .map(
          (line) => _CrossReferenceLine(
            referenceOf: Reference.fromOsisId(line[0]),
            referenceTo: VerseSpanReference.fromOsisId(line[1]),
            votes: int.tryParse(line[2]),
          ),
        )
        .groupListsBy((line) => line.referenceOf)
        .mapValues((reference, lines) => lines.mapToMap((line) => MapEntry(line.referenceTo, line.votes ?? 0)));
  }
}

class _CrossReferenceLine {
  final Reference referenceOf;
  final VerseSpanReference referenceTo;
  final int? votes;

  const _CrossReferenceLine({required this.referenceOf, required this.referenceTo, required this.votes});
}
