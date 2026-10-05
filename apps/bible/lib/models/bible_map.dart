import 'package:bible/models/linked_resource.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lux/lux_core.dart';

part 'bible_map.freezed.dart';
part 'bible_map.g.dart';

@freezed
sealed class BibleMap with _$BibleMap, LinkedResource {
  const BibleMap._();

  const factory BibleMap({
    @JsonKey(name: 'i') required String id,
    @JsonKey(name: 't') required String title,
    @JsonKey(name: 'c', includeIfNull: false) String? caption,
    @JsonKey(name: 'p') required List<VerseSelection> passages,
  }) = _BibleMap;

  factory BibleMap.fromJson(Map<String, dynamic> json) => _$BibleMapFromJson(json);

  String get imagePath => 'assets/maps/tyndale/$id.webp';
}
