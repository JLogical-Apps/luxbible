import 'package:lux/lux_core.dart';

extension BibleTranslationExtensions on BibleTranslation {
  BibleTranslation effectiveFor(
    BookType book, {
    BibleTranslation oldTestamentTranslation = .oshb,
    BibleTranslation newTestamentTranslation = .statresgnt,
    BibleTranslation studyTranslation = .bsb,
  }) => containsBook(book)
      ? this
      : missingBooks.has(book)
      ? studyTranslation
      : book.testament == .oldTestament
      ? oldTestamentTranslation
      : newTestamentTranslation;
}
