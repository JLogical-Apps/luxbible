import 'dart:convert';
import 'dart:io';

import 'package:bible/utils/extensions/collection_extensions.dart';
import 'package:bible/utils/extensions/string_extensions.dart';
import 'package:bible/utils/markdown_utils.dart';
import 'package:collection/collection.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:utils_core/utils_core.dart';
import 'package:xml/xml.dart';

void main() {
  final baseStrongs = [
    ...parseHebrew(File('source_files/strongs/hebrew.xml').readAsStringSync()),
    ...parseGreek(File('source_files/strongs/greek.xml').readAsStringSync()),
  ];

  final bdbThayer = parseLexicon('source_files/sword/lexicon/bdbthayerstrongkjctvm.lexi.json');
  final strongsPlus = parseLexicon('source_files/sword/lexicon/strongsplus.lexi.json');

  final strongIds = baseStrongs.map((strong) => strong['i'] as String).toSet();

  File('assets/strongs/strongs.json').writeAsStringSync(
    jsonEncode(
      baseStrongs
          .map(
            (strong) => enrichStrong(
              strong,
              bdbThayerXml: bdbThayer[strong['i']]!,
              strongsPlusXml: strongsPlus[strong['i']]!,
              strongIds: strongIds,
            ),
          )
          .toList(),
    ),
  );
}

Map<String, String> parseLexicon(String path) => (jsonDecode(File(path).readAsStringSync())['entries'] as List)
    .cast<Map<String, dynamic>>()
    .map((entry) => MapEntry(entry['topic'] as String, entry['definition'] as String))
    .toMap();

Map<String, dynamic> enrichStrong(
  Map<String, dynamic> strong, {
  required String bdbThayerXml,
  required String strongsPlusXml,
  required Set<String> strongIds,
}) {
  final bdbParagraphs = parseFragment(bdbThayerXml).querySelectorAll('p');
  final plusParagraphs = parseFragment(strongsPlusXml).querySelectorAll('p');

  final definitionIndex =
      bdbParagraphs.indexWhereOrNull((paragraph) => paragraph.text.trim().startsWith('- Definition:')) ??
      (throw FormatException('Missing definition metadata for ${strong['i']}'));

  final originIndex = bdbParagraphs.indexWhereOrNull((paragraph) => paragraph.text.trim().startsWith('- Origin:'));

  final lexiconDefinition = bdbParagraphs
      .sublist(definitionIndex, originIndex ?? bdbParagraphs.length)
      .map((element) => element.toMarkdown())
      .mapIndexed((index, paragraph) => index == 0 ? paragraph.withoutLabel('Definition') : paragraph)
      .where((paragraph) => paragraph.isNotEmpty)
      .join('\n');

  final derivation = optionalField(bdbParagraphs, 'Origin');
  final partOfSpeech = optionalField(bdbParagraphs, 'Part(s) of speech')?.cleanedPartOfSpeech;
  final lexiconReference = ['TDNT', 'TWOT']
      .map((name) => optionalField(bdbParagraphs, '$name entry'))
      .nonNulls
      .where((value) => value.toLowerCase() != 'none')
      .map((value) => '${strong['i'].toString().startsWith('G') ? 'TDNT' : 'TWOT'} $value')
      .firstOrNull;

  final lxxIndex = plusParagraphs.indexWhereOrNull((paragraph) => paragraph.text.contains('LXX related word'));
  final description = plusParagraphs.length > 3
      ? plusParagraphs
            .sublist(3, lxxIndex ?? plusParagraphs.length)
            .map((element) => element.toMarkdown())
            .where((paragraph) => paragraph.isNotEmpty)
            .join('\n')
      : plusParagraphs.last.toMarkdown().withoutLeadingItalicText;

  final sourceDefinition = strong['i'].toString().startsWith('H')
      ? strong['d'] as String
      : lexiconDefinition.withoutTrailingHierarchyMarkers;
  final definition = sourceDefinition.nullIfBlank ?? description;

  final relatedStrongIds = {
    ...(strong['g'] as List<String>),
    ...[description, ?derivation].join(' ').strongIds,
    if (lxxIndex != null) ...plusParagraphs.skip(lxxIndex + 1).expand((paragraph) => paragraph.text.strongIds),
  }.where((strongId) => strongIds.contains(strongId) && strongId != strong['i']).toList();

  return {
    ...strong,
    'd': definition,
    's': description,
    'o': ?derivation,
    't': ?partOfSpeech,
    'r': ?lexiconReference,
    'g': relatedStrongIds,
    'k': bdbParagraphs
        .map((paragraph) => paragraph.text.trim())
        .map((text) => text.kjvUsage)
        .nonNulls
        .fold(
          <String, int>{},
          (usage, entry) => usage..update(entry.word, (count) => count + entry.count, ifAbsent: () => entry.count),
        ),
  };
}

