import 'package:bible/models/commentary.dart';
import 'package:collection/collection.dart';
import 'package:lux/lux_core.dart';
import 'package:lux_content_tools/repository_paths.dart';
import 'package:utils_core/utils_core.dart';
import 'package:xml/xml.dart';

Map<BookType, CommentaryBook> extractTyndaleCommentary() {
  final introductions = _extractIntroductions();
  final notesByChapter = _extractNotes().groupListsBy((note) => note.selection.start.toChapterReference());

  return BookType.values.mapToMap(
    (book) => MapEntry(
      book,
      CommentaryBook(
        introduction: introductions[book] ?? [],
        blocksByChapter: notesByChapter
            .where((chapter, notes) => chapter.book == book)
            .map((chapter, notes) => MapEntry(chapter.chapterNum, _getSections(notes))),
      ),
    ),
  );
}

typedef _Note = ({VerseSelection selection, int index, List<CommentaryContent> content});

List<_Note> _extractNotes() => XmlDocument.parse(sourceFile('commentary/tyndale/StudyNotes.xml').readAsStringSync())
    .findAllElements('item')
    .mapIndexed((index, item) {
      final selection = _parseSelection(item.getElement('refs')!.innerText);
      return (
        selection: selection,
        index: index,
        content: _getNoteContent(item.getElement('body')!.childElements.toList(), selection),
      );
    })
    .toList();

List<CommentaryContent> _getNoteContent(List<XmlElement> paragraphs, VerseSelection selection) {
  final label = _getLeadingLabel(paragraphs.first);
  return [
    if (label != null && !_isLabelRedundant(label.innerText, selection))
      CommentaryContent.paragraph(text: Markdown(label.innerText), style: .italic),
    ...paragraphs.expand(
      (paragraph) => _getMarkdown(paragraph, omittedLabel: label).text
          .split(RegExp(r'\s*•\s*'))
          .where((text) => text.isNotEmpty)
          .map(
            (text) => CommentaryContent.paragraph(
              text: Markdown(text),
              style: switch (paragraph.getAttribute('class')) {
                'sn-text' => .body,
                'sn-list-1' || 'sn-list-2' || 'sn-list-3' => .indented,
                final other => throw FormatException('Unknown study note paragraph class `$other`.'),
              },
            ),
          ),
    ),
  ];
}

List<CommentaryBlock> _getSections(List<_Note> notes) => notes
    .sorted(
      (a, b) =>
          a.selection.start.compareTo(b.selection.start).nullIfZero ??
          b.selection.end.compareTo(a.selection.end).nullIfZero ??
          a.index.compareTo(b.index),
    )
    .groupListsBy((note) => note.selection)
    .entries
    .map(
      (entry) =>
          CommentaryBlock.section(selection: entry.key, content: entry.value.expand((note) => note.content).toList()),
    )
    .toList();

Map<BookType, List<CommentaryContent>> _extractIntroductions() =>
    XmlDocument.parse(sourceFile('commentary/tyndale/BookIntros.xml').readAsStringSync())
        .findAllElements('item')
        .mapToMap(
          (item) => MapEntry(
            _getBook(item.getElement('refs')!.innerText.split('.').first),
            _getIntroductionContent(item.getElement('body')!.childElements),
          ),
        );

List<CommentaryContent> _getIntroductionContent(Iterable<XmlElement> paragraphs) => paragraphs
    .splitBetween((previous, next) => !(_isPoetry(previous) && _isPoetry(next)))
    .map(
      (group) => switch (group) {
        [final paragraph] when !_isPoetry(paragraph) => CommentaryContent.paragraph(
          text: _getMarkdown(paragraph),
          style: switch (paragraph.getAttribute('class')) {
            'intro-overview' ||
            'intro-body' ||
            'intro-body-fl' ||
            'intro-body-fl-sp' ||
            'intro-sidebar-body-fl' => .body,
            'intro-h1' || 'intro-sidebar-h1' => .heading,
            'intro-list' || 'intro-list-sp' => .indented,
            'intro-extract' => .quote,
            final other => throw FormatException('Unknown book introduction paragraph class `$other`.'),
          },
        ),
        _ => CommentaryContent.paragraph(
          text: Markdown(
            group
                .map(
                  (line) => '${line.getAttribute('class') == 'intro-poetry-2' ? '  ' : ''}${_getMarkdown(line).text}',
                )
                .join('\n'),
          ),
          style: .quote,
        ),
      },
    )
    .toList();

