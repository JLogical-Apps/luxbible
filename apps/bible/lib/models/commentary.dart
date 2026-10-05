import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lux/lux_core.dart';

part 'commentary.freezed.dart';
part 'commentary.g.dart';

@freezed
sealed class CommentaryBook with _$CommentaryBook {
  const CommentaryBook._();

  const factory CommentaryBook({
    @IgnoreIfEmpty(name: 's') @Default([]) List<CommentaryContent> summary,
    @IgnoreIfEmpty(name: 'i') @Default([]) List<CommentaryContent> introduction,
    @JsonKey(name: 'c') @Default({}) Map<int, List<CommentaryBlock>> blocksByChapter,
  }) = _CommentaryBook;

  factory CommentaryBook.fromJson(Map<String, dynamic> json) => _$CommentaryBookFromJson(json);

  Map<CommentaryBookSection, List<CommentaryContent>> get contentByBookSection => {
    if (summary.isNotEmpty) .summary: summary,
    if (introduction.isNotEmpty) .introduction: introduction,
  };

  List<CommentaryBlock> getBlocksFor(VerseSelection verseSelection) => verseSelection.references
      .groupListsBy((reference) => reference.chapterNum)
      .entries
      .expand(
        (entry) => (blocksByChapter[entry.key] ?? []).where(
          (block) => switch (block) {
            CommentaryOutline() => verseSelection.isChapter,
            CommentarySection(:final selection) => selection.references.containsAny(entry.value),
          },
        ),
      )
      .toList();
}

enum CommentaryBookSection { summary, introduction }

@Freezed(unionKey: 'r')
sealed class CommentaryBlock with _$CommentaryBlock {
  const CommentaryBlock._();

  @FreezedUnionValue('o')
  const factory CommentaryBlock.outline({@JsonKey(name: 'i') required List<CommentaryOutlineItem> items}) =
      CommentaryOutline;

  @FreezedUnionValue('s')
  const factory CommentaryBlock.section({
    @JsonKey(name: 'v') required VerseSelection selection,
    @JsonKey(name: 'b') required List<CommentaryContent> content,
  }) = CommentarySection;

  factory CommentaryBlock.fromJson(Map<String, dynamic> json) => _$CommentaryBlockFromJson(json);
}

@Freezed(unionKey: 'r')
sealed class CommentaryContent with _$CommentaryContent {
  @FreezedUnionValue('p')
  const factory CommentaryContent.paragraph({
    @JsonKey(name: 'x', toJson: Markdown.toJson, fromJson: Markdown.fromJson) required Markdown text,
    @JsonKey(name: 's') @Default(CommentaryParagraphStyle.body) CommentaryParagraphStyle style,
  }) = CommentaryParagraph;

  @FreezedUnionValue('t')
  const factory CommentaryContent.table({
    @JsonKey(name: 'w', toJson: Markdown.toJsonTable, fromJson: Markdown.fromJsonTable)
    required List<List<Markdown>> rows,
  }) = CommentaryTable;

  @FreezedUnionValue('m')
  const factory CommentaryContent.bibleMap({@JsonKey(name: 'i') required String id}) = CommentaryBibleMap;

  @FreezedUnionValue('b')
  const factory CommentaryContent.box({
    @JsonKey(name: 'h') required String title,
    @JsonKey(name: 'c') required List<CommentaryContent> content,
  }) = CommentaryBox;

  factory CommentaryContent.fromJson(Map<String, dynamic> json) => _$CommentaryContentFromJson(json);
}

enum CommentaryParagraphStyle {
  @JsonValue('b')
  body,
  @JsonValue('q')
  quote,
  @JsonValue('p')
  poetry,
  @JsonValue('c')
  centered,
  @JsonValue('a')
  attribution,
  @JsonValue('h')
  heading,
  @JsonValue('i')
  indented,
  @JsonValue('e')
  italic,
  @JsonValue('d')
  bold,
  @JsonValue('f')
  boldItalic,
}

@freezed
sealed class CommentaryOutlineItem with _$CommentaryOutlineItem {
  const factory CommentaryOutlineItem({
    @JsonKey(name: 'v') required VerseSelection selection,
    @JsonKey(name: 'x', toJson: Markdown.toJson, fromJson: Markdown.fromJson) required Markdown text,
  }) = _CommentaryOutlineItem;

  factory CommentaryOutlineItem.fromJson(Map<String, dynamic> json) => _$CommentaryOutlineItemFromJson(json);
}
