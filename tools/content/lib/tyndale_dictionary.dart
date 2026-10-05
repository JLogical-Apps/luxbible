import 'dart:convert';
import 'dart:io';

import 'package:bible/models/article.dart';
import 'package:bible/models/rich_content.dart';
import 'package:collection/collection.dart';
import 'package:lux/lux_core.dart';
import 'package:lux_content_tools/repository_paths.dart';
import 'package:lux_content_tools/tyndale.dart';
import 'package:xml/xml.dart';

List<Map<String, dynamic>> readTyndaleMaps() =>
    (jsonDecode(sourceFile('dictionary/tyndale/maps.json').readAsStringSync()) as List).cast<Map<String, dynamic>>();

// Links the source cannot resolve are kept as plain text and reported through `onDroppedLink`.
List<Article> extractTyndaleDictionary({required Function(String articleId, String href, String text) onDroppedLink}) {
  final articles = _readArticleItems().toList();
  final articleIds = articles.map((item) => item.getAttribute('name')!).toSet();
  final boxesBySource = {
    for (final directory in ['Textboxes', 'Charts'])
      '../$directory/$directory.xml': {
        for (final item in _readItems(directory)) item.getAttribute('name')!.toLowerCase(): item,
      },
  };
  // Articles reference a few included items in a different case, such as `TheDeathofMoses` and `AbrahamSBosom`.
  final mapIdsByAlias = {
    for (final map in readTyndaleMaps())
      for (final alias in map['aliases'] as List) (alias as String).toLowerCase(): map['id'] as String,
  };

  return articles.map((item) {
    final id = item.getAttribute('name')!;

    List<MarkdownElement> getLinkElements(XmlElement link, List<MarkdownElement> children) {
      final href = link.getAttribute('href')!;
      final articleId = RegExp(r'^\?item=(.+)_Article_TyndaleOpenBibleDictionary$').firstMatch(href)?[1];
      if (href.startsWith('#') || (href.startsWith('?item=') && articleId == null)) return children;
      if (articleId != null) {
        if (articleIds.contains(articleId)) {
          return [
            .link('${Article.dictionaryLinkPrefix}$articleId', [.text(_withoutAsterisks(link.innerText))]),
          ];
        }
        onDroppedLink(id, href, link.innerText);
        return children;
      }
      try {
        return switch (getTyndaleLinkOsisId(link)) {
          final osisId? => [.link(osisId, children)],
          null => children,
        };
      } on Exception {
        onDroppedLink(id, href, link.innerText);
        return children;
      }
    }

    List<RichContent> getContent(Iterable<XmlElement> elements) => elements.expand<RichContent>((element) {
      if (element.name.local == 'table') {
        return [
          RichContent.table(
            rows: element
                .findElements('tr')
                .map(
                  (row) => row
                      .findElements('td')
                      .map(
                        (cell) => Markdown(
                          cell.childElements
                              .map(
                                (paragraph) =>
                                    (paragraph.getAttribute('class') == 'td-indent' ? '    ' : '') +
                                    getTyndaleMarkdown(paragraph, getLinkElements: getLinkElements).text,
                              )
                              .join('\n'),
                        ),
                      )
                      .toList(),
                )
                .toList(),
          ),
        ];
      }
      if (element.name.local == 'include_items') {
        final name = element.getAttribute('name')!;
        return switch (element.getAttribute('src')) {
          '../Maps/Maps.xml' => [
            RichContent.bibleMap(
              id: mapIdsByAlias[name.toLowerCase()] ?? (throw FormatException('Unknown map `$name` in `$id`.')),
            ),
          ],
          final source? when boxesBySource.containsKey(source) => [
            switch (boxesBySource[source]![name.toLowerCase()]) {
              final box? => RichContent.box(
                title: box.getElement('title')!.innerText.trim(),
                content: getContent(box.getElement('body')!.childElements.where(_isNotTitle)),
              ),
              null => throw FormatException('Unknown include `$name` in `$id`.'),
            },
          ],
          // The dictionary's pictures are captions without their images.
          '../Pictures/Pictures.xml' => [],
          final other => throw FormatException('Unknown include source `$other` in `$id`.'),
        };
      }
      return [
        RichContent.paragraph(
          text: getTyndaleMarkdown(element, getLinkElements: getLinkElements),
          style: _getParagraphStyle(element.getAttribute('class')),
        ),
      ];
    }).toList();

    return Article(
      id: id,
      title: _withoutAsterisks(item.getElement('title')!.innerText.trim()),
      body: getContent(item.getElement('body')!.childElements.where(_isNotTitle)),
    );
  }).toList();
}

Set<String> readTyndaleDictionaryIds() => _readArticleItems().map((item) => item.getAttribute('name')!).toSet();

Iterable<XmlElement> _readArticleItems() =>
    _readItems('Articles').where((item) => item.getAttribute('typename') == 'Article');

Iterable<XmlElement> _readItems(String directory) => sourceDirectory('dictionary/tyndale/$directory')
    .listSync()
    .whereType<File>()
    .sortedBy((file) => file.path)
    .expand((file) => XmlDocument.parse(file.readAsStringSync()).findAllElements('item'));

bool _isNotTitle(XmlElement element) => element.getAttribute('class') != 'h1';

// An asterisk marks a term that is missing from the NLT, which Lux does not explain or use.
String _withoutAsterisks(String text) => text.replaceAll('*', '');

RichParagraphStyle _getParagraphStyle(String? paragraphClass) => switch (paragraphClass) {
  null || 'fl' || 'sp' || 'list-text' || 'list-text-fl' || 'preview-text' || 'box-first' || 'td' => .body,
  'h2' || 'h2-preview' || 'h2-list' || 'box-h2' || 'box-h2-poetic' => .heading,
  'h3' => .subheading,
  'h4' || 'h5' => .italic,
  'list' ||
  'list-space' ||
  'list-0' ||
  'list-1' ||
  'preview-list' ||
  'preview-list-first' ||
  'preview-list-1' => .indented,
  'extract' ||
  'extract-fl' ||
  'extract-fl-space' ||
  'box-extract' ||
  'poetry-1' ||
  'poetry-1-sp' ||
  'poetry-2' ||
  'poetry-3' => .quote,
  final other => throw FormatException('Unknown dictionary paragraph class `$other`.'),
};
