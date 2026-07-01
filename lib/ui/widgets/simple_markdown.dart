import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class SimpleMarkdown extends StatelessWidget {
  final String text;

  const SimpleMarkdown({super.key, required this.text});

  static final _pattern = RegExp(r'\*\*(.+?)\*\*|\*(.+?)\*', dotAll: true);

  @override
  Widget build(BuildContext context) {
    final matches = _pattern.allMatches(text).toList();
    return Text.rich(
      TextSpan(
        children: [
          ...matches.mapIndexed((index, match) {
            final gapStart = index == 0 ? 0 : matches[index - 1].end;
            final bold = match.group(1);
            return [
              if (match.start > gapStart) TextSpan(text: text.substring(gapStart, match.start)),
              TextSpan(
                text: bold ?? match.group(2),
                style: bold != null ? TextStyle(fontWeight: .bold) : TextStyle(fontStyle: .italic),
              ),
            ];
          }).flattened,
          if ((matches.lastOrNull?.end ?? 0) < text.length)
            TextSpan(text: text.substring(matches.lastOrNull?.end ?? 0)),
        ],
      ),
    );
  }
}
