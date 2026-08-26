import 'package:collection/collection.dart';
import 'package:lux/lux_core.dart';
import 'package:utils_core/utils_core.dart';
import 'package:xml/xml.dart';

Book parseUsxBook(
  BookType type,
  String rawXml, {
  bool includeInterlinear = true,
  bool Function(XmlElement)? shouldIgnoreElement,
  String Function(String) transformText = _defaultTransformText,
}) {
  final document = XmlDocument.parse(rawXml);
  return Book(
    bookType: type,
    chapters: document.findAllElements('chapter').where((chapter) => chapter.getAttribute('number') != null).map((
      chapter,
    ) {
      final elements = chapter.nextElementSiblings.takeWhile((element) => element.localName != 'chapter');
      return XmlBibleParser.parse(
        elements,
        getVerseNumber: (element) => switch ((element.localName, element.getAttribute('number'))) {
          ('verse', final number?) => int.parse(number),
          _ => null,
        },
        shouldIgnore: shouldIgnoreElement ?? (_) => false,
        buildFootnote: (element) => element.localName == 'note' && element.getAttribute('style') == 'f'
            ? UsxUtils.noteToMarkdown(element)
            : null,
        isRedLetters: (element) => element.getAttribute('style') == 'wj',
        isItalic: (element) => UsxUtils.isItalicStyle(element.getAttribute('style')),
        isUppercase: (_) => false,
        getInterlinearData: includeInterlinear
            ? ((element) => element.getAttribute('style') == 'w'
                  ? InterlinearData(
                      originalPosition: int.parse(element.getAttribute('x-position')!),
                      inflection: element.getAttribute('x-lemma'),
                      morphology: switch (element.getAttribute('x-morph')) {
                        'None' => null,
                        final morphology => morphology,
                      },
                      strongId: element.getAttribute('strong')?.nullIfBlank,
                      transliteration: element.getAttribute('x-translit'),
                    )
                  : null)
            : null,
        getParagraphStyle: (element) => element.getAttribute('style') ?? element.classNames.firstOrNull,
        buildSectionText: (element) => transformText(element.innerText).trim(),
        buildText: transformText,
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

String _defaultTransformText(String text) => text;
