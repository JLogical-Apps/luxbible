import 'package:bible/models/color_enum.dart';
import 'package:bible/models/reference/selection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'annotation.freezed.dart';
part 'annotation.g.dart';

@freezed
sealed class Annotation with _$Annotation {
  const Annotation._();

  const factory Annotation({
    required Selection selection,
    @Default(ColorEnum.stone) ColorEnum color,
    String? note,
    required DateTime createdAt,
  }) = _Annotation;

  factory Annotation.fromJson(Map<String, dynamic> json) => _$AnnotationFromJson(json);
}
