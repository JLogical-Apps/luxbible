import 'package:bible/models/book_type.dart';
import 'package:bible/models/chapter.dart';

class Book {
  final BookType bookType;
  final List<Chapter> chapters;

  const Book({required this.bookType, required this.chapters});
}
