import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lux/src/models/bible/book_type.dart';
import 'package:lux/src/models/bible/chapter.dart';

part 'book.freezed.dart';
part 'book.g.dart';

@freezed
sealed class Book with _$Book {
  const factory Book({
    @JsonKey(name: 'b') required BookType bookType,
    @JsonKey(name: 'c') required List<Chapter> chapters,
  }) = _Book;

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);
}
