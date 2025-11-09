import 'package:bible/models/verse_fragment.dart';

class Verse {
  final List<VerseFragment> fragments;

  const Verse({required this.fragments});

  String get text =>
      fragments.map((fragment) => fragment.text.replaceAll(RegExp(r'[\[\]]'), '')).join();
}
