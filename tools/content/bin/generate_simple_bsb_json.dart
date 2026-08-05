import 'dart:convert';

import 'package:lux/lux_core.dart';
import 'package:lux_content_tools/repository_paths.dart';
import 'package:lux_content_tools/src/parsers/usx_parser.dart';

void main() => appAssetFile('translations/bsb.json', app: .memory).writeAsStringSync(
  jsonEncode(
    BookType.values
        .map(
          (type) => parseUsxBook(
            type,
            sourceFile('bibles/bsb/${type.usxCode()}.usx').readAsStringSync(),
            includeInterlinear: false,
          ),
        )
        .map((book) => book.toJson())
        .toList(),
  ),
);
