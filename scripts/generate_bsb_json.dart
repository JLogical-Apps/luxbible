import 'dart:convert';
import 'dart:io';

import 'package:bible/functions/usx_parser.dart';
import 'package:bible/models/bible/book_type.dart';

void main() => File('assets/translations/bsb.json').writeAsStringSync(
  jsonEncode(
    BookType.values
        .map((type) => parseUsxBook(type, File('source_files/bsb/${type.usxCode()}.usx').readAsStringSync()))
        .map((book) => book.toJson())
        .toList(),
  ),
);
