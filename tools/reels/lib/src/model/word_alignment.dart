import 'package:collection/collection.dart';

// For each typed word, the index of the heard word whose timing it takes. Both lists must be non-empty. A
// substitution costs less than a delete plus an insert, so a corrected word inherits the timing of the word it
// replaces, and an inserted word shares the timing of the aligned word before it (or after it, at the start).
List<int> anchorWords(List<String> heard, List<String> typed) {
  String normalized(String word) => word.toLowerCase().replaceAll(RegExp('[^a-z0-9]'), '');
  int substitutionCost(int i, int j) => normalized(heard[i]) == normalized(typed[j]) ? 0 : 1;

  final distances = heard.indexed.fold([List.generate(typed.length + 1, (j) => j)], (rows, heardEntry) {
    final i = heardEntry.$1;
    final above = rows.last;
    final row = Iterable.generate(typed.length)
        .fold([i + 1], (row, j) => row..add([above[j + 1] + 1, row[j] + 1, above[j] + substitutionCost(i, j)].min));
    return rows..add(row);
  });

  final aligned = List<int?>.filled(typed.length, null);
  var (i, j) = (heard.length, typed.length);
  while (i > 0 && j > 0) {
    if (distances[i][j] == distances[i - 1][j - 1] + substitutionCost(i - 1, j - 1)) {
      aligned[j - 1] = i - 1;
      (i, j) = (i - 1, j - 1);
    } else if (distances[i][j] == distances[i - 1][j] + 1) {
      i--;
    } else {
      j--;
    }
  }

  return aligned
      .mapIndexed((j, anchor) => anchor ?? aligned.take(j).nonNulls.lastOrNull ?? aligned.skip(j).nonNulls.first)
      .toList();
}
