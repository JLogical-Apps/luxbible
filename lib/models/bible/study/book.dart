import 'package:bible/models/bible/book_type.dart';
import 'package:bible/models/bible/study/chapter.dart';

class StudyBook {
  final BookType bookType;
  final List<StudyChapter> chapters;

  const StudyBook({required this.bookType, required this.chapters});
}
