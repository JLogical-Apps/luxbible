import 'dart:convert';

import 'package:bible/models/commentary.dart';
import 'package:bible/models/commentary_type.dart';
import 'package:bible/models/rich_content.dart';
import 'package:collection/collection.dart';
import 'package:lux/lux_core.dart';
import 'package:lux_content_tools/repository_paths.dart';
import 'package:lux_content_tools/tyndale_commentary.dart';
import 'package:utils_core/utils_core.dart';
import 'package:xml/xml.dart';

void main() {
  for (final source in CommentaryType.values) {
    final commentaryByBook = source.extract();
    final directory = appAssetDirectory('commentary/${source.output}', app: .bible)..createSync(recursive: true);
    for (final book in BookType.values) {
      (directory - '${book.usxCode()}.json').writeAsStringSync(
        jsonEncode((commentaryByBook[book] ?? CommentaryBook()).toJson()),
      );
    }
  }
}

Map<BookType, CommentaryBook> _extractCommentary(XmlDocument doc, CommentaryType type) {
  final sourceStyles = _getSourceStyles(doc);
  for (final note in doc.findAllElements('note').toList()) {
    note.remove();
  }

  final introductions = switch (type) {
    .jamiesonFaussetBrown =>
      doc
          .findAllElements('div3')
          .where((div) => div.getAttribute('title') == 'Introduction')
          .mapToMap((intro) => MapEntry(_bookOf(intro.parent), _introContent(intro.childElements, sourceStyles)))
          .withoutNullKeys,
    .matthewHenry =>
      doc
          .findAllElements('div1')
          .where((div) => div.getAttribute('title') != null)
          .mapToMap(
            (intro) => MapEntry(
              _bookOf(intro),
              _introContent(
                intro.childElements.takeWhile(
                  (element) =>
                      element.name.local != 'div2' &&
                      element.name.local != 'scripCom' &&
                      !(element.name.local == 'div' && element.getAttribute('class') == 'Commentary') &&
                      !(element.name.local == 'table' && element.innerText.contains('Chapter Outline')),
                ),
                sourceStyles,
                skipHeadings: true,
              ),
            ),
          )
          .withoutNullKeys,
    .calvin =>
      doc.descendants
          .whereType<XmlElement>()
          .where((element) => element.getAttribute('title') == 'The Argument')
          .mapToMap(
            (argument) => MapEntry(_bookOf(argument.parent), _introContent(argument.childElements, sourceStyles)),
          )
          .withoutNullKeys,
    .tyndale => throw UnsupportedError('Tyndale is extracted by extractTyndaleCommentary.'),
  };

  final blocksByChapter = <ChapterReference, List<CommentaryBlock>>{};
  if (type == .matthewHenry) {
    doc
        .findAllElements('table')
        .where((table) => table.innerText.contains('Chapter Outline'))
        .map(_extractOutline)
        .nonNulls
        .forEach(
          (entry) =>
              blocksByChapter.update(entry.key, (blocks) => [...blocks, entry.value], ifAbsent: () => [entry.value]),
        );
  }

  VerseSelection? pendingSelection;
  doc.descendants.whereType<XmlElement>().forEach((element) {
    switch (element.name.local) {
      case 'scripCom':
        pendingSelection = _getSupportedOsisId(element)?.mapIfNonNull(VerseSelection.fromOsisId);
      case 'div' when element.getAttribute('class') == 'Commentary':
        if (pendingSelection case final selection?) {
          final content = _commentaryContent(element.childElements, sourceStyles, skipHeadings: true).toList();
          if (selection.references.firstOrNull case final reference? when content.isNotEmpty) {
            final block = CommentaryBlock.section(selection: selection, content: content);
            blocksByChapter.update(
              reference.toChapterReference(),
              (blocks) => _mergeBlock(blocks, block),
              ifAbsent: () => [block],
            );
          }
          pendingSelection = null;
        }
    }
  });

  return BookType.values.mapToMap(
    (book) => MapEntry(
      book,
      CommentaryBook(
        introduction: introductions[book] ?? [],
        blocksByChapter: blocksByChapter
            .where((chapter, blocks) => chapter.book == book && blocks.isNotEmpty)
            .map((chapter, blocks) => MapEntry(chapter.chapterNum, blocks)),
      ),
    ),
  );
}

Map<BookType, CommentaryBook> _mergeCommentaries(
  Map<BookType, CommentaryBook> curr,
  Map<BookType, CommentaryBook> next,
) => BookType.values.mapToMap((book) {
  final first = curr[book] ?? CommentaryBook();
  final second = next[book] ?? CommentaryBook();
  return MapEntry(book, _mergeCommentaryBooks(first, second));
});

