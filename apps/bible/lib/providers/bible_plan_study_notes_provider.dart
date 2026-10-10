import 'dart:convert';

import 'package:bible/models/bible_plan.dart';
import 'package:bible/models/bible_plan_study_note.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bible_plan_study_notes_provider.g.dart';

@Riverpod(keepAlive: true)
Future<List<BiblePlanStudyNote>> biblePlanStudyNotes(Ref ref, {required String planId}) async {
  final assetPath = BiblePlanType.getById(planId)?.studyNotesAssetPath;
  if (assetPath == null) return [];

  final json = jsonDecode(await rootBundle.loadString(assetPath)) as List;
  return json.map((note) => BiblePlanStudyNote.fromJson(note)).toList();
}
