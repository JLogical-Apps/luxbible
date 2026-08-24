import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:lux_content_tools/repository_paths.dart';
import 'package:lux_content_tools/src/parsers/osis_parser.dart';

void main() {
  for (final name in [
    'oshb',
    'lxx',
    'tr',
    'byz',
    'statresgnt',
    'sv',
    'fob',
    'martin1744',
    'rvg',
    'nld1939',
  ]) {
    appAssetFile('translations/$name.json', app: .bible).writeAsStringSync(
      jsonEncode(
        sourceDirectory('bibles/$name')
            .listSync()
            .whereType<File>()
            .where((file) => file.path.endsWith('.xml'))
            .map(
              (file) => parseOsisBook(
                file.readAsStringSync(),
                verseParagraphs: switch (name) {
                  'oshb' || 'sv' || 'martin1744' => true,
                  _ => false,
                },
              ),
            )
            .sortedBy((a) => a.bookType.index)
            .map((book) => book.toJson())
            .toList(),
      ),
    );
  }
}
