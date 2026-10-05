import 'package:bible/models/rich_content.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lux/lux_core.dart';

part 'commentary.freezed.dart';
part 'commentary.g.dart';

@freezed
sealed class CommentaryBook with _$CommentaryBook {
  const CommentaryBook._();

  const factory CommentaryBook({
    @IgnoreIfEmpty(name: 's') @Default([]) List<RichContent> summary,
    @IgnoreIfEmpty(name: 'i') @Default([]) List<RichContent> introduction,
    @JsonKey(name: 'c') @Default({}) Map<int, List<CommentaryBlock>> blocksByChapter,
  }) = _CommentaryBook;

  factory CommentaryBook.fromJson(Map<String, dynamic> json) => _$CommentaryBookFromJson(json);

  Map<CommentaryBookSection, List<RichContent>> get contentByBookSection => {
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
    @JsonKey(name: 'b') required List<RichContent> content,
  }) = CommentarySection;

  factory CommentaryBlock.fromJson(Map<String, dynamic> json) => _$CommentaryBlockFromJson(json);
}

@freezed
sealed class CommentaryOutlineItem with _$CommentaryOutlineItem {
  const factory CommentaryOutlineItem({
    @JsonKey(name: 'v') required VerseSelection selection,
    @JsonKey(name: 'x', toJson: Markdown.toJson, fromJson: Markdown.fromJson) required Markdown text,
  }) = _CommentaryOutlineItem;

  factory CommentaryOutlineItem.fromJson(Map<String, dynamic> json) => _$CommentaryOutlineItemFromJson(json);
}
