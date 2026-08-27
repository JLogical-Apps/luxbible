import 'package:lux/src/models/bible/bible_translation.dart';
import 'package:lux/src/models/bible/book_type.dart';

abstract final class BibleAssetPaths {
  static String translation(BibleTranslation translation) => 'assets/translations/${translation.name}.json';

  static String book(BibleTranslation translation, BookType book) =>
      'assets/translations/${translation.name}/${book.usxCode()}.json';
}
