import 'package:bible/models/bible/book.dart';
import 'package:bible/models/bible/book_type.dart';
import 'package:bible/models/bible/interlinear_data.dart';
import 'package:bible/utils/usx_utils.dart';
import 'package:bible/utils/xml_bible_parser.dart';
import 'package:collection/collection.dart';
import 'package:utils_core/utils_core.dart';
import 'package:xml/xml.dart';

Book parseUsxBook(BookType type, String rawXml) {
  final document = XmlDocument.parse(rawXml);
  return Book(
    bookType: type,
    chapters: document.findAllElements('chapter').map((chapter) {
      final elements = chapter.nextElementSiblings.takeWhile(
        (element) => element.localName != 'chapter',
      );
      return XmlBibleParser.parse(
        elements,
        getVerseNumber: (element) => element.localName == 'verse'
            ? int.parse(element.getAttribute('number')!)
            : null,
        shouldIgnore: (element) => false,
        buildFootnote: (element) =>
            element.localName == 'note' && element.getAttribute('style') == 'f'
            ? UsxUtils.noteToMarkdown(element)
            : null,
        isRedLetters: (element) => element.getAttribute('style') == 'wj',
        isItalic: (element) =>
            UsxUtils.isItalicStyle(element.getAttribute('style')),
        getInterlinearData: (element) => element.getAttribute('style') == 'w'
            ? InterlinearData(
                originalPosition: int.parse(
                  element.getAttribute('x-position')!,
                ),
                inflection: element.getAttribute('x-lemma'),
                morphology: switch (element.getAttribute('x-morph')) {
                  'None' => null,
                  final morphology => morphology,
                },
                strongId: element.getAttribute('strong')?.nullIfBlank,
                transliteration: element.getAttribute('x-translit'),
              )
            : null,
        getParagraphStyle: (element) =>
            element.getAttribute('style') ?? element.classNames.firstOrNull,
        buildSectionText: (element) => element.innerText.trim(),
        buildText: (text) => text,
      );
    }).toList(),
  );
}

extension on XmlElement {
  Iterable<XmlElement> get nextElementSiblings sync* {
    var element = nextElementSibling;
    while (element != null) {
      yield element;
      element = element.nextElementSibling;
    }
  }
}
