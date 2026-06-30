import 'dart:convert';

import 'package:bible/models/dictionary_entry.dart';
import 'package:flutter/services.dart';

class DictionaryImporter {
  Future<Map<String, DictionaryEntry>> import() async =>
      (jsonDecode(await rootBundle.loadString('assets/dictionary/easton.json')) as Map<String, dynamic>).map(
        (key, entry) => MapEntry(key, DictionaryEntry.fromJson(entry)),
      );
}
