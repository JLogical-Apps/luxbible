import 'dart:convert';
import 'dart:io';

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
  final strongIds = baseStrongs.map((strong) => strong['i'] as String).toSet();
  final bdbThayer = parseLexicon('source_files/sword/lexicon/bdbthayerstrongkjctvm.lexi.json');
  final strongsPlus = parseLexicon('source_files/sword/lexicon/strongsplus.lexi.json');
  final strongs = baseStrongs
      .map(
        (strong) => enrichStrong(
          strong,
          bdbThayer: bdbThayer[strong['i']]!,
          strongsPlus: strongsPlus[strong['i']]!,
          strongIds: strongIds,
        ),
      )
      .toList();

  if (strongs.length != 14197 || strongs.any(hasInvalidMarkdown)) {
    throw StateError('Generated Strong data failed validation');
  }
  File('assets/strongs/strongs.json').writeAsStringSync(jsonEncode(strongs));
}

Map<String, String> parseLexicon(String path) => Map.fromEntries(
  ((jsonDecode(File(path).readAsStringSync()) as Map<String, dynamic>)['entries'] as List)
      .cast<Map<String, dynamic>>()
      .map((entry) => MapEntry(entry['topic'] as String, entry['definition'] as String)),
);

Map<String, dynamic> enrichStrong(
  Map<String, dynamic> strong, {
  required String bdbThayer,
  required String strongsPlus,
  required Set<String> strongIds,
}) {
  final bdbParagraphs = parseFragment(bdbThayer).querySelectorAll('p');
  final plusParagraphs = parseFragment(strongsPlus).querySelectorAll('p');
  final definitionIndex = bdbParagraphs.indexWhere((paragraph) => paragraph.text.trim().startsWith('- Definition:'));
  final originIndex = bdbParagraphs.indexWhere((paragraph) => paragraph.text.trim().startsWith('- Origin:'));
  if (definitionIndex < 0) {
    throw FormatException('Missing definition metadata for ${strong['i']}');
  }
  final lexiconDefinition = bdbParagraphs
      .sublist(definitionIndex, originIndex < 0 ? bdbParagraphs.length : originIndex)
      .map(toMarkdown)
      .mapIndexed((index, paragraph) => index == 0 ? stripLabel(paragraph, 'Definition') : paragraph)
      .where((paragraph) => paragraph.isNotEmpty)
      .join('\n');
  final derivation = optionalField(bdbParagraphs, 'Origin');
  final partOfSpeech = cleanPartOfSpeech(optionalField(bdbParagraphs, 'Part(s) of speech'));
  final lexiconReference = ['TDNT', 'TWOT']
      .map((name) => optionalField(bdbParagraphs, '$name entry'))
      .nonNulls
      .where((value) => value.toLowerCase() != 'none')
      .map((value) => '${strong['i'].toString().startsWith('G') ? 'TDNT' : 'TWOT'} $value')
      .firstOrNull;
  final lxxIndex = plusParagraphs.indexWhere((paragraph) => paragraph.text.contains('LXX related word'));
  final descriptionEnd = lxxIndex < 0 ? plusParagraphs.length : lxxIndex;
  final description = plusParagraphs.length > 3
      ? plusParagraphs.sublist(3, descriptionEnd).map(toMarkdown).where((paragraph) => paragraph.isNotEmpty).join('\n')
      : toMarkdown(plusParagraphs.last).replaceFirst(RegExp(r'^\*[^*]+\*'), '');
  final sourceDefinition = strong['i'].toString().startsWith('H')
      ? strong['d'] as String
      : cleanGreekDefinition(lexiconDefinition);
  final definition = sourceDefinition.isEmpty ? description : sourceDefinition;
  final relatedStrongIds = {
    ...(strong['g'] as List<String>),
    ...strongIdPattern.allMatches([description, ?derivation].join(' ')).map((match) => match.group(0)!),
    if (lxxIndex >= 0)
      ...plusParagraphs
          .skip(lxxIndex + 1)
          .expand((paragraph) => strongIdPattern.allMatches(paragraph.text))
          .map((match) => match.group(0)!),
  }.where((strongId) => strongIds.contains(strongId) && strongId != strong['i']).toList();

  return {
    ...strong,
    'd': definition,
    's': description,
    'o': ?derivation,
    't': ?partOfSpeech,
    'r': ?lexiconReference,
    'g': relatedStrongIds,
    'k': parseKjvUsage(bdbParagraphs),
  };
}

