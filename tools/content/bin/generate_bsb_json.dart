import 'dart:convert';

import 'package:bible/models/bible/book_type.dart';
import 'package:lux_content_tools/repository_paths.dart';

import 'package:lux_content_tools/src/parsers/usx_parser.dart';

void main() => appAssetFile('translations/bsb.json').writeAsStringSync(
  jsonEncode(
    BookType.values
        .map(
          (type) => parseUsxBook(
            type,
            sourceFile('bibles/bsb/${type.usxCode()}.usx').readAsStringSync(),
          ),
        )
        .map((book) => book.toJson())
        .toList(),
  ),
);
