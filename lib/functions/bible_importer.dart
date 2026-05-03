import 'package:bible/models/bible/bible_translation.dart';
import 'package:bible/models/bible/book_type.dart';
import 'package:bible/models/bible/display/bible.dart';
import 'package:bible/models/bible/display/book.dart';
import 'package:bible/models/bible/display/chapter.dart';
import 'package:bible/models/bible/display/paragraph.dart';
import 'package:bible/models/bible/display/verse.dart';
import 'package:bible/models/bible/study/bible.dart';
import 'package:bible/models/bible/study/book.dart';
import 'package:bible/models/bible/study/chapter.dart';
import 'package:bible/models/bible/study/study_verse.dart';
import 'package:bible/models/bible/study/verse_fragment.dart';
import 'package:bible/utils/extensions/collection_extensions.dart';
import 'package:bible/utils/toml_helpers.dart';
import 'package:collection/collection.dart';
import 'package:flutter/services.dart';
import 'package:utils_core/utils_core.dart';
import 'package:xml/xml.dart';

class BibleImporter {
  Future<DisplayBible> importDisplay({required BibleTranslation translation}) async {
    return switch (translation) {
      .kjv || .asv => DisplayBible.fromStudy(await parseTomlBible(translation: translation)),
      .bsb => await parseUsxBible(translation: translation),
    };
  }

  Future<StudyBible> importStudy({required BibleTranslation translation}) => parseTomlBible(translation: translation);

  Future<DisplayBible> parseUsxBible({required BibleTranslation translation}) async {
    return DisplayBible(
      translation: translation,
      books: await BookType.values.map((type) async {
        final rawXml = await rootBundle.loadString('assets/translations/${translation.name}/${type.usxCode()}.usx');
        final doc = XmlDocument.parse(rawXml);

        return DisplayBook(
          bookType: type,
          chapters: doc.findAllElements('chapter').mapIndexed((chapterIndex, div) {
            int? lastVerseNum;
            return DisplayChapter(
              paragraphs: div.nextElementSiblings
                  .takeWhile((div) => div.localName != 'chapter')
                  .fold(<Paragraph?>[], (paragraphs, div) {
                    List<DisplayVerse> parseUsxVerses(XmlElement element) => element.children
                        .expand<DisplayVerse>(
                          (node) => switch (node) {
                            XmlText(:final value) when value.trim().isNotEmpty && lastVerseNum != null => [
                              DisplayVerse(verseNum: lastVerseNum!, text: value.trim()),
                            ],
                            XmlElement node when node.localName == 'verse' => () {
                              lastVerseNum = int.parse(node.getAttribute('number')!);
                              return <DisplayVerse>[];
                            }(),
                            XmlElement node when node.localName == 'char' && lastVerseNum != null => parseUsxVerses(
                              node,
                            ),
                            _ => [],
                          },
                        )
                        .withSameVersesCombined()
                        .toList();

                    VersesParagraph? versesParagraph(ParagraphType type) {
                      final previousLastVerseNum = lastVerseNum;
                      final verses = parseUsxVerses(div);
                      if (verses.isEmpty) {
                        return null;
                      }

                      final otherParagraphsWithVerse = paragraphs
                          .whereType<VersesParagraph>()
                          .expand((para) => para.verses)
                          .where((verse) => verse.verseNum == verses.first.verseNum);

                      return VersesParagraph(
                        type: type,
                        verses: verses,
                        firstVerseOffset: verses.first.verseNum == previousLastVerseNum
                            ? otherParagraphsWithVerse.map((verse) => verse.text.length).sum +
                                  // Account for spaces between paragraphs
                                  otherParagraphsWithVerse.length
                            : 0,
                      );
                    }

                    return paragraphs..add(switch (div.getAttribute('style')) {
                      's1' => SectionParagraph(type: .s1, text: div.innerText),
                      's2' => SectionParagraph(type: .s2, text: div.innerText),
                      'p' || 'pmo' || 'pc' => versesParagraph(.p),
                      'd' => versesParagraph(.d),
                      'q1' => versesParagraph(.q1),
                      'q2' => versesParagraph(.q2),
                      'qr' => versesParagraph(.qr),
                      'li1' => versesParagraph(.li1),
                      'li2' => versesParagraph(.li2),
                      'b' => BreakParagraph(),
                      _ => null,
                    });
                  })
                  .nonNulls
                  .toList(),
            );
          }).toList(),
        );
      }).wait,
    );
  }

  Future<StudyBible> parseTomlBible({required BibleTranslation translation}) async {
    final rawToml = await rootBundle.loadString('assets/translations/${translation.name}.toml');
    return StudyBible(
      translation: translation,
      books: rawToml
          .split('\n')
          .batchBy((line) => line.isEmpty)
          .map((lines) {
            final keyParts = lines.first.substring(1, lines.first.length - 1).split('.');
            return MapEntry(
              (BookType.fromTomlKey(keyParts.first), int.parse(keyParts[1])),
              lines
                  .skip(1)
                  .map((line) => line.split(' = '))
                  .mapToMap(
                    (sections) => MapEntry(
                      int.parse(sections.first),
                      StudyVerse(
                        fragments: TomlHelpers.parseNestedArray(
                          sections[1].substring(1, sections[1].length - 1),
                        ).map((list) => VerseFragment(text: list.first, strongIds: list.skip(1).toList())).toList(),
                      ),
                    ),
                  ),
            );
          })
          .groupListsBy((section) => section.key.$1)
          .mapToIterable(
            (book, bookParts) => StudyBook(
              bookType: book,
              chapters: bookParts
                  .groupListsBy((bookPart) => bookPart.key.$2)
                  .mapToIterable((chapterNum, chapterParts) => StudyChapter(verses: chapterParts.first.value))
                  .toList(),
            ),
          )
          .toList(),
    );
  }
}

extension on XmlElement {
  Iterable<XmlElement> get nextElementSiblings sync* {
    var lastChild = nextElementSibling;
    while (lastChild != null) {
      yield lastChild;
      lastChild = lastChild.nextElementSibling;
    }
  }
}

extension on Iterable<DisplayVerse> {
  Iterable<DisplayVerse> withSameVersesCombined() {
    if (isEmpty) {
      return this;
    }

    return fold<List<DisplayVerse>>(<DisplayVerse>[], (verses, verse) {
      final lastVerse = verses.lastOrNull;
      if (lastVerse == null) {
        return verses..add(verse);
      }

      return lastVerse.verseNum == verse.verseNum
          ? (verses
              ..[verses.length - 1] = DisplayVerse(verseNum: verse.verseNum, text: '${lastVerse.text} ${verse.text}'))
          : (verses..add(verse));
    });
  }
}
