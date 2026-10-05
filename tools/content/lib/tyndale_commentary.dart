import 'package:bible/models/commentary.dart';
import 'package:bible/models/rich_content.dart';
import 'package:collection/collection.dart';
import 'package:lux/lux_core.dart';
import 'package:lux_content_tools/repository_paths.dart';
import 'package:lux_content_tools/tyndale.dart';
import 'package:utils_core/utils_core.dart';
import 'package:xml/xml.dart';

Map<BookType, CommentaryBook> extractTyndaleCommentary() {
  final summaries = _extractSummaries();
  final introductions = _extractIntroductions();
  final notesByChapter = _extractNotes().groupListsBy((note) => note.selection.start.toChapterReference());

  return BookType.values.mapToMap(
    (book) => MapEntry(
      book,
      CommentaryBook(
        summary: summaries[book] ?? [],
        introduction: introductions[book] ?? [],
        blocksByChapter: notesByChapter
            .where((chapter, notes) => chapter.book == book)
            .map((chapter, notes) => MapEntry(chapter.chapterNum, _getSections(notes))),
      ),
    ),
  );
}

typedef _Note = ({VerseSelection selection, int index, List<RichContent> content});

List<_Note> _extractNotes() => XmlDocument.parse(sourceFile('commentary/tyndale/StudyNotes.xml').readAsStringSync())
    .findAllElements('item')
    .mapIndexed((index, item) {
      final selection = parseTyndaleSelection(item.getElement('refs')!.innerText);
      return (
        selection: selection,
        index: index,
        content: _getNoteContent(item.getElement('body')!.childElements.toList(), selection),
      );
    })
    .toList();

List<RichContent> _getNoteContent(List<XmlElement> paragraphs, VerseSelection selection) {
  final label = _getLeadingLabel(paragraphs.first);
  return [
    if (label != null && !_isLabelRedundant(label.innerText, selection))
      RichContent.paragraph(text: Markdown(label.innerText), style: .italic),
    ...paragraphs.expand(
      (paragraph) => getTyndaleMarkdown(paragraph, omittedLabel: label).text
          .split(RegExp(r'\s*•\s*'))
          .where((text) => text.isNotEmpty)
          .map(
            (text) => RichContent.paragraph(
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

Map<BookType, List<RichContent>> _extractSummaries() =>
    XmlDocument.parse(sourceFile('commentary/tyndale/BookIntroSummaries.xml').readAsStringSync())
        .findAllElements('item')
        .mapToMap(
          (item) => MapEntry(
            getTyndaleBook(item.getElement('refs')!.innerText.split('.').first),
            _getSummaryContent(item.getElement('body')!.childElements),
          ),
        );

// The intro-title paragraph ("The Book of Genesis") is dropped since the section header already names the book.
List<RichContent> _getSummaryContent(Iterable<XmlElement> paragraphs) => paragraphs
    .where((paragraph) => paragraph.getAttribute('class') != 'intro-title')
    .slices(2)
    .map(
      (pair) => switch (pair.map((paragraph) => paragraph.getAttribute('class')).toList()) {
        ['intro-sidebar-h1', 'intro-sidebar-body-fl'] => RichContent.paragraph(
          text: Markdown('**${getTyndaleMarkdown(pair.first).text}:** ${getTyndaleMarkdown(pair.last).text}'),
        ),
        final classes => throw FormatException('Unexpected book summary paragraph classes `$classes`.'),
      },
    )
    .toList();

Map<BookType, List<RichContent>> _extractIntroductions() =>
    XmlDocument.parse(sourceFile('commentary/tyndale/BookIntros.xml').readAsStringSync())
        .findAllElements('item')
        .mapToMap(
          (item) => MapEntry(
            getTyndaleBook(item.getElement('refs')!.innerText.split('.').first),
            _getIntroductionContent(item.getElement('body')!.childElements),
          ),
        );

List<RichContent> _getIntroductionContent(Iterable<XmlElement> paragraphs) => paragraphs
    .splitBetween((previous, next) => !(_isPoetry(previous) && _isPoetry(next)))
    .map(
      (group) => switch (group) {
        [final paragraph] when !_isPoetry(paragraph) => RichContent.paragraph(
          text: getTyndaleMarkdown(paragraph),
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
        _ => RichContent.paragraph(
          text: Markdown(
            group
                .map(
                  (line) =>
                      '${line.getAttribute('class') == 'intro-poetry-2' ? '  ' : ''}${getTyndaleMarkdown(line).text}',
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

extension on VerseSelection {
  Reference get start => references.first;
  Reference get end => references.last;
}
