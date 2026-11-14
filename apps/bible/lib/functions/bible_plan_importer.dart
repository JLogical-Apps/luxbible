import 'dart:convert';

import 'package:bible/models/bible_plan.dart';
import 'package:flutter/services.dart';
import 'package:lux/lux.dart';

class BiblePlanImporter {
  Future<Map<String, BiblePlan>> import() async =>
      await BiblePlanType.values.map((type) async => MapEntry(type.name, await importPlan(type))).waitToMap;

  Future<BiblePlan> importPlan(BiblePlanType type) async =>
      BiblePlan.fromJson(jsonDecode(await rootBundle.loadString(type.assetPath)));
}
