import 'dart:convert';

import 'package:bible/models/dictionary_entry.dart';
import 'package:lux/lux.dart';
import 'package:flutter/services.dart';

class DictionaryImporter {
  Future<Map<String, DictionaryEntry>> import() async =>
      (jsonDecode(await rootBundle.loadString('assets/dictionary/easton.json')) as Map<String, dynamic>).map(
        (title, definitions) => MapEntry(
          title.withCollapsedWhitespace.toUpperCase(),
          DictionaryEntry(title: title, definitions: Markdown.fromJsonList(definitions)),
        ),
      );
}
