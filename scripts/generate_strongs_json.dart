import 'dart:convert';
import 'dart:io';

import 'package:utils_core/utils_core.dart';
import 'package:xml/xml.dart';

void main() {
  final strongs = [
    ...parseHebrew(File('source_files/strongs/hebrew.xml').readAsStringSync()),
    ...parseGreek(File('source_files/strongs/greek.xml').readAsStringSync()),
  ];
  File('assets/strongs/strongs.json').writeAsStringSync(jsonEncode(strongs));
}

List<Map<String, dynamic>> parseHebrew(String rawXml) {
  final doc = XmlDocument.parse(rawXml);
  return doc
      .findAllElements('div')
      .where((div) => div.getAttribute('type') == 'entry')
      .map((div) {
        final w = div.getElement('w')!;
        final id = w.getAttribute('ID')!;
        final noteEl = guard(() => div.findElements('note').firstWhere((n) => n.getAttribute('type') == 'translation'));
        if (noteEl == null) return null;
        return {
          'i': id,
          'l': w.getAttribute('lemma')!,
          'p': w.getAttribute('POS')!,
          'x': w.getAttribute('xlit')!,
          'd': noteEl.innerText,
          'g':
              div
                  .getElement('foreign')
                  ?.findElements('w')
                  .map((w) => w.getAttribute('gloss')!.replaceAll(':', ''))
                  .toList() ??
              [],
        };
      })
      .nonNulls
      .toList();
}

List<Map<String, dynamic>> parseGreek(String rawXml) {
  final doc = XmlDocument.parse(rawXml);
  return doc
      .findAllElements('entry')
      .map((entry) {
        return guard(() {
          final num = entry.getElement('strongs')!.innerText.trimLeft();
          final id = 'G$num';
          final greek = entry.getElement('greek')!;
          final definition = [
            entry.getElement('strongs_def'),
            entry.getElement('kjv_def'),
          ].nonNulls.map((e) => e.innerText.replaceAll('\n', '')).join('\n');
          final glossary = entry
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
              .toList();
          return {
            'i': id,
            'l': greek.getAttribute('unicode')!,
            'p': entry.getElement('pronunciation')!.getAttribute('strongs')!,
            'x': greek.getAttribute('translit')!,
            'd': definition,
            'g': glossary,
          };
        });
      })
      .nonNulls
      .toList();
}
