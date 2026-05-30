import 'package:bible/models/bible/word.dart';
import 'package:bible/utils/extensions/string_extensions.dart';
import 'package:utils_core/utils_core.dart';

class Verse {
  final int verseNum;
  final List<Word> words;

  const Verse({required this.verseNum, required this.words});

  String get text => words.map((word) => word.text).nonNulls.join();
  List<String> get strongIds => words.map((word) => word.data?.strongId).nonNulls.toList();
  List<String> get searchTerms => text.keywords;

  Verse trimStart() => Verse(
    verseNum: verseNum,
    words: words.skipWhile((word) => word.text?.isBlank == true && word.data == null).toList(),
  );
}
