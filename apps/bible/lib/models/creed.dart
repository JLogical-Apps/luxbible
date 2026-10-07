import 'package:bible/models/linked_resource.dart';
import 'package:bible/models/rich_content.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux_core.dart';

part 'creed.freezed.dart';
part 'creed.g.dart';

enum CreedType {
  creed,
  confession,
  catechism;

  String title() => switch (this) {
    creed => t.creeds.creeds,
    confession => t.creeds.confessions,
    catechism => t.creeds.catechisms,
  };

  String description() => switch (this) {
    creed => t.creeds.creedsDescription,
    confession => t.creeds.confessionsDescription,
    catechism => t.creeds.catechismsDescription,
  };
}

@freezed
sealed class Creed with _$Creed, LinkedResource {
  const Creed._();

  const factory Creed({
    @JsonKey(name: 'i') required String id,
    @JsonKey(name: 't') required String title,
    @JsonKey(name: 'y') required String year,
    @IgnoreIfEmpty(name: 'a') @Default([]) List<String> authors,
    @JsonKey(name: 'k') required CreedType type,
    @JsonKey(name: 'c') required List<CreedChapter> chapters,
  }) = _Creed;

  factory Creed.fromJson(Map<String, dynamic> json) => _$CreedFromJson(json);

  // Years are sometimes approximate, as in "c. 200".
  int get sortYear => int.parse(RegExp(r'-?\d+').firstMatch(year)!.group(0)!);

  List<CreedItemReference> get itemReferences => chapters
      .expand((chapter) => chapter.items.map((item) => CreedItemReference(creed: this, chapter: chapter, item: item)))
      .toList();
}

@freezed
sealed class CreedChapter with _$CreedChapter {
  const CreedChapter._();

  const factory CreedChapter({
    @JsonKey(name: 'n', includeIfNull: false) String? number,
    @JsonKey(name: 't', includeIfNull: false) String? title,
    @JsonKey(name: 'i') required List<CreedItem> items,
  }) = _CreedChapter;

  factory CreedChapter.fromJson(Map<String, dynamic> json) => _$CreedChapterFromJson(json);

  String? get heading => switch ((number, title)) {
    (final number?, final title?) => '$number. $title',
    (_, final title?) => title,
    (final number?, _) => number,
    _ => null,
  };
}

@freezed
sealed class CreedItem with _$CreedItem {
  const CreedItem._();

  const factory CreedItem({
    @JsonKey(name: 'n', includeIfNull: false) String? number,
    @JsonKey(name: 't', includeIfNull: false) String? title,
    @JsonKey(name: 'b') required List<RichContent> body,
    @IgnoreIfEmpty(name: 'p') @Default([]) List<VerseSelection> passages,
  }) = _CreedItem;

  factory CreedItem.fromJson(Map<String, dynamic> json) => _$CreedItemFromJson(json);

  Markdown? get preview => body.whereType<RichParagraph>().firstOrNull?.text;
}

class CreedItemReference with LinkedResource {
  final Creed creed;
  final CreedChapter chapter;
  final CreedItem item;

  CreedItemReference({required this.creed, required this.chapter, required this.item});

  String? get citation => switch ((creed.type, chapter.number, item.number)) {
    (.catechism, _, final number?) => t.creeds.questionNumber(number: number),
    (_, final chapterNumber?, final number?) => '$chapterNumber.$number',
    (_, _, final number?) => number,
    _ => item.title,
  };

  @override
  String get title => [creed.title, ?citation].join(' ');

  String get heading => switch ((item.number, item.title)) {
    (final number?, final title?) => '$number. $title',
    (_, final title?) => title,
    (final number?, _) when creed.type == .catechism => t.creeds.questionNumber(number: number),
    (final number?, _) => t.creeds.sectionNumber(number: number),
    _ => creed.title,
  };
}
