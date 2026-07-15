import 'dart:convert';
import 'dart:io';

import 'package:bible/models/bible/book_type.dart';
import 'package:bible/models/commentary_type.dart';
import 'package:bible/models/reference/reference.dart';
import 'package:bible/models/reference/verse_selection.dart';
import 'package:bible/utils/extensions/collection_extensions.dart';
import 'package:bible/utils/markdown.dart';
import 'package:bible/utils/range.dart';
import 'package:collection/collection.dart';
import 'package:utils_core/utils_core.dart';
import 'package:xml/xml.dart';

void main() {
  for (final source in sources) {
    final notes = source.inputs
        .map((path) => _extractNotes(XmlDocument.parse(File(path).readAsStringSync()), source.type))
        .fold(<String, String>{}, (acc, notes) {
          notes.forEach((key, value) => acc.update(key, (accNotes) => '$accNotes\n\n$value', ifAbsent: () => value));
          return acc;
        });
    File('assets/commentary/${source.output}').writeAsStringSync(jsonEncode({'v': notes}));
  }
}

Map<String, String> _extractNotes(XmlDocument doc, CommentaryType type) {
  for (final note in doc.findAllElements('note').toList()) {
    note.remove();
  }

  final intros = switch (type) {
    .jamiesonFaussetBrown =>
      doc
          .findAllElements('div3')
          .where((div) => div.getAttribute('title') == 'Introduction')
          .mapToMap((intro) => MapEntry(_referenceOf(intro.parent), _introMarkdown(intro.childElements)))
          .withoutNullKeys,
    .matthewHenry =>
      doc
          .findAllElements('div1')
          .where((div) => div.getAttribute('title') != null)
          .mapToMap(
            (intro) => MapEntry(
              _referenceOf(intro),
              _introMarkdown(intro.childElements.takeWhile((e) => e.name.local != 'div2')),
            ),
          )
          .withoutNullKeys,
    _ => <String, String>{},
  };

  String? pendingRef;
  final notes = doc.descendants.whereType<XmlElement>().fold(<String, String>{}, (notes, element) {
    switch (element.name.local) {
      case 'scripCom':
        pendingRef = element.getAttribute('osisRef')?.split(':').last;
      case 'div' when element.getAttribute('class') == 'Commentary':
        if (pendingRef case final ref?) {
          final markdown = _commentaryMarkdown(element.findAllElements('p'));
          if (markdown.isNotEmpty) {
            notes.update(ref, (existing) => '$existing\n\n$markdown', ifAbsent: () => markdown);
          }
          pendingRef = null;
        }
    }
    return notes;
  });
  return {...intros.where((reference, markdown) => markdown.isNotEmpty), ...notes};
}

String? _referenceOf(XmlNode? container) => container
    ?.findAllElements('scripCom')
    .firstOrNull
    ?.getAttribute('osisRef')
    ?.split(':')
    .last
    .split('.')
    .first
    .mapIfNonNull((book) => Reference(book: BookType.fromOsisId(book), chapterNum: 1, verseNum: 0).osisId());

String _introMarkdown(Iterable<XmlElement> elements) => _commentaryMarkdown(
  elements.expand((element) => element.name.local == 'p' ? [element] : element.findAllElements('p')),
  skipIntroduction: true,
);

String _commentaryMarkdown(Iterable<XmlElement> paragraphs, {bool skipIntroduction = false}) =>
    Markdown.fromXmlNodes(paragraphs, (element, children) {
      if (element.name.local == 'p') {
        if (_isSkippedParagraph(element.getAttribute('class') ?? '') ||
            (skipIntroduction && children.plainText.trim().toUpperCase() == 'INTRODUCTION')) {
          return [];
        }
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
        _ => children,
      };
    }).text.trim();

bool _isSkippedParagraph(String className) =>
    className == 'Footnote' || className == 'Center' || className.startsWith('TableCaption');

String? _getSupportedOsisId(XmlElement element) {
  final osisRef = element.getAttribute('osisRef');
  if (osisRef == null) return null;

  final osisId = osisRef
      .trim()
      .split(RegExp(r'\s+'))
      .map((reference) => reference.replaceFirst('Bible:', ''))
      .join(' ');
  try {
    VerseSelection.fromOsisId(osisId);
    return osisId;
  } catch (_) {
    return null;
  }
}

class CommentarySource {
  final CommentaryType type;
  final String output;
  final List<String> inputs;

  const CommentarySource({required this.type, required this.output, required this.inputs});
}

final sources = [
  CommentarySource(
    type: .matthewHenry,
    output: 'matthew_henry.json',
    inputs: ['source_files/commentary/matthew_henry.xml'],
  ),
  CommentarySource(
    type: .jamiesonFaussetBrown,
    output: 'jamieson_fausset_brown.json',
    inputs: ['source_files/commentary/jfb.xml'],
  ),
  CommentarySource(
    type: .calvin,
    output: 'calvin.json',
    inputs: Range.generate(
      1,
      45,
    ).map((i) => 'source_files/commentary/calvin/calcom${i.toString().padLeft(2, '0')}.xml').toList(),
  ),
];
