// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commentary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CommentaryBook _$CommentaryBookFromJson(Map<String, dynamic> json) =>
    _CommentaryBook(
      summary:
          (json['s'] as List<dynamic>?)
              ?.map((e) => RichContent.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      introduction:
          (json['i'] as List<dynamic>?)
              ?.map((e) => RichContent.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      blocksByChapter:
          (json['c'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(
              int.parse(k),
              (e as List<dynamic>)
                  .map(
                    (e) => CommentaryBlock.fromJson(e as Map<String, dynamic>),
                  )
                  .toList(),
            ),
          ) ??
          const {},
    );

Map<String, dynamic> _$CommentaryBookToJson(_CommentaryBook instance) =>
    <String, dynamic>{
      's': ?nullIfEmpty(instance.summary),
      'i': ?nullIfEmpty(instance.introduction),
      'c': instance.blocksByChapter.map(
        (k, e) => MapEntry(k.toString(), e.map((e) => e.toJson()).toList()),
      ),
    };

CommentaryOutline _$CommentaryOutlineFromJson(Map<String, dynamic> json) =>
    CommentaryOutline(
      items: (json['i'] as List<dynamic>)
          .map((e) => CommentaryOutlineItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      $type: json['r'] as String?,
    );

Map<String, dynamic> _$CommentaryOutlineToJson(CommentaryOutline instance) =>
    <String, dynamic>{
      'i': instance.items.map((e) => e.toJson()).toList(),
      'r': instance.$type,
    };

CommentarySection _$CommentarySectionFromJson(Map<String, dynamic> json) =>
    CommentarySection(
      selection: VerseSelection.fromJson(json['v'] as String),
      content: (json['b'] as List<dynamic>)
          .map((e) => RichContent.fromJson(e as Map<String, dynamic>))
          .toList(),
      $type: json['r'] as String?,
    );

Map<String, dynamic> _$CommentarySectionToJson(CommentarySection instance) =>
    <String, dynamic>{
      'v': instance.selection.toJson(),
      'b': instance.content.map((e) => e.toJson()).toList(),
      'r': instance.$type,
    };

_CommentaryOutlineItem _$CommentaryOutlineItemFromJson(
  Map<String, dynamic> json,
) => _CommentaryOutlineItem(
  selection: VerseSelection.fromJson(json['v'] as String),
  text: Markdown.fromJson(json['x'] as String),
);

Map<String, dynamic> _$CommentaryOutlineItemToJson(
  _CommentaryOutlineItem instance,
) => <String, dynamic>{
  'v': instance.selection.toJson(),
  'x': Markdown.toJson(instance.text),
};
