import 'dart:convert';

import 'package:bible/models/strong.dart';
import 'package:flutter/services.dart';
import 'package:utils_core/utils_core.dart';

class StrongImporter {
  Future<Map<String, Strong>> import() async =>
      (jsonDecode(await rootBundle.loadString('assets/strongs/strongs.json')) as List)
          .cast<Map<String, dynamic>>()
          .mapToMap((entry) => MapEntry(entry['i'], Strong.fromJson(entry)));
}
