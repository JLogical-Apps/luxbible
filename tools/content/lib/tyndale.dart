import 'package:lux/lux_core.dart';
import 'package:xml/xml.dart';

Markdown getTyndaleMarkdown(XmlElement paragraph, {XmlElement? omittedLabel}) {
  final markdown = Markdown.fromXmlNodes(paragraph.children, (element, children) {
    if (identical(element, omittedLabel)) return [];
    return switch (element.name.local) {
      'span' => _getSpanElements(element, children),
      'a' => _getLinkElements(element, children),
      'x2002' => [.text(' ')],
      final other => throw FormatException('Unknown element `<$other>`.'),
    };
  }, textEscaping: .all);

  final text = markdown.text.replaceAll(RegExp(r'[ \n\t]{2,}'), ' ').trim();
  return Markdown(
    paragraph.getAttribute('class')?.contains('list') == true ? text.replaceFirst(RegExp(r'^•\s*'), '• ') : text,
  );
}

List<MarkdownElement> _getSpanElements(XmlElement span, List<MarkdownElement> children) =>
    switch (span.getAttribute('class')) {
      'sn-excerpt' || 'sn-excerpt-sc' || 'bold' || 'bold-era' || 'intro-h2' => [.bold(children)],
      'sn-excerpt-divine-name' => [
        .bold([.text(_getDivineName(span.innerText))]),
      ],
      'divine-name' => [.text(_getDivineName(span.innerText))],
      'divine-name-ital' => [
        .italic([.text(_getDivineName(span.innerText))]),
      ],
      'ital' || 'hebrew' || 'greek' || 'latin' || 'aramaic' || 'sn-excerpt-roman' => [.italic(children)],
      'ital-bold' => [
        .bold([.italic(children)]),
      ],
      'sc' => [.text(span.innerText.length <= 3 ? span.innerText.toUpperCase() : span.innerText)],
      'era' || 'intro-h2-era' || 'sup' || 'sub' || 'sn-hebrew-chars' || 'sn-ref' || 'sn-ref-sc' => children,
      final other => throw FormatException('Unknown span class `$other`.'),
    };

String _getDivineName(String text) => text.replaceAll('Lord', 'LORD').replaceAll(RegExp(r'\bAm\b'), 'AM');

List<MarkdownElement> _getLinkElements(XmlElement link, List<MarkdownElement> children) =>
    switch (getTyndaleLinkOsisId(link)) {
      final osisId? => [.link(osisId, children)],
      null => children,
    };

String? getTyndaleLinkOsisId(XmlElement link) {
  // A few hrefs have a stray leading backslash, en dashes or colons as separators, a doubled hyphen, or a repeated
  // range end (`John.2.13-16-20` for "John 2:13-16").
  final href = link
      .getAttribute('href')!
      .trim()
      .replaceFirst(RegExp(r'^\\'), '')
      .replaceAll('–', '-')
      .replaceAll(':', '.')
      .replaceFirst('--', '-')
      .replaceFirstMapped(RegExp(r'^([^-]+-[^-]+)-.*$'), (match) => match[1]!)
      .replaceFirst('?bref=', '');
  // Lux has no deuterocanonical books, and one theme links to 2 Maccabees.
  final isUnsupportedTarget =
      href.startsWith('?item=') || href.endsWith('_StudyNote_Filament') || href.startsWith('2Macc.');
  return isUnsupportedTarget ? null : _getOsisId(_getRepairedHref(href, link.innerText));
}

// Some links lost their end verse: `Gen.1.3-2` is displayed as "1:3–2:3" and the end chapter took its place.
String _getRepairedHref(String href, String displayText) {
  final hrefMatch = RegExp(r'\.(\d+)\.(\d+)-(\d+)$').firstMatch(href);
  final displayMatch = hrefMatch == null
      ? null
      : RegExp('\\b${hrefMatch[1]}:${hrefMatch[2]}\\s*[–—]\\s*${hrefMatch[3]}:(\\d+)').firstMatch(displayText);
  return displayMatch == null ? href : '$href.${displayMatch[1]}';
}

VerseSelection parseTyndaleSelection(String osisId) => VerseSelection.fromOsisId(_getOsisId(osisId.trim()));

String _getOsisId(String id) {
  final [start, ...ends] = id.split('-').map((part) => part.split('.')).toList();
  if (start.length != 3 || ends.length > 1 || ends.any((end) => end.length > 3)) {
    throw FormatException('Cannot parse reference `$id`.');
  }

  // One range ends past its chapter (`2Sam.10.6-25`, where 2 Samuel 10 has 19 verses), so range ends are clamped.
  final [startReference, ...endReferences] = [
    start,
    ...ends.map((end) => [...start.take(3 - end.length), ...end]),
  ].map((parts) => _getAppReference(_getReference(parts))).toList();
  final osisId = {
    startReference,
    ...endReferences.map((reference) => reference.clamped),
  }.map((reference) => reference.osisId()).join('-');
  if (!VerseSelection.isOsisId(osisId)) throw FormatException('Invalid reference `$id` (resolved to `$osisId`).');
  return osisId;
}

Reference _getReference(List<String> parts) {
  final [book, chapter, verse] = parts;
  return Reference(book: getTyndaleBook(book), chapterNum: int.parse(chapter), verseNum: int.parse(verse));
}

// The NLT numbers 3 John 15 and Revelation 12:18 as their own verses; the app's versification keeps them in the previous verse.
Reference _getAppReference(Reference reference) => switch ((reference.book, reference.chapterNum, reference.verseNum)) {
  (.john3, 1, 15) || (.revelation, 12, 18) => Reference(
    book: reference.book,
    chapterNum: reference.chapterNum,
    verseNum: reference.verseNum - 1,
  ),
  _ => reference,
};

const _bookIdByTyndaleId = {
  'Pr': 'Prov',
  'Hagg': 'Hag',
  'Jon': 'Jonah',
  '1Thes': '1Thess',
  '2Thes': '2Thess',
  '1Jn': '1John',
  '2Jn': '2John',
  '3Jn': '3John',
};

BookType getTyndaleBook(String tyndaleId) => BookType.fromOsisId(_bookIdByTyndaleId[tyndaleId] ?? tyndaleId);
