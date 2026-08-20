import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:lux/lux.dart';

class VerseOfTheDayImporter {
  Future<List<VerseSelection>> import() async =>
      (jsonDecode(await rootBundle.loadString('assets/verse_of_the_day.json')) as List)
          .cast<String>()
          .map(VerseSelection.fromJson)
          .toList();
}
