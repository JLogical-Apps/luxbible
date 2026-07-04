import 'package:bible/models/color_enum.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notebook.freezed.dart';
part 'notebook.g.dart';

@freezed
sealed class Notebook with _$Notebook {
  const Notebook._();

  const factory Notebook({required String id, required String name, @Default(ColorEnum.stone) ColorEnum color}) =
      _Notebook;

  factory Notebook.fromJson(Map<String, dynamic> json) => _$NotebookFromJson(json);
}
