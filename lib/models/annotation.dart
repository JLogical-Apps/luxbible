import 'package:bible/models/color_enum.dart';
import 'package:bible/models/reference/passage.dart';
import 'package:bible/models/reference/selection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'annotation.freezed.dart';
part 'annotation.g.dart';

@freezed
sealed class Annotation with _$Annotation {
  const Annotation._();

  const factory Annotation({
    @Default([]) List<Selection> selections,
    @Default([]) List<Passage> passages,
    @Default(ColorEnum.stone) ColorEnum color,
    String? note,
    required DateTime createdAt,
  }) = _Annotation;

  factory Annotation.fromJson(Map<String, dynamic> json) => _$AnnotationFromJson(json);

  bool get isEmpty => selections.isEmpty && passages.isEmpty;
  bool get isNotEmpty => !isEmpty;
}
