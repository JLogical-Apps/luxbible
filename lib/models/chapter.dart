import 'package:bible/models/verse.dart';

class Chapter {
  final Map<int, Verse> verses;

  const Chapter({required this.verses});
}
