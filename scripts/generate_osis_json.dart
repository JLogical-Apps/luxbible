import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';

import 'parsers/osis_parser.dart';

void main() {
  for (final name in ['oshb', 'lxx', 'tr', 'byz', 'statresgnt', 'svv']) {
    File('assets/translations/$name.json').writeAsStringSync(
      jsonEncode(
        Directory('source_files/bibles/$name')
            .listSync()
            .whereType<File>()
            .where((file) => file.path.endsWith('.xml'))
            .map((file) => parseOsisBook(file.readAsStringSync(), verseParagraphs: name == 'oshb' || name == 'svv'))
            .sortedBy((a) => a.bookType.index)
            .map((book) => book.toJson())
            .toList(),
      ),
    );
  }
}
