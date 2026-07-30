import 'dart:convert';
import 'dart:isolate';

import 'package:bible/models/commentary.dart';
import 'package:bible/models/commentary_type.dart';
import 'package:flutter/services.dart';

class CommentaryImporter {
  Future<Commentary> import({required CommentaryType type}) async {
    final json = await rootBundle.loadString(type.assetPath);
    return Isolate.run(() => Commentary.fromJson(jsonDecode(json)));
  }
}

extension on CommentaryType {
  String get assetName => switch (this) {
    .matthewHenry => 'matthew_henry',
    .jamiesonFaussetBrown => 'jamieson_fausset_brown',
    .calvin => 'calvin',
  };

  String get assetPath => 'assets/commentary/$assetName.json';
}