bool _isPoetry(XmlElement paragraph) => paragraph.getAttribute('class')?.startsWith('intro-poetry') == true;

XmlElement? _getLeadingLabel(XmlElement paragraph) => switch (paragraph.children.firstOrNull) {
  final XmlElement first
      when (first.name.local == 'span' && first.getAttribute('class') == 'sn-ref') ||
          (first.name.local == 'a' && first.getElement('span') != null) =>
    first,
  _ => null,
};

// A printed label that only repeats the section header is redundant. Wider scopes ("11:27–25:11"), partial verses
// ("4:1b") and psalm titles ("3:title") say something the header does not, so they are kept as their own line.
bool _isLabelRedundant(String label, VerseSelection selection) {
  final (start, end) = (selection.start, selection.end);
  final text = label.replaceAll('\u00a0', ' ');
  final psalmMatch = RegExp(r'^Pss? (\d+)(?:–(\d+))?$').firstMatch(text);
  if (psalmMatch != null) {
    return start.chapterNum == int.parse(psalmMatch.group(1)!) &&
        start.verseNum == 1 &&
        end.chapterNum == int.parse(psalmMatch.group(2) ?? psalmMatch.group(1)!) &&
        end == Reference.lastVerseFor(book: end.book, chapterNum: end.chapterNum);
  }
  return text ==
      switch ((start, end)) {
        _ when start == end => '${start.chapterNum}:${start.verseNum}',
        _ when start.chapterNum == end.chapterNum => '${start.chapterNum}:${start.verseNum}-${end.verseNum}',
        _ => '${start.chapterNum}:${start.verseNum}–${end.chapterNum}:${end.verseNum}',
      };
}

Markdown _getMarkdown(XmlElement paragraph, {XmlElement? omittedLabel}) {
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

List<MarkdownElement> _getLinkElements(XmlElement link, List<MarkdownElement> children) {
  // The source has one href with a stray leading backslash and one range written with a double hyphen.
  final href = link
      .getAttribute('href')!
      .trim()
      .replaceFirst(RegExp(r'^\\'), '')
      .replaceFirst('--', '-')
      .replaceFirst('?bref=', '');
  final isUnsupportedTarget = href.startsWith('?item=') || href.endsWith('_StudyNote_Filament');
  return isUnsupportedTarget ? children : [.link(_getOsisId(_getRepairedHref(href, link.innerText)), children)];
}

// Some links lost their end verse: `Gen.1.3-2` is displayed as "1:3–2:3" and the end chapter took its place.
String _getRepairedHref(String href, String displayText) {
  final hrefMatch = RegExp(r'\.(\d+)\.(\d+)-(\d+)$').firstMatch(href);
  final displayMatch = hrefMatch == null
      ? null
      : RegExp('\\b${hrefMatch[1]}:${hrefMatch[2]}\\s*[–—]\\s*${hrefMatch[3]}:(\\d+)').firstMatch(displayText);
  return displayMatch == null ? href : '$href.${displayMatch[1]}';
}

VerseSelection _parseSelection(String osisId) => VerseSelection.fromOsisId(_getOsisId(osisId.trim()));

String _getOsisId(String id) {
  final [start, ...ends] = id.split('-').map((part) => part.split('.')).toList();
  if (start.length != 3 || ends.length > 1 || ends.any((end) => end.length > 3)) {
    throw FormatException('Cannot parse reference `$id`.');
  }

  final osisId = [
    start,
    ...ends.map((end) => [...start.take(3 - end.length), ...end]),
  ].map((parts) => _getAppReference(_getReference(parts)).osisId()).toSet().join('-');
  if (!VerseSelection.isOsisId(osisId)) throw FormatException('Invalid reference `$id` (resolved to `$osisId`).');
  return osisId;
}

Reference _getReference(List<String> parts) {
  final [book, chapter, verse] = parts;
  return Reference(book: _getBook(book), chapterNum: int.parse(chapter), verseNum: int.parse(verse));
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

BookType _getBook(String tyndaleId) => BookType.fromOsisId(_bookIdByTyndaleId[tyndaleId] ?? tyndaleId);

extension on VerseSelection {
  Reference get start => references.first;
  Reference get end => references.last;
}
