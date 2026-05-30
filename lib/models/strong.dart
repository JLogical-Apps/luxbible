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
    @JsonKey(name: 'g') required List<String> glossary,
  }) = _Strong;

  factory Strong.fromJson(Map<String, dynamic> json) => _$StrongFromJson(json);
}
