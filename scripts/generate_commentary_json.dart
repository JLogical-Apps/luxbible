import 'dart:convert';
import 'dart:io';

import 'package:bible/utils/range.dart';
import 'package:xml/xml.dart';

class CommentarySource {
  final String output;
  final List<String> inputs;

  const CommentarySource({required this.output, required this.inputs});
}

final sources = [
  CommentarySource(output: 'matthew_henry.json', inputs: ['source_files/commentary/matthew_henry.xml']),
  CommentarySource(output: 'jamieson_fausset_brown.json', inputs: ['source_files/commentary/jfb.xml']),
  CommentarySource(
    output: 'calvin.json',
    inputs: Range.generate(
      1,
      45,
    ).map((i) => 'source_files/commentary/calvin/calcom${i.toString().padLeft(2, '0')}.xml').toList(),
  ),
];

void main() {
  for (final source in sources) {
    final notes = source.inputs.map((path) => _extractNotes(XmlDocument.parse(File(path).readAsStringSync()))).fold(
      <String, String>{},
      (acc, notes) {
        notes.forEach((key, value) => acc.update(key, (accNotes) => '$accNotes\n\n$value', ifAbsent: () => value));
        return acc;
      },
    );
    File('assets/commentary/${source.output}').writeAsStringSync(jsonEncode({'v': notes}));
  }
}

Map<String, String> _extractNotes(XmlDocument doc) {
  for (final note in doc.findAllElements('note').toList()) {
    note.remove();
  }
  String? pendingRef;
  return doc.descendants.whereType<XmlElement>().fold(<String, String>{}, (notes, element) {
    switch (element.name.local) {
      case 'scripCom':
        pendingRef = element.getAttribute('osisRef')?.split(':').last;
      case 'div' when element.getAttribute('class') == 'Commentary':
        if (pendingRef case final ref?) {
          final markdown = _divToMarkdown(element);
          if (markdown.isNotEmpty) {
            notes.update(ref, (existing) => '$existing\n\n$markdown', ifAbsent: () => markdown);
          }
          pendingRef = null;
        }
    }
    return notes;
  });
}

String _divToMarkdown(XmlElement div) => div
    .findAllElements('p')
    .where((p) => !_isSkippedParagraph(p.getAttribute('class') ?? ''))
    .map((p) => _inlineMarkdown(p).replaceAll(RegExp(r'\s+'), ' ').trim())
    .where((markdown) => markdown.isNotEmpty)
    .join('\n\n');

bool _isSkippedParagraph(String className) =>
    className == 'Footnote' || className == 'Center' || className.startsWith('TableCaption');

String _inlineMarkdown(XmlNode node) => node.children
    .map(
      (node) => switch (node) {
        XmlText() => node.value,
        XmlElement() => _wrapEmphasis(node.name.local, _inlineMarkdown(node)),
        _ => '',
      },
    )
    .join();

String _wrapEmphasis(String tag, String inner) => switch (tag) {
  'b' || 'strong' => inner.trim().isEmpty ? '' : '**${inner.trim()}**',
  'i' || 'em' => inner.trim().isEmpty ? '' : '*${inner.trim()}*',
  _ => inner,
};
