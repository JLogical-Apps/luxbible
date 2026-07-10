import 'package:bible/utils/extensions/string_extensions.dart';
import 'package:collection/collection.dart';

class FootnoteMarkdown {
  static const italicStyles = {'fqa', 'fq', 'fqb', 'fk', 'bk', 'add', 'tl', 'qt', 'it', 'k'};

  static String runsToMarkdown(List<(String text, bool italic)> runs) => runs
      .where((run) => run.$1.isNotEmpty)
      .splitBetween((a, b) => a.$2 != b.$2)
      .map((group) {
        final text = group.map((run) => run.$1).join();
        return group.first.$2 ? _emphasize(text) : text;
      })
      .join()
      .withCollapsedWhitespace
      .trim();

  static String _emphasize(String text) {
    final core = text.trim();
    if (core.isEmpty) {
      return text;
    }

    final leading = text.substring(0, text.length - text.trimLeft().length);
    final trailing = text.substring(text.trimRight().length);
    return '$leading*$core*$trailing';
  }
}
