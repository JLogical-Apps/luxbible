// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Article _$ArticleFromJson(Map<String, dynamic> json) => _Article(
  id: json['i'] as String,
  title: json['t'] as String,
  body: (json['b'] as List<dynamic>)
      .map((e) => CommentaryContent.fromJson(e as Map<String, dynamic>))
      .toList(),
  passages:
      (json['p'] as List<dynamic>?)
          ?.map((e) => VerseSelection.fromJson(e as String))
          .toList() ??
      const [],
);

Map<String, dynamic> _$ArticleToJson(_Article instance) => <String, dynamic>{
  'i': instance.id,
  't': instance.title,
  'b': instance.body.map((e) => e.toJson()).toList(),
  'p': ?nullIfEmpty(instance.passages),
};
