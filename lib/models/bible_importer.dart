import 'package:bible/models/bible.dart';
import 'package:bible/models/book.dart';
import 'package:bible/models/book_type.dart';
import 'package:bible/models/chapter.dart';
import 'package:bible/models/verse.dart';
import 'package:collection/collection.dart';
import 'package:flutter/services.dart';
import 'package:xml/xml.dart';

class BibleImporter {
  Future<Bible> import({required String name}) async {
    final rawXml = await rootBundle.loadString('assets/$name.xml');
    final document = XmlDocument.parse(rawXml);
    return Bible(
      books: document
          .findAllElements('div')
          .where((div) => div.getAttribute('type') == 'book')
          .mapIndexed(
            (i, div) => Book(
              bookType: BookType.values[i],
              chapters: div
                  .findAllElements('chapter')
                  .map(
                    (chapter) => Chapter(
                      verses: chapter
                          .findAllElements('verse')
                          .map((verse) => Verse(text: verse.innerText))
                          .toList(),
                    ),
                  )
                  .toList(),
            ),
          )
          .toList(),
    );
  }
}
