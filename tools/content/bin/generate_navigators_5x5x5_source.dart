import 'dart:convert';

import 'package:lux_content_tools/repository_paths.dart';

void main() =>
    sourceFile('reading_plans/navigators_5x5x5_nt.json').writeAsStringSync(
      jsonEncode({
        'name': '5x5x5 New Testament',
        'data2': List.generate(
          52,
          (weekIndex) => [
            ...readings.skip(weekIndex * 5).take(5),
            <String>[],
            <String>[],
          ],
        ).expand((week) => week).toList(),
      }),
    );

final readings =
    [
          ('Mark', 16),
          ('Acts', 28),
          ('Hebrews', 13),
          ('Galatians', 6),
          ('James', 5),
          ('Matthew', 28),
          ('Romans', 16),
          ('Ephesians', 6),
          ('Philippians', 4),
          ('Colossians', 4),
          ('Philemon', 1),
          ('Luke', 24),
          ('1 Corinthians', 16),
          ('2 Corinthians', 13),
          ('1 Timothy', 6),
          ('2 Timothy', 4),
          ('Titus', 3),
          ('1 John', 5),
          ('2 John', 1),
          ('3 John', 1),
          ('1 Peter', 5),
          ('John', 21),
          ('1 Thessalonians', 5),
          ('2 Thessalonians', 3),
          ('2 Peter', 3),
          ('Jude', 1),
          ('Revelation', 22),
        ]
        .expand(
          (book) => List.generate(
            book.$2,
            (chapterIndex) => ['${book.$1} ${chapterIndex + 1}'],
          ),
        )
        .toList();
