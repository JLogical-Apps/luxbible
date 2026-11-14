import 'dart:convert';

import 'package:bible/models/bible_plan.dart';
import 'package:bible/models/bible_plan_study_note.dart';
import 'package:collection/collection.dart';
import 'package:flutter/services.dart';
import 'package:lux/lux.dart';

class BiblePlanImporter {
  Future<Map<String, BiblePlan>> import() async =>
      await BiblePlanType.values.map((type) async => MapEntry(type.name, await importPlan(type))).waitToMap;

  Future<BiblePlan> importPlan(BiblePlanType type) async {
    final plan = BiblePlan.fromJson(jsonDecode(await rootBundle.loadString(type.assetPath)));
    if (type.studyNotesAssetPath case final studyNotesAssetPath?) {
      final studyNotes = (jsonDecode(await rootBundle.loadString(studyNotesAssetPath)) as List)
          .map((note) => BiblePlanStudyNote.fromJson(note))
          .toList();
      return plan.copyWith(
        days: plan.days.mapIndexed((index, day) => day.copyWith(studyNote: studyNotes.elementAtOrNull(index))).toList(),
      );
    }
    return plan;
  }
}
