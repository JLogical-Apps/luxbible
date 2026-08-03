import 'package:lux/lux.dart';

extension BibleTranslationExtensions on BibleTranslation {
  BibleTranslation effectiveFor(
    BookType book, {
    BibleTranslation oldTestamentTranslation = .oshb,
    BibleTranslation newTestamentTranslation = .statresgnt,
  }) => containsBook(book)
      ? this
      : book.testament == .oldTestament
      ? oldTestamentTranslation
      : newTestamentTranslation;
}
