// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_User _$UserFromJson(Map<String, dynamic> json) => _User(
  translation:
      $enumDecodeNullable(_$BibleTranslationEnumMap, json['translation']) ??
      BibleTranslation.bsb,
  studyTranslation:
      $enumDecodeNullable(
        _$BibleTranslationEnumMap,
        json['studyTranslation'],
      ) ??
      BibleTranslation.bsb,
  bibles: (json['bibles'] as List<dynamic>?)
      ?.map((e) => $enumDecode(_$BibleTranslationEnumMap, e))
      .toList(),
  commentaries: (json['commentaries'] as List<dynamic>?)
      ?.map((e) => $enumDecode(_$CommentaryTypeEnumMap, e))
      .toList(),
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
  tutorials:
      (json['tutorials'] as List<dynamic>?)
          ?.map(
            (e) => $enumDecodeNullable(
              _$TutorialEnumMap,
              e,
              unknownValue: JsonKey.nullForUndefinedEnumValue,
            ),
          )
          .toSet() ??
      const {},
  completedOnboardingSteps: (json['completedOnboardingSteps'] as List<dynamic>?)
      ?.map((e) => $enumDecode(_$OnboardingStepEnumMap, e))
      .toList(),
  highlightStyles:
      (json['highlightStyles'] as List<dynamic>?)
          ?.map(
            (e) => _$recordConvert(
              e,
              ($jsonValue) => (
                HighlightStyle.fromJson(
                  $jsonValue[r'$1'] as Map<String, dynamic>,
                ),
                $jsonValue[r'$2'] as String,
              ),
            ),
          )
          .toList() ??
      HighlightStyle.defaultValues,
  planProgressByType:
      (json['planProgressByType'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(
          $enumDecode(_$BiblePlanTypeEnumMap, k),
          BiblePlanProgress.fromJson(e as Map<String, dynamic>),
        ),
      ) ??
      const {},
  completedPlans:
      (json['completedPlans'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$BiblePlanTypeEnumMap, e))
          .toSet() ??
      const {},
);

Map<String, dynamic> _$UserToJson(_User instance) => <String, dynamic>{
  'translation': _$BibleTranslationEnumMap[instance.translation]!,
  'studyTranslation': _$BibleTranslationEnumMap[instance.studyTranslation]!,
  'bibles': instance.bibles?.map((e) => _$BibleTranslationEnumMap[e]!).toList(),
  'commentaries': instance.commentaries
      ?.map((e) => _$CommentaryTypeEnumMap[e]!)
      .toList(),
  'lastReference': instance.lastPosition.toJson(),
  'currentBookmarkId': instance.currentBookmarkId,
  'viewHistory': instance.viewHistory.map((e) => e.toJson()).toList(),
  'lastHighlightStyle': instance.lastHighlightStyle.toJson(),
  'bookmarkById': instance.bookmarkById.map((k, e) => MapEntry(k, e.toJson())),
  'annotations': instance.annotations.map((e) => e.toJson()).toList(),
  'notebooks': instance.notebooks.map((e) => e.toJson()).toList(),
  'lastNotebookId': instance.lastNotebookId,
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
  'tutorials': instance.tutorials.map((e) => _$TutorialEnumMap[e]).toList(),
  'completedOnboardingSteps': instance.completedOnboardingSteps
      ?.map((e) => _$OnboardingStepEnumMap[e]!)
      .toList(),
  'highlightStyles': instance.highlightStyles
      .map((e) => <String, dynamic>{r'$1': e.$1.toJson(), r'$2': e.$2})
      .toList(),
  'planProgressByType': instance.planProgressByType.map(
    (k, e) => MapEntry(_$BiblePlanTypeEnumMap[k]!, e.toJson()),
  ),
  'completedPlans': instance.completedPlans
      .map((e) => _$BiblePlanTypeEnumMap[e]!)
      .toList(),
};

const _$BibleTranslationEnumMap = {
  BibleTranslation.bsb: 'bsb',
  BibleTranslation.nasb95: 'nasb95',
  BibleTranslation.niv11: 'niv11',
  BibleTranslation.kjv: 'kjv',
  BibleTranslation.asv: 'asv',
  BibleTranslation.lxx: 'lxx',
  BibleTranslation.tr: 'tr',
  BibleTranslation.byz: 'byz',
  BibleTranslation.statresgnt: 'statresgnt',
  BibleTranslation.oshb: 'oshb',
  BibleTranslation.sv: 'sv',
};

const _$CommentaryTypeEnumMap = {
  CommentaryType.matthewHenry: 'matthewHenry',
  CommentaryType.jamiesonFaussetBrown: 'jamiesonFaussetBrown',
  CommentaryType.calvin: 'calvin',
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

const _$TutorialEnumMap = {
  Tutorial.interlinearStudy: 'interlinearStudy',
  Tutorial.crossReferencesStudy: 'crossReferencesStudy',
  Tutorial.searchStudy: 'searchStudy',
};

const _$OnboardingStepEnumMap = {
  OnboardingStep.crossReferences: 'crossReferences',
  OnboardingStep.annotateVerse: 'annotateVerse',
  OnboardingStep.searchWord: 'searchWord',
  OnboardingStep.changeBible: 'changeBible',
  OnboardingStep.navigateChapter: 'navigateChapter',
  OnboardingStep.goBack: 'goBack',
  OnboardingStep.swipeChapter: 'swipeChapter',
  OnboardingStep.addStudyPanel: 'addStudyPanel',
  OnboardingStep.customizeToolbar: 'customizeToolbar',
};

$Rec _$recordConvert<$Rec>(Object? value, $Rec Function(Map) convert) =>
    convert(value as Map<String, dynamic>);

const _$BiblePlanTypeEnumMap = {
  BiblePlanType.esv_through_the_bible: 'esv_through_the_bible',
  BiblePlanType.one_year_chronological: 'one_year_chronological',
  BiblePlanType.heartlight_ot_and_nt: 'heartlight_ot_and_nt',
  BiblePlanType.esv_every_day_in_word: 'esv_every_day_in_word',
  BiblePlanType.mcheyne: 'mcheyne',
  BiblePlanType.esv_literary_study_bible: 'esv_literary_study_bible',
  BiblePlanType.esv_gospels_and_epistles: 'esv_gospels_and_epistles',
  BiblePlanType.esv_pentateuch_and_history_of_israel:
      'esv_pentateuch_and_history_of_israel',
  BiblePlanType.esv_chronicles_and_prophets: 'esv_chronicles_and_prophets',
  BiblePlanType.esv_psalms_and_wisdom_literature:
      'esv_psalms_and_wisdom_literature',
};
