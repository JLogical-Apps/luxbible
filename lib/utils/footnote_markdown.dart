import 'package:bible/models/bible/book_type.dart';
import 'package:bible/utils/extensions/string_extensions.dart';
import 'package:collection/collection.dart';

typedef FootnoteMarkdownRun = ({String text, bool italic, String? link});

class FootnoteMarkdown {
  static const italicStyles = {'fqa', 'fq', 'fqb', 'fk', 'bk', 'add', 'tl', 'qt', 'it', 'k'};

  static String runsToMarkdown(List<FootnoteMarkdownRun> runs) => runs
      .where((run) => run.text.isNotEmpty)
      .splitBetween((a, b) => a.italic != b.italic || a.link != b.link)
      .map((group) {
        final run = group.first;
        final text = group.map((run) => run.text).join();
        final formatted = run.italic ? _wrap(text, '*', '*') : text;
        return switch (run.link) {
          final link? => _wrap(_escapeLinkText(formatted), '[', ']($link)'),
          null => formatted,
        };
      })
      .join()
      .withCollapsedWhitespace
      .trim();

  static String? osisIdFromUsxReference(String? value) {
    if (value == null) return null;

    try {
      return value
          .split('+')
          .map((reference) {
            final match = RegExp(r'^([1-3]?[A-Z]{2,3})[ .](.+)$').firstMatch(reference.trim().toUpperCase());
            if (match == null) throw FormatException('Invalid USX reference: $reference');

            final usxCode = match.group(1)!;
            final book = BookType.values.firstWhereOrNull((book) => book.usxCode() == usxCode);
            if (book == null) throw FormatException('Unknown USX book: $usxCode');

            final range = match.group(2)!.replaceAll('$usxCode.', '').replaceAll('.', ':');
            final parts = range.split('-');
            if (parts.length > 2) throw FormatException('Invalid USX range: $range');

            final start = parts.first.split(':');
            final startOsis = [book.osisId(), ...start].join('.');
            if (parts.length == 1) return startOsis;

            final end = parts.last.split(':');
            final endOsis = end.length == 1 && start.length == 2
                ? [book.osisId(), start.first, end.first].join('.')
                : [book.osisId(), ...end].join('.');
            return '$startOsis-$endOsis';
          })
          .join(' ');
    } catch (_) {
      return null;
    }
  }

  static String _wrap(String text, String prefix, String suffix) {
    final core = text.trim();
    if (core.isEmpty) {
      return text;
    }

    final leading = text.substring(0, text.length - text.trimLeft().length);
    final trailing = text.substring(text.trimRight().length);
    return '$leading$prefix$core$suffix$trailing';
  }

  static String _escapeLinkText(String text) =>
      text.replaceAll(r'\', r'\\').replaceAll('[', r'\[').replaceAll(']', r'\]');
}
