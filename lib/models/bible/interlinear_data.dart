import 'package:freezed_annotation/freezed_annotation.dart';

part 'interlinear_data.freezed.dart';
part 'interlinear_data.g.dart';

@freezed
sealed class InterlinearData with _$InterlinearData {
  const factory InterlinearData({
    @JsonKey(name: 'o') required int originalPosition,
    @JsonKey(name: 'i', includeIfNull: false) required String? inflection,
    @JsonKey(name: 's', includeIfNull: false) String? strongId,
    @JsonKey(name: 'm', includeIfNull: false) String? morphology,
    @JsonKey(name: 't', includeIfNull: false) String? transliteration,
  }) = _InterlinearData;

  factory InterlinearData.fromJson(Map<String, dynamic> json) => _$InterlinearDataFromJson(json);
}
