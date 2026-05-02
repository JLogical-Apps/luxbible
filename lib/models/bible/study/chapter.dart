import 'package:bible/models/bible/study/study_verse.dart';

class StudyChapter {
  final int chapterNum;
  final Map<int, StudyVerse> verses;

  const StudyChapter({required this.chapterNum, required this.verses});
}
