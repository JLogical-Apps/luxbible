import 'package:bible/models/bible/interlinear_data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'word.freezed.dart';
part 'word.g.dart';

@freezed
sealed class Word with _$Word {
  const factory Word({
    @JsonKey(name: 't', includeIfNull: false) String? text,
    @JsonKey(name: 'd', includeIfNull: false) InterlinearData? data,
  }) = _Word;

  factory Word.fromJson(Map<String, dynamic> json) => _$WordFromJson(json);
}
