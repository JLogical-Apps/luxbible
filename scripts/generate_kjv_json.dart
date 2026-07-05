import 'dart:convert';
import 'dart:io';

import 'package:bible/models/bible/book_type.dart';

import 'parsers/usx_parser.dart';

void main() => File('assets/translations/kjv.json').writeAsStringSync(
  jsonEncode(
    BookType.values
        .map((type) => parseUsxBook(type, File('source_files/bibles/kjv/${type.usxCode()}.usx').readAsStringSync()))
        .map((book) => book.toJson())
        .toList(),
  ),
);
