import 'package:lux/lux_core.dart';
import 'package:lux_content_tools/repository_paths.dart';
import 'package:lux_content_tools/src/parsers/usx_parser.dart';

void main() => writeBibleBooks(
  translation: 'bsb',
  app: .bible,
  books: BookType.values.map(
    (type) => parseUsxBook(
      type,
      sourceFile('bibles/bsb/${type.usxCode()}.usx').readAsStringSync(),
    ),
  ),
);