String? optionalField(List<Element> paragraphs, String label) => paragraphs
    .firstWhereOrNull((paragraph) => paragraph.text.trim().startsWith('- $label:'))
    ?.toMarkdown()
    .withoutLabel(label)
    .trim()
    .nullIfBlank;

List<Map<String, dynamic>> parseHebrew(String rawXml) {
  final doc = XmlDocument.parse(rawXml);
  return doc
      .findAllElements('div')
      .where((div) => div.getAttribute('type') == 'entry')
      .map((div) {
        final w = div.getElement('w')!;
        final id = w.getAttribute('ID')!;
        final definition = parseHebrewDefinition(div);
        if (definition.isEmpty) return null;
        return {
          'i': id,
          'l': w.getAttribute('lemma')!,
          'p': w.getAttribute('POS')!,
          'x': w.getAttribute('xlit')!,
          'd': definition,
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

String parseHebrewDefinition(XmlElement div) => div
    .getElement('list')!
    .findElements('item')
    .map((item) => item.innerText.trim().replaceAll('——-', '-----').withCollapsedWhitespace.asHebrewDefinitionMarkdown)
    .join('\n');

List<Map<String, dynamic>> parseGreek(String rawXml) {
  final doc = XmlDocument.parse(rawXml);
  return doc
      .findAllElements('entry')
      .map(
        (entry) => guard(() {
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
        }),
      )
      .nonNulls
      .toList();
}

extension on String {
  String get withoutLeadingItalicText => replaceFirst(RegExp(r'^\*[^*]+\*'), '');

  String withoutLabel(String label) => replaceFirst(RegExp('^- ${RegExp.escape(label)}:\\s*'), '');

  String? get cleanedPartOfSpeech =>
      replaceAll(RegExp(r'\s*,?NULL\);?'), '').replaceAll(RegExp(r'\s+par$'), '').trim().nullIfBlank;

  String get withoutTrailingHierarchyMarkers =>
      split('\n').map((line) => line.replaceFirst(RegExp(r' \d+[a-z]$'), '')).join('\n');

  ({String word, int count})? get kjvUsage => switch (RegExp(r'^•\s*(.+),\s*(\d+)$').firstMatch(this)) {
    final match? => (word: match.group(1)!, count: int.parse(match.group(2)!)),
    _ => null,
  };

  List<String> get strongIds => strongIdOccurrences.map((match) => match.id).toList();

  List<({String id, int start, int end})> get strongIdOccurrences => RegExp(
    r'\b[GH]\d+\b',
  ).allMatches(this).map((match) => (id: match.group(0)!, start: match.start, end: match.end)).toList();

  int get strongsIndentation => switch (RegExp(r'margin-left:\s*(\d+)pt').firstMatch(this)?.group(1)) {
    '26' => 2,
    '39' => 4,
    _ => 0,
  };

  String get asHebrewDefinitionMarkdown {
    final match = RegExp(r'^(\d+(?:[a-z]\d*)*)\)\s*(.*)$').firstMatch(this);
    if (match == null) {
      return this;
    }

    final hierarchy = RegExp(r'\d+|[a-z]').allMatches(match.group(1)!).map((match) => match.group(0)!).toList();
    final indentation = List.filled((hierarchy.length - 1) * 2, '\t').join();
    return '$indentation**${hierarchy.last}.** ${match.group(2)}';
  }
}

extension on Element {
  String toMarkdown() => MarkdownUtils.fromHtml(
    this,
    (element, children) => switch (element.localName) {
      'p' => [.indented((element.attributes['style'] ?? '').strongsIndentation, children)],
      'b' || 'strong' => [.bold(children)],
      'i' || 'em' => [.italic(children)],
      'a' => () {
        final text = children.plainText;
        final strongId = '${element.attributes['href']} $text'.strongIds.firstOrNull;
        return strongId == null
            ? [MarkdownElement.text(text)]
            : [
                MarkdownElement.link(strongId, [.text(text.isEmpty ? strongId : text)]),
              ];
      }(),
      'br' => [.lineBreak()],
      _ => children,
    },
    buildText: (text) {
      final matches = text.strongIdOccurrences.toList();
      return [
        ...matches.mapIndexed((index, match) {
          final gapStart = index == 0 ? 0 : matches[index - 1].end;
          return [
            if (match.start > gapStart) MarkdownElement.text(text.substring(gapStart, match.start)),
            MarkdownElement.link(match.id, [.text(match.id)]),
          ];
        }).flattened,
        if ((matches.lastOrNull?.end ?? 0) < text.length)
          MarkdownElement.text(text.substring(matches.lastOrNull?.end ?? 0)),
      ];
    },
    textEscaping: .all,
  );
}
