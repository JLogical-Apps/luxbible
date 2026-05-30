import 'dart:convert';

import 'package:bible/models/commentary.dart';
import 'package:flutter/services.dart';

class CommentaryImporter {
  Future<Commentary> import() async =>
      Commentary.fromJson(jsonDecode(await rootBundle.loadString('assets/commentary/matthew_henry.json')));
}
