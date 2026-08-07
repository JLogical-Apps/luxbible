import 'dart:convert';

import 'package:bible/models/bible_plan.dart';
import 'package:flutter/services.dart';
import 'package:lux/lux.dart';

class BiblePlanImporter {
  Future<Map<BiblePlanType, BiblePlan>> import() async => await BiblePlanType.values
      .map((type) async => MapEntry(type, BiblePlan.fromJson(jsonDecode(await rootBundle.loadString(type.assetPath)))))
      .waitToMap;
}
