// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_User _$UserFromJson(Map<String, dynamic> json) => _User(
  translation: $enumDecode(_$BibleTranslationEnumMap, json['translation']),
  studyTranslation:
      $enumDecodeNullable(
        _$BibleTranslationEnumMap,
        json['studyTranslation'],
      ) ??
      BibleTranslation.bsb,
  audioTranslation:
      $enumDecodeNullable(
        _$BibleTranslationEnumMap,
        json['audioTranslation'],
      ) ??
      BibleTranslation.bsb,
  oldTestamentTranslation:
      $enumDecodeNullable(
        _$BibleTranslationEnumMap,
        json['oldTestamentTranslation'],
      ) ??
      BibleTranslation.oshb,
  newTestamentTranslation:
      $enumDecodeNullable(
        _$BibleTranslationEnumMap,
        json['newTestamentTranslation'],
      ) ??
      BibleTranslation.statresgnt,
  compareBibles: _$JsonConverterFromJson<List<Object?>, List<BibleTranslation>>(
    json['bibles'],
    const KnownBibleTranslations().fromJson,
  ),
  recentBibles: json['recentBibles'] == null
      ? const []
      : const KnownBibleTranslations().fromJson(json['recentBibles'] as List),
  commentaries: _$JsonConverterFromJson<List<Object?>, List<CommentaryType>>(
    json['commentaries'],
    const KnownCommentaryTypes().fromJson,
  ),
  resourceOrder: _$JsonConverterFromJson<List<Object?>, List<ResourceType>>(
    json['resourceOrder'],
    const KnownResourceTypes().fromJson,
  ),
  lastPosition: ChapterPositionFromReference.read(json, 'lastReference') == null
      ? const ChapterPosition(
          reference: ChapterReference(chapterNum: 1, book: BookType.genesis),
        )
      : ChapterPosition.fromJson(
          ChapterPositionFromReference.read(json, 'lastReference')
              as Map<String, dynamic>,
        ),
  currentBookmarkId: json['currentBookmarkId'] as String?,
  viewHistory:
      (ChapterPositionFromReference.read(json, 'viewHistory') as List<dynamic>?)
          ?.map((e) => ChapterPosition.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  lastHighlightStyle:
      _readLastHighlightStyle(json, 'lastHighlightStyle') == null
      ? HighlightStyle.fallback
      : HighlightStyle.fromJson(
          _readLastHighlightStyle(json, 'lastHighlightStyle')
              as Map<String, dynamic>,
        ),
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
  notebooks:
      (json['notebooks'] as List<dynamic>?)
          ?.map((e) => Notebook.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  lastNotebookId: json['lastNotebookId'] as String?,
  isDefaultNotebookVisible: json['isDefaultNotebookVisible'] as bool? ?? true,
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
  studyPanels:
      (json['studyPanels'] as List<dynamic>?)
          ?.map((e) => StudyPanel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  studyPanelIndex: (json['studyPanelIndex'] as num?)?.toInt(),
  studyPanelBottomPosition:
      (json['studyPanelBottomPosition'] as num?)?.toDouble() ?? 0.5,
  tutorials: json['tutorials'] == null
      ? const {}
      : const KnownTutorials().fromJson(json['tutorials'] as List),
  onboarding: json['onboarding'] == null
      ? null
      : OnboardingProgress.fromJson(json['onboarding'] as Map<String, dynamic>),
  startedOnboardingTours: json['startedOnboardingTours'] == null
      ? const {}
      : const KnownOnboardingTours().fromJson(
          json['startedOnboardingTours'] as List,
        ),
  highlightStyleOverrides: (json['highlightStyles'] as List<dynamic>?)
      ?.map(
        (e) => _$recordConvert(
          e,
          ($jsonValue) => (
            HighlightStyle.fromJson($jsonValue[r'$1'] as Map<String, dynamic>),
            $jsonValue[r'$2'] as String,
          ),
        ),
      )
      .toList(),
  planProgressById:
      (json['planProgressByType'] as Map<String, dynamic>?)?.map(
        (k, e) =>
            MapEntry(k, BiblePlanProgress.fromJson(e as Map<String, dynamic>)),
      ) ??
      const {},
  verseOfTheDayReminder: json['verseOfTheDayReminder'] == null
      ? null
      : Reminder.fromJson(
          json['verseOfTheDayReminder'] as Map<String, dynamic>,
        ),
  audio: json['audio'] == null
      ? const AudioBibleConfiguration()
      : AudioBibleConfiguration.fromJson(json['audio'] as Map<String, dynamic>),
  latestMigration: $enumDecodeNullable(
    _$MigrationEnumMap,
    json['latestMigration'],
  ),
  messages:
      (json['messages'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$MessageEnumMap, e))
          .toSet() ??
      const {},
  activeDayCount: (json['activeDayCount'] as num?)?.toInt() ?? 0,
  lastActiveDate: json['lastActiveDate'] == null
      ? null
      : CalendarDateTime.fromJson(json['lastActiveDate'] as String),
  lastReviewRequestDate:
      _readLastReviewRequestDate(json, 'lastReviewRequestDate') == null
      ? null
      : CalendarDateTime.fromJson(
          _readLastReviewRequestDate(json, 'lastReviewRequestDate') as String,
        ),
  copy: json['copy'] == null
      ? const CopyConfiguration()
      : CopyConfiguration.fromJson(json['copy'] as Map<String, dynamic>),
  navigation: json['navigation'] == null
      ? const NavigationConfiguration()
      : NavigationConfiguration.fromJson(
          json['navigation'] as Map<String, dynamic>,
        ),
  lastSeenWhatsNewVersion: json['lastSeenWhatsNewVersion'] as String?,
);

Map<String, dynamic> _$UserToJson(_User instance) => <String, dynamic>{
  'translation': _$BibleTranslationEnumMap[instance.translation]!,
  'studyTranslation': _$BibleTranslationEnumMap[instance.studyTranslation]!,
  'audioTranslation': _$BibleTranslationEnumMap[instance.audioTranslation]!,
  'oldTestamentTranslation':
      _$BibleTranslationEnumMap[instance.oldTestamentTranslation]!,
  'newTestamentTranslation':
      _$BibleTranslationEnumMap[instance.newTestamentTranslation]!,
  'bibles': _$JsonConverterToJson<List<Object?>, List<BibleTranslation>>(
    instance.compareBibles,
    const KnownBibleTranslations().toJson,
  ),
  'recentBibles': const KnownBibleTranslations().toJson(instance.recentBibles),
  'commentaries': _$JsonConverterToJson<List<Object?>, List<CommentaryType>>(
    instance.commentaries,
    const KnownCommentaryTypes().toJson,
  ),
  'resourceOrder': _$JsonConverterToJson<List<Object?>, List<ResourceType>>(
    instance.resourceOrder,
    const KnownResourceTypes().toJson,
  ),
  'lastReference': instance.lastPosition.toJson(),
  'currentBookmarkId': instance.currentBookmarkId,
  'viewHistory': instance.viewHistory.map((e) => e.toJson()).toList(),
  'lastHighlightStyle': instance.lastHighlightStyle.toJson(),
  'bookmarkById': instance.bookmarkById.map((k, e) => MapEntry(k, e.toJson())),
  'annotations': instance.annotations.map((e) => e.toJson()).toList(),
  'notebooks': instance.notebooks.map((e) => e.toJson()).toList(),
  'lastNotebookId': instance.lastNotebookId,
  'isDefaultNotebookVisible': instance.isDefaultNotebookVisible,
  'mainToolbar': instance.mainToolbar.toJson(),
  'verseSelection': instance.verseSelection.toJson(),
  'textSelection': instance.textSelection.toJson(),
  'searchHistory': instance.searchHistory,
  'interlinearDirection':
      _$InterlinearDirectionEnumMap[instance.interlinearDirection]!,
  'theme': _$ThemeModeEnumMap[instance.theme]!,
  'themeLayout': instance.themeLayout.toJson(),
  'studyPanels': instance.studyPanels.map((e) => e.toJson()).toList(),
  'studyPanelIndex': instance.studyPanelIndex,
  'studyPanelBottomPosition': instance.studyPanelBottomPosition,
  'tutorials': const KnownTutorials().toJson(instance.tutorials),
  'onboarding': instance.onboarding?.toJson(),
  'startedOnboardingTours': const KnownOnboardingTours().toJson(
    instance.startedOnboardingTours,
  ),
  'highlightStyles': instance.highlightStyleOverrides
      ?.map((e) => <String, dynamic>{r'$1': e.$1.toJson(), r'$2': e.$2})
      .toList(),
  'planProgressByType': instance.planProgressById.map(
    (k, e) => MapEntry(k, e.toJson()),
  ),
  'verseOfTheDayReminder': instance.verseOfTheDayReminder?.toJson(),
  'audio': instance.audio.toJson(),
  'latestMigration': _$MigrationEnumMap[instance.latestMigration],
  'messages': instance.messages.map((e) => _$MessageEnumMap[e]!).toList(),
  'activeDayCount': instance.activeDayCount,
  'lastActiveDate': instance.lastActiveDate?.toJson(),
  'lastReviewRequestDate': instance.lastReviewRequestDate?.toJson(),
  'copy': instance.copy.toJson(),
  'navigation': instance.navigation.toJson(),
  'lastSeenWhatsNewVersion': instance.lastSeenWhatsNewVersion,
};

const _$BibleTranslationEnumMap = {
  BibleTranslation.htb: 'htb',
  BibleTranslation.nld1939: 'nld1939',
  BibleTranslation.sv: 'sv',
  BibleTranslation.amp: 'amp',
  BibleTranslation.asv: 'asv',
  BibleTranslation.bsb: 'bsb',
  BibleTranslation.csb: 'csb',
  BibleTranslation.kjv: 'kjv',
  BibleTranslation.msb: 'msb',
  BibleTranslation.nasb95: 'nasb95',
  BibleTranslation.niv11: 'niv11',
  BibleTranslation.nkjv: 'nkjv',
  BibleTranslation.nlt: 'nlt',
  BibleTranslation.web: 'web',
  BibleTranslation.fob: 'fob',
  BibleTranslation.martin1744: 'martin1744',
  BibleTranslation.elb1905: 'elb1905',
  BibleTranslation.hfa: 'hfa',
  BibleTranslation.lut1912: 'lut1912',
  BibleTranslation.byz: 'byz',
  BibleTranslation.lxx: 'lxx',
  BibleTranslation.statresgnt: 'statresgnt',
  BibleTranslation.tr: 'tr',
  BibleTranslation.oshb: 'oshb',
  BibleTranslation.ntr: 'ntr',
  BibleTranslation.nrt: 'nrt',
  BibleTranslation.synodal: 'synodal',
  BibleTranslation.rvg: 'rvg',
  BibleTranslation.tglulb: 'tglulb',
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

const _$InterlinearDirectionEnumMap = {
  InterlinearDirection.reverse: 'reverse',
  InterlinearDirection.forward: 'forward',
};

const _$ThemeModeEnumMap = {
  ThemeMode.system: 'system',
  ThemeMode.light: 'light',
  ThemeMode.dark: 'dark',
};

$Rec _$recordConvert<$Rec>(Object? value, $Rec Function(Map) convert) =>
    convert(value as Map<String, dynamic>);

const _$MigrationEnumMap = {
  Migration.renamedBiblePlans: 'renamedBiblePlans',
  Migration.anonymousAnalytics: 'anonymousAnalytics',
  Migration.addedTyndaleCommentary: 'addedTyndaleCommentary',
  Migration.optInOnboarding: 'optInOnboarding',
};

const _$MessageEnumMap = {
  Message.renamedBiblePlans: 'renamedBiblePlans',
  Message.anonymousAnalytics: 'anonymousAnalytics',
};

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);
