import 'package:bible/models/verse_fragment.dart';
import 'package:bible/utils/extensions/string_extensions.dart';

class Verse {
  final List<VerseFragment> fragments;

  Verse({required this.fragments});

  late final String text = fragments.map((fragment) => fragment.text.replaceAll(RegExp(r'[\[\]]'), '')).join();

  late final List<String> searchTerms = text.toLowerCase().onlyLetters.split(' ').toList();
}
