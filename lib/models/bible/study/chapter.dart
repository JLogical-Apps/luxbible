import 'package:bible/models/bible/study/study_verse.dart';

class StudyChapter {
  final Map<int, StudyVerse> verses;

  const StudyChapter({required this.verses});
}
