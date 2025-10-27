import 'package:bible/models/book_type.dart';

class Reference {
  final BookType bookType;
  final int chapter;
  final int verse;

  const Reference({required this.bookType, required this.chapter, required this.verse});
}
