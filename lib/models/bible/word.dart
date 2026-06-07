import 'package:bible/models/bible/interlinear_data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'word.freezed.dart';
part 'word.g.dart';

@freezed
sealed class Word with _$Word {
  const factory Word({
    @JsonKey(name: 't', includeIfNull: false) String? text,
    @JsonKey(name: 'd', includeIfNull: false) InterlinearData? data,
    @JsonKey(name: 'r', toJson: _onlyIfTrue, includeIfNull: false) @Default(false) bool redLetters,
    @JsonKey(name: 'i', toJson: _onlyIfTrue, includeIfNull: false) @Default(false) bool italic,
  }) = _Word;

  factory Word.fromJson(Map<String, dynamic> json) => _$WordFromJson(json);
}

bool? _onlyIfTrue(bool value) => value ? value : null;
