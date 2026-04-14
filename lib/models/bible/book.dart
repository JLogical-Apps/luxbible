import 'package:bible/models/bible/book_type.dart';
import 'package:bible/models/bible/chapter.dart';

class Book {
  final BookType bookType;
  final List<Chapter> chapters;

  const Book({required this.bookType, required this.chapters});
}
