import 'package:bible/models/bible/verse.dart';

class Chapter {
  final Map<int, Verse> verses;

  const Chapter({required this.verses});
}
