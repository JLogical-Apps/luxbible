import 'package:lux/lux_core.dart';
import 'package:lux_content_tools/repository_paths.dart';
import 'package:lux_content_tools/src/parsers/usx_parser.dart';

void main() => writeBibleBooks(
  translation: 'msb',
  app: .bible,
  books: BookType.values.map(
    (type) => parseUsxBook(
      type,
      sourceFile('bibles/msb/${type.usxCode()}.usx').readAsStringSync()
      // Strong's tags aren't used yet, and supplied words print plainly in the MSB, as they do in Lux's BSB.
      .replaceAllMapped(RegExp(r'<char style="(?:w|add)"[^>]*>([^<]*)</char>'), (match) => match[1]!),
      includeInterlinear: false,
    ),
  ),
);
