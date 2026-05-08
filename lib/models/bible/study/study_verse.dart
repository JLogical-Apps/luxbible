import 'package:bible/models/bible/study/verse_fragment.dart';
import 'package:bible/utils/extensions/string_extensions.dart';

class StudyVerse {
  final List<VerseFragment> fragments;

  StudyVerse({required this.fragments});

  late final String text = fragments.map((fragment) => fragment.text.replaceAll(RegExp(r'[\[\]]'), '')).join();
  late final List<String> strongIds = fragments.map((fragment) => fragment.study?.strongId).nonNulls.toList();

  late final List<String> searchTerms = text.toLowerCase().onlyLetters.split(' ').toList();
}
