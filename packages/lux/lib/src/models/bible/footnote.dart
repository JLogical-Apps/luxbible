import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lux/lux.dart';

part 'footnote.freezed.dart';
part 'footnote.g.dart';

@freezed
sealed class Footnote with _$Footnote {
  const factory Footnote({
    @JsonKey(name: 'o') required int offset,
    @JsonKey(name: 't', toJson: Markdown.toJson, fromJson: Markdown.fromJson) required Markdown text,
  }) = _Footnote;

  factory Footnote.fromJson(Map<String, dynamic> json) => _$FootnoteFromJson(json);
}
