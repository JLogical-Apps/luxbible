import 'package:bible/models/book_type.dart';

class ChapterReference {
  final BookType book;
  final int chapterNum;

  const ChapterReference({required this.book, required this.chapterNum});
}
