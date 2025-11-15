import 'package:bible/models/strong.dart';
import 'package:bible/utils/extensions/collection_extensions.dart';
import 'package:bible/utils/guard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:xml/xml.dart';

class StrongImporter {
  Future<Map<String, Strong>> import() async {
    final out = {
      ...importGreek(
        rawGreekXml: await rootBundle.loadString('assets/strongs/greek.xml'),
      ),
      ...importHebrew(
        rawHebrewXml: await rootBundle.loadString('assets/strongs/hebrew.xml'),
      ),
    };
    debugPrint(out.toString());
    return out;
  }

  Map<String, Strong> importGreek({required String rawGreekXml}) {
    final doc = XmlDocument.parse(rawGreekXml);
    return doc.findAllElements('entry').mapToMap((entry) {
      try {
        return MapEntry(
          'G${entry.getElement('strongs')!.innerText}',
          guard(
            () => Strong(
              id: 'G${entry.getElement('strongs')!.innerText}',
              languageText: entry.getElement('greek')!.getAttribute('unicode')!,
              transliteration: entry.getElement('greek')!.getAttribute('translit')!,
              pronunciation: entry.getElement('pronunciation')!.getAttribute('strongs')!,
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
              ].nonNulls.map((e) => e.innerText).join(', '),
            ),
          ),
        );
      } catch (e) {
        print('${entry.getElement('strongs')}: $e');
        rethrow;
      }
    }).withoutNullValues;
  }

  Map<String, Strong> importHebrew({required String rawHebrewXml}) {
    final doc = XmlDocument.parse(rawHebrewXml);
    return {};
  }
}
