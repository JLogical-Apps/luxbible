import 'package:bible/models/strong.dart';
import 'package:bible/utils/extensions/collection_extensions.dart';
import 'package:bible/utils/guard.dart';
import 'package:flutter/services.dart';
import 'package:xml/xml.dart';

class StrongImporter {
  Future<Map<String, Strong>> import() async => {
    ...importHebrew(
      rawHebrewXml: await rootBundle.loadString('assets/strongs/hebrew.xml'),
    ),
    ...importGreek(rawGreekXml: await rootBundle.loadString('assets/strongs/greek.xml')),
  };

  Map<String, Strong> importHebrew({required String rawHebrewXml}) {
    final doc = XmlDocument.parse(rawHebrewXml);
    return doc
        .findAllElements('div')
        .where((div) => div.getAttribute('type') == 'entry')
        .mapToMap(
          (div) => MapEntry(
            div.getElement('w')!.getAttribute('ID')!,
            Strong(
              id: div.getElement('w')!.getAttribute('ID')!,
              languageText: div.getElement('w')!.getAttribute('lemma')!,
              transliteration: div.getElement('w')!.getAttribute('xlit')!,
              pronunciation: div.getElement('w')!.getAttribute('POS')!,
              glossary:
                  div
                      .getElement('foreign')
                      ?.findElements('w')
                      .map((w) => w.getAttribute('gloss')!.replaceAll(':', ''))
                      .toList() ??
                  [],
              definition: div
                  .findElements('note')
                  .firstWhere((note) => note.getAttribute('type') == 'translation')
                  .innerText,
            ),
          ),
        )
        .withoutNullValues;
  }

  Map<String, Strong> importGreek({required String rawGreekXml}) {
    final doc = XmlDocument.parse(rawGreekXml);
    return doc
        .findAllElements('entry')
        .mapToMap(
          (entry) => MapEntry(
            'G${entry.getElement('strongs')!.innerText}',
            guard(
              () => Strong(
                id: 'G${entry.getElement('strongs')!.innerText}',
                languageText: entry.getElement('greek')!.getAttribute('unicode')!,
                transliteration: entry.getElement('greek')!.getAttribute('translit')!,
                pronunciation: entry
                    .getElement('pronunciation')!
                    .getAttribute('strongs')!,
                glossary: entry
                    .findAllElements('see')
                    .map(
                      (see) =>
                          switch (see.getAttribute('language')!) {
                            'HEBREW' => 'H',
                            'GREEK' => 'G',
                            _ => throw UnimplementedError(),
                          } +
                          see.getAttribute('strongs').toString(),
                    )
                    .toList(),
                definition: [
                  entry.getElement('strongs_def'),
                  entry.getElement('kjv_def'),
                ].nonNulls.map((e) => e.innerText.replaceAll('\n', '')).join('\n'),
              ),
            ),
          ),
        )
        .withoutNullValues;
  }
}
