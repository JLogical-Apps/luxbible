import 'dart:convert';

import 'package:lux/lux_core.dart';
import 'package:lux_content_tools/repository_paths.dart';
import 'package:lux_content_tools/src/parsers/usx_parser.dart';

void main() => appAssetFile('translations/kjv.json', app: .bible).writeAsStringSync(
  jsonEncode(
    BookType.values
        .map((type) => parseUsxBook(type, sourceFile('bibles/kjv/${type.usxCode()}.usx').readAsStringSync()))
        .map((book) => book.toJson())
        .toList(),
  ),
);
