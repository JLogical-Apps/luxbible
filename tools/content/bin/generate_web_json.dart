import 'package:lux/lux_core.dart';
import 'package:lux_content_tools/repository_paths.dart';
import 'package:lux_content_tools/src/parsers/usx_parser.dart';

void main() => writeBibleBooks(
  translation: 'web',
  app: .bible,
  books: BookType.values.map(
    (type) => parseUsxBook(
      type,
      sourceFile('bibles/web/${type.usxCode()}.usx').readAsStringSync(),
      includeInterlinear: false,
      shouldIgnoreElement: (element) =>
          element.localName == 'note' && element.getAttribute('style') == 'x',
      transformText: (text) => text.replaceAll(RegExp(r'\s+'), ' '),
    ),
  ),
);
