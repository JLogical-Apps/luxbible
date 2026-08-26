import 'package:lux/lux_core.dart';
import 'package:lux_content_tools/repository_paths.dart';
import 'package:lux_content_tools/src/parsers/usx_parser.dart';

void main() => writeBibleBooks(
  translation: 'kjv',
  app: .bible,
  books: BookType.values.map(
    (type) => parseUsxBook(
      type,
      sourceFile('bibles/kjv/${type.usxCode()}.usx').readAsStringSync(),
    ),
  ),
);