final strongIdPattern = RegExp(r'\b[GH]\d+\b');

String? optionalField(List<Element> paragraphs, String label) {
  final paragraph = paragraphs.where((paragraph) => paragraph.text.trim().startsWith('- $label:')).firstOrNull;
  if (paragraph == null) return null;
  final value = stripLabel(toMarkdown(paragraph), label).trim();
  return value.isEmpty ? null : value;
}

String stripLabel(String markdown, String label) =>
    markdown.replaceFirst(RegExp('^- ${RegExp.escape(label)}:\\s*'), '');

String? cleanPartOfSpeech(String? value) {
  final cleaned = value?.replaceAll(RegExp(r'\s*,?NULL\);?'), '').replaceAll(RegExp(r'\s+par$'), '').trim();
  return cleaned == null || cleaned.isEmpty ? null : cleaned;
}

String cleanGreekDefinition(String definition) =>
    definition.split('\n').map((line) => line.replaceFirst(RegExp(r' \d+[a-z]$'), '')).join('\n');

Map<String, int> parseKjvUsage(List<Element> paragraphs) => paragraphs
    .map((paragraph) => paragraph.text.trim())
    .map((text) => RegExp(r'^•\s*(.+),\s*(\d+)$').firstMatch(text))
    .nonNulls
    .fold(
      <String, int>{},
      (usage, match) => usage
        ..update(
          match.group(1)!,
          (count) => count + int.parse(match.group(2)!),
          ifAbsent: () => int.parse(match.group(2)!),
        ),
    );

String toMarkdown(Element element) {
  final marginLeft = RegExp(r'margin-left:\s*(\d+)pt').firstMatch(element.attributes['style'] ?? '')?.group(1);
  final indentation = switch (marginLeft) {
    '26' => '  ',
    '39' => '    ',
    _ => '',
  };
  return '$indentation${element.nodes.map(nodeToMarkdown).join().trim()}';
}

String nodeToMarkdown(Node node) => switch (node) {
  Text() => linkStrongIds(escapeMarkdown(node.data)),
  Element(localName: 'b' || 'strong') => '**${node.nodes.map(nodeToMarkdown).join()}**',
  Element(localName: 'i' || 'em') => '*${node.nodes.map(nodeToMarkdown).join()}*',
  Element(localName: 'a') => () {
    final text = node.nodes.map(nodeToMarkdownWithoutLinks).join();
    final strongId = strongIdPattern.firstMatch('${node.attributes['href']} $text')?.group(0);
    return strongId == null ? text : '[${text.isEmpty ? strongId : text}]($strongId)';
  }(),
  Element(localName: 'br') => '\n',
  Element() => node.nodes.map(nodeToMarkdown).join(),
  _ => '',
};

String nodeToMarkdownWithoutLinks(Node node) => switch (node) {
  Text() => escapeMarkdown(node.data),
  Element() => node.nodes.map(nodeToMarkdownWithoutLinks).join(),
  _ => '',
};

String escapeMarkdown(String text) =>
    text.replaceAll(r'\', r'\\').replaceAll('*', r'\*').replaceAll('[', r'\[').replaceAll(']', r'\]');

String linkStrongIds(String text) =>
    text.replaceAllMapped(strongIdPattern, (match) => '[${match.group(0)}](${match.group(0)})');

bool hasInvalidMarkdown(Map<String, dynamic> strong) => [
  strong['d'],
  strong['s'],
  strong['o'],
].whereType<String>().any((value) => RegExp(r'<[^>]+>|&(?:#\d+|\w+);').hasMatch(value));

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
    .map((item) {
      final text = item.innerText.trim().replaceAll('——-', '-----').replaceAll(RegExp(r'\s+'), ' ');
      final match = RegExp(r'^(\d+(?:[a-z]\d*)*)\)\s*(.*)$').firstMatch(text);
      if (match == null) return text;
      final hierarchy = RegExp(r'\d+|[a-z]').allMatches(match.group(1)!).map((match) => match.group(0)!).toList();
      final indentation = List.filled((hierarchy.length - 1) * 2, ' ').join();
      return '$indentation**${hierarchy.last}.** ${match.group(2)}';
    })
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
