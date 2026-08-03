import 'package:lux/lux.dart';
import 'package:flutter/services.dart';
import 'package:bible/models/cross_references.dart';

class CrossReferencesImporter {
  Future<CrossReferences> import() async => CrossReferences(
    rawCrossReferences: (await rootBundle.loadString('assets/cross_references/cross_references.txt'))
        .split('\n')
        .skip(1)
        .where((line) => line.isNotEmpty)
        .map((line) => line.split('\t'))
        .where((fields) => fields[2].isNotEmpty)
        .map((fields) => (Reference.fromOsisId(fields[0]), fields[1], int.tryParse(fields[2]) ?? 0))
        .toList(),
  );
}
