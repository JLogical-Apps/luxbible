import 'dart:convert';

import 'package:bible/models/dictionary_entry.dart';
import 'package:collection/collection.dart';
import 'package:lux/lux_core.dart';
import 'package:lux_content_tools/repository_paths.dart';
import 'package:utils_core/utils_core.dart';
import 'package:xml/xml.dart';

void main() {
  final terms = XmlDocument.parse(
    sourceFile('dictionary/easton.xml').readAsStringSync(),
  ).findAllElements('term').toList();

  final keyLookup = buildKeyLookup(terms);

  appAssetFile('dictionary/easton.json', app: .bible).writeAsStringSync(
    jsonEncode(
      terms
          .map(
            (term) => MapEntry(
              getEntryKey(term),
              DictionaryEntry(
                title: term.innerText.trim(),
                definitions: [getEastonMarkdown(term.nextElementSibling!, keyLookup)],
              ),
            ),
          )
          .groupListsBy((entry) => entry.key)
          .mapValues(
            (key, entries) => DictionaryEntry(
              title: entries.first.value.title,
              definitions: entries.expand((entry) => entry.value.definitions).toList(),
            ),
          )
          .map((key, entry) => MapEntry(entry.title, Markdown.toJsonList(entry.definitions))),
    ),
  );
}

Markdown getEastonMarkdown(XmlElement definition, Map<String, String> keyLookup) {
  expandFragmentedDictionaryReferences(definition, keyLookup);
  return Markdown(
    Markdown.fromXmlNodes(
      definition.children.where((node) => node is! XmlText || node.value.trim().isNotEmpty),
      (element, children) => switch (element.name.local) {
        'p' => [.paragraph(children)],
        'i' => [.italic(children)],
        'scripRef' => getScriptureReference(element, children),
        'a' => getDictionaryReference(children, keyLookup),
        _ => children,
      },
      textEscaping: .all,
    ).text.formatListMarkers.trim(),
  );
}

List<MarkdownElement> getScriptureReference(XmlElement element, List<MarkdownElement> children) {
  final target = element.getAttribute('osisRef')?.replaceAll('Bible:', '');
  return target != null && VerseSelection.isOsisId(target) ? [.link(target, children)] : children;
}

List<MarkdownElement> getDictionaryReference(List<MarkdownElement> children, Map<String, String> keyLookup) {
  final key = keyLookup[children.plainText.normalized];
  return key == null ? children : [.link('dictionary:${Uri.encodeComponent(key)}', children)];
}

Map<String, String> buildKeyLookup(List<XmlElement> terms) {
  final exact = terms.mapToMap((term) => MapEntry(getEntryKey(term), getEntryKey(term)));
  final withPlurals = {
    ...exact,
    ...getUniqueAliases(
      exact.entries
          .where((entry) => !entry.key.endsWith('S'))
          .map(
            (entry) => MapEntry(
              entry.key.endsWith('Y') ? '${entry.key.substring(0, entry.key.length - 1)}IES' : '${entry.key}S',
              entry.value,
            ),
          ),
      excluding: exact.keys,
    ),
  };
  return {
    ...withPlurals,
    ...getUniqueAliases(
      withPlurals.entries.map((entry) => MapEntry(entry.key.replaceAll(RegExp('[^A-Z0-9]'), ''), entry.value)),
      excluding: withPlurals.keys,
    ),
  }.entries.sortedBy<num>((entry) => -entry.key.length).toMap();
}

Map<String, String> getUniqueAliases(
  Iterable<MapEntry<String, String>> aliases, {
  required Iterable<String> excluding,
}) => aliases
    .groupListsBy((entry) => entry.key)
    .entries
    .where((entry) => entry.value.length == 1 && !excluding.contains(entry.key))
    .mapToMap((key, entries) => MapEntry(key, entries.single.value));

void expandFragmentedDictionaryReferences(XmlElement definition, Map<String, String> keyLookup) {
  final references = definition.findAllElements('a');
  for (final reference in references) {
    final previous = reference.previousSibling;
    if (previous is! XmlText) continue;
    final combined = '${previous.value}${reference.innerText}';
    final key = keyLookup.keys.firstWhereOrNull((key) => combined.normalized.endsWith(key));
    if (key == null || key.length < reference.innerText.length) continue;

    final prefixLength = key.length - reference.innerText.length;
    previous.value = previous.value.substring(0, previous.value.length - prefixLength);
    reference.children
      ..clear()
      ..add(XmlText(combined.substring(combined.length - key.length)));
  }
}

String getEntryKey(XmlElement term) => term.innerText.normalized;

extension on String {
  String get formatListMarkers =>
      replaceAllMapped(
        RegExp(r'(^|[ \t]+)\((\d+)\.\)[ \t]+', multiLine: true),
        (match) => '${match.group(1)!.isEmpty ? '' : '\n'}**${match.group(2)}.** ',
      ).replaceAllMapped(
        RegExp(r'(^|[ \t]+)\(([a-h])\)[ \t]+', multiLine: true),
        (match) => '${match.group(1)!.isEmpty ? '' : '\n'}\t**${match.group(2)}.** ',
      );

  String get normalized => withCollapsedWhitespace.toUpperCase();
}
