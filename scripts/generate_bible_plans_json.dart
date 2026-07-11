import 'dart:convert';
import 'dart:io';

import 'package:bible/models/bible_plan.dart';
import 'package:bible/models/reference/verse_selection.dart';

void main() {
  for (final type in BiblePlanType.values) {
    final raw =
        jsonDecode(File('source_files/reading_plans/${type.name}.json').readAsStringSync()) as Map<String, dynamic>;
    File('assets/bible_plans/${type.name}.json').writeAsStringSync(
      jsonEncode(
        BiblePlan(
          name: type == .esv_literary_study_bible ? 'Literary Study' : (raw['name'] as String).trim(),
          days: (raw['data2'] as List).map((day) {
            final references = (day as List)
                .cast<String>()
                .expand(
                  (passage) => VerseSelection.parse(
                    passage,
                    bookToName: {
                      .psalms: 'Psalms',
                      .songOfSolomon: 'Song of Songs',
                      .thessalonians1: '1 Thes',
                      .thessalonians2: '2 Thes',
                      .john1: '1 Joh',
                      .john2: '2 Joh',
                      .john3: '3 Joh',
                      .jude: 'Jud',
                    },
                  ).references,
                )
                .toList();
            return BiblePlanDay(passages: VerseSelection.fromReferences(references).splitByChapter());
          }).toList(),
        ).toJson(),
      ),
    );
  }
}
