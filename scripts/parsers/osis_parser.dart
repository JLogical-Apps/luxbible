import 'package:bible/models/bible/book.dart';
import 'package:bible/models/bible/book_type.dart';
import 'package:bible/models/bible/chapter.dart';
import 'package:bible/models/bible/paragraph.dart';
import 'package:bible/models/bible/verse.dart';
import 'package:bible/models/bible/word.dart';
import 'package:bible/models/reference/reference.dart';
import 'package:collection/collection.dart';
import 'package:xml/xml.dart';

Book parseOsisBook(String rawXml, {bool verseParagraphs = false}) {
  final bookElement = XmlDocument.parse(rawXml).rootElement.findElements('div').first;

  bool isParagraphMarker(XmlElement element) => element.localName == 'milestone'
      ? (element.getAttribute('type')?.contains('x-p') ?? false) || element.getAttribute('marker') == '¶'
      : element.localName == 'div' && element.getAttribute('type') == 'x-p';

  // Plain surface text: `<w>`/`<seg>` content and the whitespace between, with
  // `<note>`, `<title>`, and other markup stripped.
  String verseText(XmlNode node) => node.children
      .map(
        (child) => switch (child) {
          XmlText(:final value) => value,
          XmlElement(:final localName) when const {'note', 'title', 'milestone'}.contains(localName) => null,
          XmlElement() when child.getAttribute('type') == 'x-variant' && child.getAttribute('subType') == 'x-2' => null,
          _ => verseText(child),
        },
      )
      .nonNulls
      .join()
      .replaceAll(RegExp(r'\s+'), ' ')
      .trim();

  return Book(
    bookType: BookType.fromOsisId(bookElement.getAttribute('osisID')!),
    chapters: bookElement
        .findElements('verse')
        .groupListsBy((verse) => int.parse(verse.getAttribute('osisID')!.split('.')[1]))
        .values
        .map((verseElements) {
          var current = <Verse>[];
          return Chapter(
            paragraphs: verseElements.fold(<Paragraph>[], (paragraphs, verseElement) {
              void flush() {
                if (current.isNotEmpty) {
                  paragraphs.add(VersesParagraph(type: .p, verses: current));
                  current = [];
                }
              }

              // A section heading or paragraph marker starts a new block.
              for (final title in verseElement.descendants.whereType<XmlElement>().where(
                (e) => e.localName == 'title',
              )) {
                flush();
                paragraphs.add(SectionParagraph(type: .s1, text: title.innerText.trim()));
              }
              if (verseElement.descendants.whereType<XmlElement>().any(isParagraphMarker)) flush();

              final text = verseText(verseElement);
              if (text.isNotEmpty) {
                final id = verseElement.getAttribute('osisID')!.split('.');
                final origin = verseElement.getAttribute('origin');
                current.add(
                  Verse(
                    verseNum: int.parse(id[2]),
                    words: [Word(text: text)],
                    originalVerse: origin == null ? null : Reference.fromOsisId(origin),
                  ),
                );
                if (verseParagraphs) flush();
              }
              if (verseElement == verseElements.last) flush();

              return paragraphs;
            }),
          );
        })
        .toList(),
  );
}