CommentaryBook _mergeCommentaryBooks(CommentaryBook first, CommentaryBook second) => CommentaryBook(
  introduction: first.introduction + second.introduction,
  blocksByChapter: {
    ...first.blocksByChapter,
    ...second.blocksByChapter.mapValues(
      (chapter, blocks) => _mergeBlocks(first.blocksByChapter[chapter] ?? [], blocks),
    ),
  },
);

List<CommentaryBlock> _mergeBlocks(List<CommentaryBlock> first, List<CommentaryBlock> second) =>
    second.fold(first, _mergeBlock);

List<CommentaryBlock> _mergeBlock(List<CommentaryBlock> blocks, CommentaryBlock block) {
  final existingIndex = switch (block) {
    CommentarySection(:final selection) => blocks.indexWhereOrNull(
      (candidate) => candidate is CommentarySection && candidate.selection == selection,
    ),
    CommentaryOutline() => null,
  };
  return existingIndex == null
      ? [...blocks, block]
      : blocks.withUpdateAt(
          existingIndex,
          (existing) => (existing as CommentarySection).copyWith(
            content: existing.content + (block as CommentarySection).content,
          ),
        );
}

BookType? _bookOf(XmlNode? container) => container
    ?.findAllElements('scripCom')
    .firstOrNull
    ?.getAttribute('osisRef')
    ?.split(':')
    .last
    .split('.')
    .first
    .mapIfNonNull(BookType.fromOsisId);

List<RichContent> _introContent(
  Iterable<XmlElement> elements,
  Map<String, Map<String, String>> sourceStyles, {
  bool skipHeadings = false,
}) => _commentaryContent(elements, sourceStyles, skipIntroduction: true, skipHeadings: skipHeadings).toList();

MapEntry<ChapterReference, CommentaryBlock>? _extractOutline(XmlElement outlineTable) {
  final items = outlineTable
      .findAllElements('tr')
      .map((row) {
        final references = row
            .findAllElements('scripRef')
            .map(_getSupportedOsisId)
            .nonNulls
            .expand((osisId) => VerseSelection.fromOsisId(osisId).references)
            .toList();
        final text = row
            .findElements('td')
            .firstOrNull
            ?.childElements
            .map((element) => _commentaryMarkdown([element]))
            .firstWhereOrNull((markdown) => markdown.isNotEmpty);
        return references.isEmpty || text == null
            ? null
            : CommentaryOutlineItem(selection: VerseSelection.fromReferences(references), text: Markdown(text));
      })
      .nonNulls
      .toList();
  final reference = items.firstOrNull?.selection.references.firstOrNull;
  return reference == null ? null : MapEntry(reference.toChapterReference(), CommentaryBlock.outline(items: items));
}

String _commentaryMarkdown(Iterable<XmlElement> blocks) => Markdown.fromXmlNodes(blocks, (element, children) {
  if (element.name.local == 'p') {
    return [.paragraph(children)];
  }
  if (element.name.local == 'scripRef') {
    if (_getSupportedOsisId(element) case final osisId?) {
      return [.link(osisId, children)];
    }
    return children;
  }
  return switch (element.name.local) {
    'b' || 'strong' => [.bold(children)],
    'i' || 'em' => [.italic(children)],
    'l' => [...children, .lineBreak()],
    'verse' => [
      ...children.where(
        (child) => switch (child) {
          MarkdownText(:final text) => text.trim().isNotEmpty,
          _ => true,
        },
      ),
      .lineBreak(),
    ],
    _ => children,
  };
}).text.trim();

Iterable<RichContent> _commentaryContent(
  Iterable<XmlElement> elements,
  Map<String, Map<String, String>> sourceStyles, {
  bool skipIntroduction = false,
  bool skipHeadings = false,
  RichParagraphStyle? inheritedStyle,
}) => elements.expand((element) {
  final elementStyle = _getParagraphStyle(element, sourceStyles) ?? inheritedStyle;
  return switch (element.name.local) {
    'p' || 'verse' => () {
      final markdown = Markdown(_commentaryMarkdown([element]));
      final isIntroductionHeading = RegExp(
        r'^INTRODUCTION\.?$',
      ).hasMatch(markdown.withStrippedMarkdown.trim().toUpperCase());
      return markdown.text.isEmpty || (skipIntroduction && isIntroductionHeading)
          ? <RichContent>[]
          : [RichContent.paragraph(text: markdown, style: elementStyle ?? .body)];
    }(),
    'h1' || 'h2' || 'h3' || 'h4' || 'h5' || 'h6' =>
      skipHeadings
          ? <RichContent>[]
          : () {
              final markdown = Markdown(_commentaryMarkdown([element]));
              return markdown.text.isEmpty ? <RichContent>[] : [RichContent.paragraph(text: markdown, style: .heading)];
            }(),
    'table' => _getCommentaryTable(element),
    'blockquote' => _commentaryContent(
      element.childElements,
      sourceStyles,
      skipIntroduction: skipIntroduction,
      skipHeadings: skipHeadings,
      inheritedStyle: .quote,
    ),
    _ => _commentaryContent(
      element.childElements,
      sourceStyles,
      skipIntroduction: skipIntroduction,
      skipHeadings: skipHeadings,
      inheritedStyle: elementStyle,
    ),
  };
});

