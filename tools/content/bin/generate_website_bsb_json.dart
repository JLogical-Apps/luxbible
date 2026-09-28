import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:lux/lux_core.dart';
import 'package:lux_content_tools/repository_paths.dart';
import 'package:lux_content_tools/src/parsers/usx_parser.dart';

void main() => websiteFile('data/bsb.json').writeAsStringSync(
  jsonEncode({
    for (final type in BookType.values)
      type.osisId(): parseUsxBook(
        type,
        sourceFile('bibles/bsb/${type.usxCode()}.usx').readAsStringSync(),
        includeInterlinear: false,
      ).chapters.map(getVerseTexts).toList(),
  }),
);

List<String> getVerseTexts(Chapter chapter) => Range.generate(
  1,
  chapter.verses.keys.max,
).map((verseNum) => chapter.verses[verseNum]?.text.withCollapsedWhitespace ?? '').toList();
