import 'dart:convert';
import 'dart:isolate';

import 'package:bible/models/commentary.dart';
import 'package:bible/models/commentary_type.dart';
import 'package:flutter/services.dart';
import 'package:lux/lux_core.dart';

class CommentaryImporter {
  Future<CommentaryBook> import({required CommentaryType type, required BookType book}) async {
    final json = await rootBundle.loadString(type.getAssetPath(book), cache: false);
    return Isolate.run(() => CommentaryBook.fromJson(jsonDecode(json)));
  }
}

extension on CommentaryType {
  String get assetName => switch (this) {
    .tyndale => 'tyndale',
    .matthewHenry => 'matthew_henry',
    .jamiesonFaussetBrown => 'jamieson_fausset_brown',
    .calvin => 'calvin',
  };

  String getAssetPath(BookType book) => 'assets/commentary/$assetName/${book.usxCode()}.json';
}