Iterable<RichContent> _getCommentaryTable(XmlElement table) {
  final rows = table
      .findAllElements('tr')
      .map(
        (row) => row.childElements
            .where((cell) => cell.name.local == 'td' || cell.name.local == 'th')
            .map((cell) => Markdown(_commentaryMarkdown([cell])))
            .toList(),
      )
      .where((row) => row.isNotEmpty)
      .toList();
  return rows.isEmpty ? [] : [RichContent.table(rows: rows)];
}

RichParagraphStyle? _getParagraphStyle(XmlElement element, Map<String, Map<String, String>> sourceStyles) {
  final className = element.getAttribute('class') ?? '';
  final RichParagraphStyle? classStyle = switch (className.toLowerCase()) {
    'attribution' => .attribution,
    'center' => .centered,
    'bold' => .bold,
    'italic' => .italic,
    final name when name.startsWith('continue') || name.startsWith('bigc') => .boldItalic,
    'big' => .heading,
    final name when name.startsWith('book-chap') => .heading,
    final name when name.startsWith('scripture') => .quote,
    final name when name.startsWith('poetry') => .poetry,
    final name when name.startsWith('tablecaption') => .heading,
    _ => null,
  };
  if (classStyle != null) return classStyle;

  final properties = {...?sourceStyles[className], ..._getInlineStyle(element.getAttribute('style'))};
  final isCentered = properties['text-align'] == 'center';
  final isBold = properties['font-weight'] == 'bold';
  final isItalic = properties['font-style'] == 'italic';
  final isLarge =
      properties['font-size']?.endsWith('%') == true &&
      (double.tryParse(properties['font-size']!.replaceAll('%', '')) ?? 100) > 100;

  if (isCentered && (isBold || isLarge)) return .heading;
  if (isCentered) return .centered;
  if (properties.containsKey('margin-left')) return .indented;
  if (isBold && isItalic) return .boldItalic;
  if (isBold) return .bold;
  if (isItalic) return .italic;
  return null;
}

Map<String, String> _getInlineStyle(String? style) =>
    style
        ?.split(';')
        .map((declaration) => declaration.split(':').map((part) => part.trim()).toList())
        .where((parts) => parts.length == 2)
        .mapToMap((parts) => MapEntry(parts.first, parts.last)) ??
    {};

Map<String, Map<String, String>> _getSourceStyles(XmlDocument doc) => doc
    .findAllElements('selector')
    .where((selector) => selector.getAttribute('class') != null)
    .mapToMap(
      (selector) => MapEntry(
        selector.getAttribute('class')!,
        selector
            .findElements('property')
            .where((property) => property.getAttribute('name') != null && property.getAttribute('value') != null)
            .mapToMap((property) => MapEntry(property.getAttribute('name')!, property.getAttribute('value')!)),
      ),
    );

String? _getSupportedOsisId(XmlElement element) {
  final osisRef = element.getAttribute('osisRef');
  if (osisRef == null) return null;

  final osisId = osisRef
      .trim()
      .split(RegExp(r'\s+'))
      .map((reference) => reference.replaceFirst('Bible:', ''))
      .join(' ');
  return VerseSelection.isOsisId(osisId) ? osisId : null;
}

extension on CommentaryType {
  String get output => switch (this) {
    .matthewHenry => 'matthew_henry',
    .jamiesonFaussetBrown => 'jamieson_fausset_brown',
    .calvin => 'calvin',
    .tyndale => 'tyndale',
  };

  Map<BookType, CommentaryBook> extract() => switch (this) {
    .matthewHenry => extractFrom(['matthew_henry.xml']),
    .jamiesonFaussetBrown => extractFrom(['jfb.xml']),
    .calvin => extractFrom(Range.generate(1, 45).map((i) => 'calvin/calcom${i.toString().padLeft(2, '0')}.xml')),
    .tyndale => extractTyndaleCommentary(),
  };

  Map<BookType, CommentaryBook> extractFrom(Iterable<String> paths) => paths
      .map((path) => _extractCommentary(XmlDocument.parse(sourceFile('commentary/$path').readAsStringSync()), this))
      .reduce(_mergeCommentaries);
}
