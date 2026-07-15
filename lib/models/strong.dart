import 'package:bible/utils/markdown.dart';
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
    @JsonKey(name: 'd', toJson: Markdown.toJson, fromJson: Markdown.fromJson) required Markdown definition,
    @JsonKey(name: 's', toJson: Markdown.toJson, fromJson: Markdown.fromJson) required Markdown description,
    @JsonKey(name: 'o', includeIfNull: false, toJson: Markdown.toJsonNullable, fromJson: Markdown.fromJsonNullable)
    Markdown? derivation,
    @JsonKey(name: 't', includeIfNull: false) String? partOfSpeech,
    @JsonKey(name: 'r', includeIfNull: false) String? lexiconReference,
    @JsonKey(name: 'g') required List<String> relatedStrongIds,
    @JsonKey(name: 'k') required Map<String, int> kjvUsage,
  }) = _Strong;

  factory Strong.fromJson(Map<String, dynamic> json) => _$StrongFromJson(json);
}
