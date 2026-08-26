import 'dart:convert';

import 'package:lux/lux_core.dart';
import 'package:lux_content_tools/repository_paths.dart';
import 'package:lux_content_tools/src/parsers/usx_parser.dart';

void main() =>
    appAssetFile('translations/csb.json', app: .bible).writeAsStringSync(
      jsonEncode(
        BookType.values
            .map(
              (type) => parseUsxBook(
                type,
                sourceFile('bibles/csb/release/USX_1/${type.usxCode()}.usx')
                    .readAsStringSync()
                    .replaceAll('#', '')
                    .replaceAll(RegExp(r'\s+(?=<note)'), ''),
                includeInterlinear: false,
                shouldIgnoreElement: (element) =>
                    element.getAttribute('style') == 'sup' ||
                    element.getAttribute('category') == '(IV)',
                transformText: (text) => text.replaceAll('\u00a0', ' '),
              ),
            )
            .map((book) => book.toJson())
            .toList(),
      ),
    );
