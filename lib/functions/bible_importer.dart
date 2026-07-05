import 'dart:convert';

import 'package:bible/models/bible/bible.dart';
import 'package:bible/models/bible/bible_translation.dart';
import 'package:bible/models/bible/book.dart';
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
    .sv => await parseStructuredJsonBible(translation: translation),
    _ => throw UnimplementedError(),
  };

  Future<Bible> parseStructuredJsonBible({required BibleTranslation translation}) async {
    final raw = await rootBundle.loadString('assets/translations/${translation.name}.json');
    return Bible(
      translation: translation,
      books: (jsonDecode(raw) as List).map((bookJson) => Book.fromJson(bookJson)).toList(),
    );
  }
}
