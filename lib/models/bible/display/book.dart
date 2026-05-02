import 'package:bible/models/bible/book_type.dart';
import 'package:bible/models/bible/display/chapter.dart';

class DisplayBook {
  final BookType bookType;
  final List<DisplayChapter> chapters;

  const DisplayBook({required this.bookType, required this.chapters});
}
