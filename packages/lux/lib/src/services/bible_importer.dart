import 'dart:convert';

import 'package:lux/src/models/bible/bible.dart';
import 'package:lux/src/models/bible/bible_translation.dart';
import 'package:lux/src/models/bible/book.dart';
import 'package:lux/src/services/bible_asset_paths.dart';
import 'package:flutter/services.dart';

class BibleImporter {
  Future<Bible> importBible({required BibleTranslation translation}) async => switch (translation) {
    .asv ||
    .bsb ||
    .kjv ||
    .oshb ||
    .lxx ||
    .tr ||
    .byz ||
    .statresgnt ||
    .sv ||
    .nrt => await parseStructuredJsonBible(translation: translation),
    _ => throw UnimplementedError(),
  };

  Future<Bible> parseStructuredJsonBible({required BibleTranslation translation}) async {
    final raw = await rootBundle.loadString(BibleAssetPaths.translation(translation));
    return Bible(
      translation: translation,
      books: (jsonDecode(raw) as List).map((bookJson) => Book.fromJson(bookJson)).toList(),
    );
  }
}
