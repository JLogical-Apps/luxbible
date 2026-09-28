import 'package:lux/lux_core.dart';
import 'package:lux_content_tools/repository_paths.dart';
import 'package:lux_content_tools/src/parsers/usx_parser.dart';
import 'package:lux_content_tools/src/section_headings.dart';

void main() => writeBibleBooks(
  translation: 'web',
  app: .bible,
  books: BookType.values.map(
    (type) =>
        parseUsxBook(
          type,
          sourceFile('bibles/web/${type.usxCode()}.usx').readAsStringSync(),
          includeInterlinear: false,
          shouldIgnoreElement: (element) => element.localName == 'note' && element.getAttribute('style') == 'x',
          transformText: (text) => text.replaceAll(RegExp(r'\s+'), ' '),
        ).withSectionHeadingsFrom(
          parseUsxBook(
            type,
            sourceFile('bibles/bsb/${type.usxCode()}.usx').readAsStringSync(),
            includeInterlinear: false,
          ),
        ),
  ),
);
