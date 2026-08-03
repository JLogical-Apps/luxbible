import 'dart:convert';

import 'package:lux/lux.dart';
import 'package:lux_content_tools/repository_paths.dart';

import 'package:lux_content_tools/src/parsers/usx_parser.dart';

void main() => appAssetFile('translations/asv.json').writeAsStringSync(
  jsonEncode(
    BookType.values
        .map(
          (type) => parseUsxBook(
            type,
            sourceFile('bibles/asv/${type.usxCode()}.usx').readAsStringSync(),
          ),
        )
        .map((book) => book.toJson())
        .toList(),
  ),
);
