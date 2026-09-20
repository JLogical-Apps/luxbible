import 'dart:convert';
import 'dart:isolate';

import 'package:flutter/services.dart';
import 'package:lux/src/models/bible/bible.dart';
import 'package:lux/src/models/bible/bible_translation.dart';
import 'package:lux/src/models/bible/book.dart';
import 'package:lux/src/models/bible/book_type.dart';
import 'package:lux/src/services/bible_asset_paths.dart';

class BibleImporter {
  Future<Bible> importBible({required BibleTranslation translation}) async {
    translation.throwIfLicenseExpired();
    return translation.isLocal ? await parseStructuredJsonBible(translation: translation) : throw UnimplementedError();
  }

  Future<Book> importBook({required BibleTranslation translation, required BookType book}) async {
    translation.throwIfLicenseExpired();
    return translation.isLocal
        ? await parseStructuredJsonBook(translation: translation, book: book)
        : throw UnimplementedError();
  }

  Future<Bible> parseStructuredJsonBible({required BibleTranslation translation}) async {
    final raw = await rootBundle.loadString(BibleAssetPaths.translation(translation));
    return Bible(
      translation: translation,
      books: await Isolate.run(() => (jsonDecode(raw) as List).map((bookJson) => Book.fromJson(bookJson)).toList()),
    );
  }

  Future<Book> parseStructuredJsonBook({required BibleTranslation translation, required BookType book}) async {
    final raw = await rootBundle.loadString(BibleAssetPaths.book(translation, book));
    return Isolate.run(() => Book.fromJson({...jsonDecode(raw), 'b': book.name}));
  }
}
