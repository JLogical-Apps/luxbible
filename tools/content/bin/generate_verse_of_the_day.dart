import 'dart:convert';

import 'package:lux/lux_core.dart';
import 'package:lux_content_tools/repository_paths.dart';

void main() => appAssetFile('verse_of_the_day.json', app: .bible).writeAsStringSync(
  jsonEncode(
    (jsonDecode(sourceFile('verse_of_the_day/daily_light.json').readAsStringSync())['entries'] as List)
        .cast<Map<String, dynamic>>()
        .map((entry) => entry['morning']['osis'][0])
        .map((osisId) => VerseSelection.fromReferences(VerseSelection.fromOsisId(osisId).references).toJson())
        .toList(),
  ),
);
