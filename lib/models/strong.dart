import 'package:freezed_annotation/freezed_annotation.dart';

part 'strong.freezed.dart';
part 'strong.g.dart';

@freezed
sealed class Strong with _$Strong {
  const factory Strong({
    @JsonKey(name: 'i') required String id,
    @JsonKey(name: 'l') required String languageText,
    @JsonKey(name: 'p') required String pronunciation,
    @JsonKey(name: 'x') required String transliteration,
    @JsonKey(name: 'd') required String definition,
    @JsonKey(name: 's') required String description,
    @JsonKey(name: 'o', includeIfNull: false) String? derivation,
    @JsonKey(name: 't', includeIfNull: false) String? partOfSpeech,
    @JsonKey(name: 'r', includeIfNull: false) String? lexiconReference,
    @JsonKey(name: 'g') required List<String> relatedStrongIds,
    @JsonKey(name: 'k') required Map<String, int> kjvUsage,
  }) = _Strong;

  factory Strong.fromJson(Map<String, dynamic> json) => _$StrongFromJson(json);
}
