import 'dart:convert';
import 'dart:io';

import 'package:bible/models/bible/book_type.dart';

import 'parsers/usx_parser.dart';

void main() => File('assets/translations/bsb.json').writeAsStringSync(
  jsonEncode(
    BookType.values
        .map((type) => parseUsxBook(type, File('source_files/bibles/bsb/${type.usxCode()}.usx').readAsStringSync()))
        .map((book) => book.toJson())
        .toList(),
  ),
);
