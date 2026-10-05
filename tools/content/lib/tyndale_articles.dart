import 'dart:convert';

import 'package:bible/models/article.dart';
import 'package:bible/models/rich_content.dart';
import 'package:lux/lux_core.dart';
import 'package:lux_content_tools/repository_paths.dart';
import 'package:lux_content_tools/tyndale.dart';
import 'package:utils_core/utils_core.dart';
import 'package:xml/xml.dart';

Map<String, List<String>> readTyndaleDictionaryLinks() =>
    (jsonDecode(sourceFile('commentary/tyndale/dictionary_links.json').readAsStringSync()) as Map<String, dynamic>)
        .mapValues((articleId, dictionaryIds) => (dictionaryIds as List).cast<String>());

// ThemeNotes.xml marks one theme with typename="Profile", so callers classify items by file rather than by typename.
List<Article> extractTyndaleArticles(String fileName, {required Map<String, List<String>> dictionaryLinks}) =>
    XmlDocument.parse(
      sourceFile('commentary/tyndale/$fileName').readAsStringSync(),
    ).findAllElements('item').map((item) => _getArticle(item, dictionaryLinks: dictionaryLinks)).toList();

Article _getArticle(XmlElement item, {required Map<String, List<String>> dictionaryLinks}) {
  final id = item.getAttribute('name')!;
  final paragraphs = item.getElement('body')!.childElements;
  return Article(
    id: id,
    title: item.getElement('title')!.innerText.trim(),
    body: paragraphs
        .where((paragraph) => !_isTitleOrReferences(paragraph))
        .map(
          (paragraph) => RichContent.paragraph(
            text: getTyndaleMarkdown(paragraph),
            style: switch (paragraph.getAttribute('class')) {
              'profile-body' ||
              'profile-body-fl' ||
              'profile-body-fl-sp' ||
              'theme-body' ||
              'theme-body-fl' ||
              'theme-body-fl-sp' ||
              'theme-body-sp' => .body,
              'profile-h1' || 'theme-h2' => .heading,
              'theme-list' || 'theme-list-sp' => .indented,
              final other => throw FormatException('Unknown article paragraph class `$other`.'),
            },
          ),
        )
        .toList(),
    passages: {
      parseTyndaleSelection(item.getElement('refs')!.innerText),
      ...paragraphs
          .where((paragraph) => paragraph.getAttribute('class')?.endsWith('-refs') == true)
          .expand((paragraph) => paragraph.findElements('a'))
          .map(
            (link) =>
                getTyndaleLinkOsisId(link) ??
                (throw FormatException('Unsupported further-study link `${link.getAttribute('href')}`.')),
          )
          .map(VerseSelection.fromOsisId),
    }.toList(),
    dictionaryIds: dictionaryLinks[id] ?? [],
  );
}

bool _isTitleOrReferences(XmlElement paragraph) => switch (paragraph.getAttribute('class')) {
  'profile-title' ||
  'profile-refs-title' ||
  'profile-refs' ||
  'theme-title' ||
  'theme-refs-title' ||
  'theme-refs' => true,
  _ => false,
};
