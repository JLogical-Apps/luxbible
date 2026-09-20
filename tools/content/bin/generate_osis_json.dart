import 'dart:io';

import 'package:collection/collection.dart';
import 'package:lux/lux_core.dart';
import 'package:lux_content_tools/repository_paths.dart';
import 'package:lux_content_tools/src/parsers/osis_parser.dart';

void main() {
  for (final translation in const <BibleTranslation>[
    .oshb,
    .lxx,
    .tr,
    .byz,
    .statresgnt,
    .sv,
    .fob,
    .martin1744,
    .rvg,
    .nld1939,
    .elb1905,
    .lut1912,
    .synodal,
  ]) {
    writeBibleBooks(
      translation: translation.name,
      app: .bible,
      books: sourceDirectory('bibles/${translation.name}')
          .listSync()
          .whereType<File>()
          .where((file) => file.path.endsWith('.xml'))
          .map(
            (file) => parseOsisBook(
              file.readAsStringSync(),
              verseParagraphs: !translation.hasParagraphs,
            ),
          )
          .sortedBy((book) => book.bookType.index),
    );
  }
}
