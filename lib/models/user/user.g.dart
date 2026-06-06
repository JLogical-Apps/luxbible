// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_User _$UserFromJson(Map<String, dynamic> json) => _User(
  translation:
      $enumDecodeNullable(_$BibleTranslationEnumMap, json['translation']) ??
      BibleTranslation.bsb,
  lastReference: json['lastReference'] == null
      ? const ChapterReference(chapterNum: 1, book: BookType.genesis)
      : ChapterReference.fromJson(json['lastReference'] as String),
  currentBookmarkId: json['currentBookmarkId'] as String?,
  viewHistory:
      (json['viewHistory'] as List<dynamic>?)
          ?.map((e) => ChapterReference.fromJson(e as String))
          .toList() ??
      const [],
  highlightColor:
      $enumDecodeNullable(_$ColorEnumEnumMap, json['highlightColor']) ??
      ColorEnum.yellow,
  bookmarkById:
      (json['bookmarkById'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, Bookmark.fromJson(e as Map<String, dynamic>)),
      ) ??
      const {},
  annotations:
      (json['annotations'] as List<dynamic>?)
          ?.map((e) => Annotation.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  mainToolbar: json['mainToolbar'] == null
      ? const MainToolbarConfiguration()
      : MainToolbarConfiguration.fromJson(
          json['mainToolbar'] as Map<String, dynamic>,
        ),
  verseSelection: json['verseSelection'] == null
      ? const VerseSelectionConfiguration()
      : VerseSelectionConfiguration.fromJson(
          json['verseSelection'] as Map<String, dynamic>,
        ),
  textSelection: json['textSelection'] == null
      ? const TextSelectionConfiguration()
      : TextSelectionConfiguration.fromJson(
          json['textSelection'] as Map<String, dynamic>,
        ),
  searchHistory:
      (json['searchHistory'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  interlinearDirection:
      $enumDecodeNullable(
        _$InterlinearDirectionEnumMap,
        json['interlinearDirection'],
      ) ??
      InterlinearDirection.reverse,
  theme:
      $enumDecodeNullable(_$ThemeModeEnumMap, json['theme']) ??
      ThemeMode.system,
  themeLayout: json['themeLayout'] == null
      ? const ThemeLayoutConfiguration()
      : ThemeLayoutConfiguration.fromJson(
          json['themeLayout'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$UserToJson(_User instance) => <String, dynamic>{
  'translation': _$BibleTranslationEnumMap[instance.translation]!,
  'lastReference': instance.lastReference.toJson(),
  'currentBookmarkId': instance.currentBookmarkId,
  'viewHistory': instance.viewHistory.map((e) => e.toJson()).toList(),
  'highlightColor': _$ColorEnumEnumMap[instance.highlightColor]!,
  'bookmarkById': instance.bookmarkById.map((k, e) => MapEntry(k, e.toJson())),
  'annotations': instance.annotations.map((e) => e.toJson()).toList(),
  'mainToolbar': instance.mainToolbar.toJson(),
  'verseSelection': instance.verseSelection.toJson(),
  'textSelection': instance.textSelection.toJson(),
  'searchHistory': instance.searchHistory,
  'interlinearDirection':
      _$InterlinearDirectionEnumMap[instance.interlinearDirection]!,
  'theme': _$ThemeModeEnumMap[instance.theme]!,
  'themeLayout': instance.themeLayout.toJson(),
};

const _$BibleTranslationEnumMap = {
  BibleTranslation.bsb: 'bsb',
  BibleTranslation.kjv: 'kjv',
  BibleTranslation.asv: 'asv',
};

const _$ColorEnumEnumMap = {
  ColorEnum.red: 'red',
  ColorEnum.orange: 'orange',
  ColorEnum.yellow: 'yellow',
  ColorEnum.green: 'green',
  ColorEnum.blue: 'blue',
  ColorEnum.violet: 'violet',
  ColorEnum.stone: 'stone',
};

const _$InterlinearDirectionEnumMap = {
  InterlinearDirection.reverse: 'reverse',
  InterlinearDirection.forward: 'forward',
};

const _$ThemeModeEnumMap = {
  ThemeMode.system: 'system',
  ThemeMode.light: 'light',
  ThemeMode.dark: 'dark',
};
