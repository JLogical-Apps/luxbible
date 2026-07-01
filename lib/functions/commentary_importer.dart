import 'dart:convert';

import 'package:bible/models/commentary.dart';
import 'package:bible/models/commentary_type.dart';
import 'package:bible/utils/extensions/collection_extensions.dart';
import 'package:flutter/services.dart';

class CommentaryImporter {
  Future<Map<CommentaryType, Commentary>> import() async => CommentaryType.values
      .map((type) async => MapEntry(type, Commentary.fromJson(jsonDecode(await rootBundle.loadString(type.assetPath)))))
      .waitToMap;
}

extension on CommentaryType {
  String get assetName => switch (this) {
    .matthewHenry => 'matthew_henry',
    .jamiesonFaussetBrown => 'jamieson_fausset_brown',
    .calvin => 'calvin',
  };

  String get assetPath => 'assets/commentary/$assetName.json';
}
