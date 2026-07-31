// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$User {

 BibleTranslation get translation; BibleTranslation get studyTranslation; BibleTranslation get audioTranslation; BibleTranslation get oldTestamentTranslation; BibleTranslation get newTestamentTranslation; List<BibleTranslation>? get bibles; List<CommentaryType>? get commentaries;@ChapterPositionFromReference('lastReference') ChapterPosition get lastPosition; String? get currentBookmarkId;@ChapterPositionFromReference('viewHistory') List<ChapterPosition> get viewHistory;@JsonKey(readValue: _readLastHighlightStyle) HighlightStyle get lastHighlightStyle; Map<String, Bookmark> get bookmarkById; List<Annotation> get annotations; List<Notebook> get notebooks; String? get lastNotebookId; MainToolbarConfiguration get mainToolbar; VerseSelectionConfiguration get verseSelection; TextSelectionConfiguration get textSelection; List<String> get searchHistory; InterlinearDirection get interlinearDirection; ThemeMode get theme; ThemeLayoutConfiguration get themeLayout; List<StudyPanel> get studyPanels; int? get studyPanelIndex; double get studyPanelBottomPosition;@nullUnknownEnum Set<Tutorial?> get tutorials; List<OnboardingStep>? get completedOnboardingSteps;@JsonKey(name: 'highlightStyles') List<(HighlightStyle, String label)>? get highlightStyleOverrides; Map<BiblePlanType, BiblePlanProgress> get planProgressByType; Set<BiblePlanType> get completedPlans; AudioBibleConfiguration get audio; Language? get languageOverride;
/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserCopyWith<User> get copyWith => _$UserCopyWithImpl<User>(this as User, _$identity);

  /// Serializes this User to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is User&&(identical(other.translation, translation) || other.translation == translation)&&(identical(other.studyTranslation, studyTranslation) || other.studyTranslation == studyTranslation)&&(identical(other.audioTranslation, audioTranslation) || other.audioTranslation == audioTranslation)&&(identical(other.oldTestamentTranslation, oldTestamentTranslation) || other.oldTestamentTranslation == oldTestamentTranslation)&&(identical(other.newTestamentTranslation, newTestamentTranslation) || other.newTestamentTranslation == newTestamentTranslation)&&const DeepCollectionEquality().equals(other.bibles, bibles)&&const DeepCollectionEquality().equals(other.commentaries, commentaries)&&(identical(other.lastPosition, lastPosition) || other.lastPosition == lastPosition)&&(identical(other.currentBookmarkId, currentBookmarkId) || other.currentBookmarkId == currentBookmarkId)&&const DeepCollectionEquality().equals(other.viewHistory, viewHistory)&&(identical(other.lastHighlightStyle, lastHighlightStyle) || other.lastHighlightStyle == lastHighlightStyle)&&const DeepCollectionEquality().equals(other.bookmarkById, bookmarkById)&&const DeepCollectionEquality().equals(other.annotations, annotations)&&const DeepCollectionEquality().equals(other.notebooks, notebooks)&&(identical(other.lastNotebookId, lastNotebookId) || other.lastNotebookId == lastNotebookId)&&(identical(other.mainToolbar, mainToolbar) || other.mainToolbar == mainToolbar)&&(identical(other.verseSelection, verseSelection) || other.verseSelection == verseSelection)&&(identical(other.textSelection, textSelection) || other.textSelection == textSelection)&&const DeepCollectionEquality().equals(other.searchHistory, searchHistory)&&(identical(other.interlinearDirection, interlinearDirection) || other.interlinearDirection == interlinearDirection)&&(identical(other.theme, theme) || other.theme == theme)&&(identical(other.themeLayout, themeLayout) || other.themeLayout == themeLayout)&&const DeepCollectionEquality().equals(other.studyPanels, studyPanels)&&(identical(other.studyPanelIndex, studyPanelIndex) || other.studyPanelIndex == studyPanelIndex)&&(identical(other.studyPanelBottomPosition, studyPanelBottomPosition) || other.studyPanelBottomPosition == studyPanelBottomPosition)&&const DeepCollectionEquality().equals(other.tutorials, tutorials)&&const DeepCollectionEquality().equals(other.completedOnboardingSteps, completedOnboardingSteps)&&const DeepCollectionEquality().equals(other.highlightStyleOverrides, highlightStyleOverrides)&&const DeepCollectionEquality().equals(other.planProgressByType, planProgressByType)&&const DeepCollectionEquality().equals(other.completedPlans, completedPlans)&&(identical(other.audio, audio) || other.audio == audio)&&(identical(other.languageOverride, languageOverride) || other.languageOverride == languageOverride));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,translation,studyTranslation,audioTranslation,oldTestamentTranslation,newTestamentTranslation,const DeepCollectionEquality().hash(bibles),const DeepCollectionEquality().hash(commentaries),lastPosition,currentBookmarkId,const DeepCollectionEquality().hash(viewHistory),lastHighlightStyle,const DeepCollectionEquality().hash(bookmarkById),const DeepCollectionEquality().hash(annotations),const DeepCollectionEquality().hash(notebooks),lastNotebookId,mainToolbar,verseSelection,textSelection,const DeepCollectionEquality().hash(searchHistory),interlinearDirection,theme,themeLayout,const DeepCollectionEquality().hash(studyPanels),studyPanelIndex,studyPanelBottomPosition,const DeepCollectionEquality().hash(tutorials),const DeepCollectionEquality().hash(completedOnboardingSteps),const DeepCollectionEquality().hash(highlightStyleOverrides),const DeepCollectionEquality().hash(planProgressByType),const DeepCollectionEquality().hash(completedPlans),audio,languageOverride]);

@override
String toString() {
  return 'User(translation: $translation, studyTranslation: $studyTranslation, audioTranslation: $audioTranslation, oldTestamentTranslation: $oldTestamentTranslation, newTestamentTranslation: $newTestamentTranslation, bibles: $bibles, commentaries: $commentaries, lastPosition: $lastPosition, currentBookmarkId: $currentBookmarkId, viewHistory: $viewHistory, lastHighlightStyle: $lastHighlightStyle, bookmarkById: $bookmarkById, annotations: $annotations, notebooks: $notebooks, lastNotebookId: $lastNotebookId, mainToolbar: $mainToolbar, verseSelection: $verseSelection, textSelection: $textSelection, searchHistory: $searchHistory, interlinearDirection: $interlinearDirection, theme: $theme, themeLayout: $themeLayout, studyPanels: $studyPanels, studyPanelIndex: $studyPanelIndex, studyPanelBottomPosition: $studyPanelBottomPosition, tutorials: $tutorials, completedOnboardingSteps: $completedOnboardingSteps, highlightStyleOverrides: $highlightStyleOverrides, planProgressByType: $planProgressByType, completedPlans: $completedPlans, audio: $audio, languageOverride: $languageOverride)';
}


}

/// @nodoc
abstract mixin class $UserCopyWith<$Res>  {
  factory $UserCopyWith(User value, $Res Function(User) _then) = _$UserCopyWithImpl;
@useResult
$Res call({
 BibleTranslation translation, BibleTranslation studyTranslation, BibleTranslation audioTranslation, BibleTranslation oldTestamentTranslation, BibleTranslation newTestamentTranslation, List<BibleTranslation>? bibles, List<CommentaryType>? commentaries,@ChapterPositionFromReference('lastReference') ChapterPosition lastPosition, String? currentBookmarkId,@ChapterPositionFromReference('viewHistory') List<ChapterPosition> viewHistory,@JsonKey(readValue: _readLastHighlightStyle) HighlightStyle lastHighlightStyle, Map<String, Bookmark> bookmarkById, List<Annotation> annotations, List<Notebook> notebooks, String? lastNotebookId, MainToolbarConfiguration mainToolbar, VerseSelectionConfiguration verseSelection, TextSelectionConfiguration textSelection, List<String> searchHistory, InterlinearDirection interlinearDirection, ThemeMode theme, ThemeLayoutConfiguration themeLayout, List<StudyPanel> studyPanels, int? studyPanelIndex, double studyPanelBottomPosition,@nullUnknownEnum Set<Tutorial?> tutorials, List<OnboardingStep>? completedOnboardingSteps,@JsonKey(name: 'highlightStyles') List<(HighlightStyle, String label)>? highlightStyleOverrides, Map<BiblePlanType, BiblePlanProgress> planProgressByType, Set<BiblePlanType> completedPlans, AudioBibleConfiguration audio, Language? languageOverride
});


$ChapterPositionCopyWith<$Res> get lastPosition;$HighlightStyleCopyWith<$Res> get lastHighlightStyle;$MainToolbarConfigurationCopyWith<$Res> get mainToolbar;$VerseSelectionConfigurationCopyWith<$Res> get verseSelection;$TextSelectionConfigurationCopyWith<$Res> get textSelection;$ThemeLayoutConfigurationCopyWith<$Res> get themeLayout;$AudioBibleConfigurationCopyWith<$Res> get audio;

}
/// @nodoc
class _$UserCopyWithImpl<$Res>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._self, this._then);

  final User _self;
  final $Res Function(User) _then;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? translation = null,Object? studyTranslation = null,Object? audioTranslation = null,Object? oldTestamentTranslation = null,Object? newTestamentTranslation = null,Object? bibles = freezed,Object? commentaries = freezed,Object? lastPosition = null,Object? currentBookmarkId = freezed,Object? viewHistory = null,Object? lastHighlightStyle = null,Object? bookmarkById = null,Object? annotations = null,Object? notebooks = null,Object? lastNotebookId = freezed,Object? mainToolbar = null,Object? verseSelection = null,Object? textSelection = null,Object? searchHistory = null,Object? interlinearDirection = null,Object? theme = null,Object? themeLayout = null,Object? studyPanels = null,Object? studyPanelIndex = freezed,Object? studyPanelBottomPosition = null,Object? tutorials = null,Object? completedOnboardingSteps = freezed,Object? highlightStyleOverrides = freezed,Object? planProgressByType = null,Object? completedPlans = null,Object? audio = null,Object? languageOverride = freezed,}) {
  return _then(_self.copyWith(
translation: null == translation ? _self.translation : translation // ignore: cast_nullable_to_non_nullable
as BibleTranslation,studyTranslation: null == studyTranslation ? _self.studyTranslation : studyTranslation // ignore: cast_nullable_to_non_nullable
as BibleTranslation,audioTranslation: null == audioTranslation ? _self.audioTranslation : audioTranslation // ignore: cast_nullable_to_non_nullable
as BibleTranslation,oldTestamentTranslation: null == oldTestamentTranslation ? _self.oldTestamentTranslation : oldTestamentTranslation // ignore: cast_nullable_to_non_nullable
as BibleTranslation,newTestamentTranslation: null == newTestamentTranslation ? _self.newTestamentTranslation : newTestamentTranslation // ignore: cast_nullable_to_non_nullable
as BibleTranslation,bibles: freezed == bibles ? _self.bibles : bibles // ignore: cast_nullable_to_non_nullable
as List<BibleTranslation>?,commentaries: freezed == commentaries ? _self.commentaries : commentaries // ignore: cast_nullable_to_non_nullable
as List<CommentaryType>?,lastPosition: null == lastPosition ? _self.lastPosition : lastPosition // ignore: cast_nullable_to_non_nullable
as ChapterPosition,currentBookmarkId: freezed == currentBookmarkId ? _self.currentBookmarkId : currentBookmarkId // ignore: cast_nullable_to_non_nullable
as String?,viewHistory: null == viewHistory ? _self.viewHistory : viewHistory // ignore: cast_nullable_to_non_nullable
as List<ChapterPosition>,lastHighlightStyle: null == lastHighlightStyle ? _self.lastHighlightStyle : lastHighlightStyle // ignore: cast_nullable_to_non_nullable
as HighlightStyle,bookmarkById: null == bookmarkById ? _self.bookmarkById : bookmarkById // ignore: cast_nullable_to_non_nullable
as Map<String, Bookmark>,annotations: null == annotations ? _self.annotations : annotations // ignore: cast_nullable_to_non_nullable
as List<Annotation>,notebooks: null == notebooks ? _self.notebooks : notebooks // ignore: cast_nullable_to_non_nullable
as List<Notebook>,lastNotebookId: freezed == lastNotebookId ? _self.lastNotebookId : lastNotebookId // ignore: cast_nullable_to_non_nullable
as String?,mainToolbar: null == mainToolbar ? _self.mainToolbar : mainToolbar // ignore: cast_nullable_to_non_nullable
as MainToolbarConfiguration,verseSelection: null == verseSelection ? _self.verseSelection : verseSelection // ignore: cast_nullable_to_non_nullable
as VerseSelectionConfiguration,textSelection: null == textSelection ? _self.textSelection : textSelection // ignore: cast_nullable_to_non_nullable
as TextSelectionConfiguration,searchHistory: null == searchHistory ? _self.searchHistory : searchHistory // ignore: cast_nullable_to_non_nullable
as List<String>,interlinearDirection: null == interlinearDirection ? _self.interlinearDirection : interlinearDirection // ignore: cast_nullable_to_non_nullable
as InterlinearDirection,theme: null == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as ThemeMode,themeLayout: null == themeLayout ? _self.themeLayout : themeLayout // ignore: cast_nullable_to_non_nullable
as ThemeLayoutConfiguration,studyPanels: null == studyPanels ? _self.studyPanels : studyPanels // ignore: cast_nullable_to_non_nullable
as List<StudyPanel>,studyPanelIndex: freezed == studyPanelIndex ? _self.studyPanelIndex : studyPanelIndex // ignore: cast_nullable_to_non_nullable
as int?,studyPanelBottomPosition: null == studyPanelBottomPosition ? _self.studyPanelBottomPosition : studyPanelBottomPosition // ignore: cast_nullable_to_non_nullable
as double,tutorials: null == tutorials ? _self.tutorials : tutorials // ignore: cast_nullable_to_non_nullable
as Set<Tutorial?>,completedOnboardingSteps: freezed == completedOnboardingSteps ? _self.completedOnboardingSteps : completedOnboardingSteps // ignore: cast_nullable_to_non_nullable
as List<OnboardingStep>?,highlightStyleOverrides: freezed == highlightStyleOverrides ? _self.highlightStyleOverrides : highlightStyleOverrides // ignore: cast_nullable_to_non_nullable
as List<(HighlightStyle, String label)>?,planProgressByType: null == planProgressByType ? _self.planProgressByType : planProgressByType // ignore: cast_nullable_to_non_nullable
as Map<BiblePlanType, BiblePlanProgress>,completedPlans: null == completedPlans ? _self.completedPlans : completedPlans // ignore: cast_nullable_to_non_nullable
as Set<BiblePlanType>,audio: null == audio ? _self.audio : audio // ignore: cast_nullable_to_non_nullable
as AudioBibleConfiguration,languageOverride: freezed == languageOverride ? _self.languageOverride : languageOverride // ignore: cast_nullable_to_non_nullable
as Language?,
  ));
}
/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChapterPositionCopyWith<$Res> get lastPosition {
  
  return $ChapterPositionCopyWith<$Res>(_self.lastPosition, (value) {
    return _then(_self.copyWith(lastPosition: value));
  });
}/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HighlightStyleCopyWith<$Res> get lastHighlightStyle {
  
  return $HighlightStyleCopyWith<$Res>(_self.lastHighlightStyle, (value) {
    return _then(_self.copyWith(lastHighlightStyle: value));
  });
}/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MainToolbarConfigurationCopyWith<$Res> get mainToolbar {
  
  return $MainToolbarConfigurationCopyWith<$Res>(_self.mainToolbar, (value) {
    return _then(_self.copyWith(mainToolbar: value));
  });
}/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VerseSelectionConfigurationCopyWith<$Res> get verseSelection {
  
  return $VerseSelectionConfigurationCopyWith<$Res>(_self.verseSelection, (value) {
    return _then(_self.copyWith(verseSelection: value));
  });
}/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TextSelectionConfigurationCopyWith<$Res> get textSelection {
  
  return $TextSelectionConfigurationCopyWith<$Res>(_self.textSelection, (value) {
    return _then(_self.copyWith(textSelection: value));
  });
}/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ThemeLayoutConfigurationCopyWith<$Res> get themeLayout {
  
  return $ThemeLayoutConfigurationCopyWith<$Res>(_self.themeLayout, (value) {
    return _then(_self.copyWith(themeLayout: value));
  });
}/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AudioBibleConfigurationCopyWith<$Res> get audio {
  
  return $AudioBibleConfigurationCopyWith<$Res>(_self.audio, (value) {
    return _then(_self.copyWith(audio: value));
  });
}
}


/// Adds pattern-matching-related methods to [User].
extension UserPatterns on User {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _User value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _User() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _User value)  $default,){
final _that = this;
switch (_that) {
case _User():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _User value)?  $default,){
final _that = this;
switch (_that) {
case _User() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BibleTranslation translation,  BibleTranslation studyTranslation,  BibleTranslation audioTranslation,  BibleTranslation oldTestamentTranslation,  BibleTranslation newTestamentTranslation,  List<BibleTranslation>? bibles,  List<CommentaryType>? commentaries, @ChapterPositionFromReference('lastReference')  ChapterPosition lastPosition,  String? currentBookmarkId, @ChapterPositionFromReference('viewHistory')  List<ChapterPosition> viewHistory, @JsonKey(readValue: _readLastHighlightStyle)  HighlightStyle lastHighlightStyle,  Map<String, Bookmark> bookmarkById,  List<Annotation> annotations,  List<Notebook> notebooks,  String? lastNotebookId,  MainToolbarConfiguration mainToolbar,  VerseSelectionConfiguration verseSelection,  TextSelectionConfiguration textSelection,  List<String> searchHistory,  InterlinearDirection interlinearDirection,  ThemeMode theme,  ThemeLayoutConfiguration themeLayout,  List<StudyPanel> studyPanels,  int? studyPanelIndex,  double studyPanelBottomPosition, @nullUnknownEnum  Set<Tutorial?> tutorials,  List<OnboardingStep>? completedOnboardingSteps, @JsonKey(name: 'highlightStyles')  List<(HighlightStyle, String label)>? highlightStyleOverrides,  Map<BiblePlanType, BiblePlanProgress> planProgressByType,  Set<BiblePlanType> completedPlans,  AudioBibleConfiguration audio,  Language? languageOverride)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _User() when $default != null:
return $default(_that.translation,_that.studyTranslation,_that.audioTranslation,_that.oldTestamentTranslation,_that.newTestamentTranslation,_that.bibles,_that.commentaries,_that.lastPosition,_that.currentBookmarkId,_that.viewHistory,_that.lastHighlightStyle,_that.bookmarkById,_that.annotations,_that.notebooks,_that.lastNotebookId,_that.mainToolbar,_that.verseSelection,_that.textSelection,_that.searchHistory,_that.interlinearDirection,_that.theme,_that.themeLayout,_that.studyPanels,_that.studyPanelIndex,_that.studyPanelBottomPosition,_that.tutorials,_that.completedOnboardingSteps,_that.highlightStyleOverrides,_that.planProgressByType,_that.completedPlans,_that.audio,_that.languageOverride);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BibleTranslation translation,  BibleTranslation studyTranslation,  BibleTranslation audioTranslation,  BibleTranslation oldTestamentTranslation,  BibleTranslation newTestamentTranslation,  List<BibleTranslation>? bibles,  List<CommentaryType>? commentaries, @ChapterPositionFromReference('lastReference')  ChapterPosition lastPosition,  String? currentBookmarkId, @ChapterPositionFromReference('viewHistory')  List<ChapterPosition> viewHistory, @JsonKey(readValue: _readLastHighlightStyle)  HighlightStyle lastHighlightStyle,  Map<String, Bookmark> bookmarkById,  List<Annotation> annotations,  List<Notebook> notebooks,  String? lastNotebookId,  MainToolbarConfiguration mainToolbar,  VerseSelectionConfiguration verseSelection,  TextSelectionConfiguration textSelection,  List<String> searchHistory,  InterlinearDirection interlinearDirection,  ThemeMode theme,  ThemeLayoutConfiguration themeLayout,  List<StudyPanel> studyPanels,  int? studyPanelIndex,  double studyPanelBottomPosition, @nullUnknownEnum  Set<Tutorial?> tutorials,  List<OnboardingStep>? completedOnboardingSteps, @JsonKey(name: 'highlightStyles')  List<(HighlightStyle, String label)>? highlightStyleOverrides,  Map<BiblePlanType, BiblePlanProgress> planProgressByType,  Set<BiblePlanType> completedPlans,  AudioBibleConfiguration audio,  Language? languageOverride)  $default,) {final _that = this;
switch (_that) {
case _User():
return $default(_that.translation,_that.studyTranslation,_that.audioTranslation,_that.oldTestamentTranslation,_that.newTestamentTranslation,_that.bibles,_that.commentaries,_that.lastPosition,_that.currentBookmarkId,_that.viewHistory,_that.lastHighlightStyle,_that.bookmarkById,_that.annotations,_that.notebooks,_that.lastNotebookId,_that.mainToolbar,_that.verseSelection,_that.textSelection,_that.searchHistory,_that.interlinearDirection,_that.theme,_that.themeLayout,_that.studyPanels,_that.studyPanelIndex,_that.studyPanelBottomPosition,_that.tutorials,_that.completedOnboardingSteps,_that.highlightStyleOverrides,_that.planProgressByType,_that.completedPlans,_that.audio,_that.languageOverride);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BibleTranslation translation,  BibleTranslation studyTranslation,  BibleTranslation audioTranslation,  BibleTranslation oldTestamentTranslation,  BibleTranslation newTestamentTranslation,  List<BibleTranslation>? bibles,  List<CommentaryType>? commentaries, @ChapterPositionFromReference('lastReference')  ChapterPosition lastPosition,  String? currentBookmarkId, @ChapterPositionFromReference('viewHistory')  List<ChapterPosition> viewHistory, @JsonKey(readValue: _readLastHighlightStyle)  HighlightStyle lastHighlightStyle,  Map<String, Bookmark> bookmarkById,  List<Annotation> annotations,  List<Notebook> notebooks,  String? lastNotebookId,  MainToolbarConfiguration mainToolbar,  VerseSelectionConfiguration verseSelection,  TextSelectionConfiguration textSelection,  List<String> searchHistory,  InterlinearDirection interlinearDirection,  ThemeMode theme,  ThemeLayoutConfiguration themeLayout,  List<StudyPanel> studyPanels,  int? studyPanelIndex,  double studyPanelBottomPosition, @nullUnknownEnum  Set<Tutorial?> tutorials,  List<OnboardingStep>? completedOnboardingSteps, @JsonKey(name: 'highlightStyles')  List<(HighlightStyle, String label)>? highlightStyleOverrides,  Map<BiblePlanType, BiblePlanProgress> planProgressByType,  Set<BiblePlanType> completedPlans,  AudioBibleConfiguration audio,  Language? languageOverride)?  $default,) {final _that = this;
switch (_that) {
case _User() when $default != null:
return $default(_that.translation,_that.studyTranslation,_that.audioTranslation,_that.oldTestamentTranslation,_that.newTestamentTranslation,_that.bibles,_that.commentaries,_that.lastPosition,_that.currentBookmarkId,_that.viewHistory,_that.lastHighlightStyle,_that.bookmarkById,_that.annotations,_that.notebooks,_that.lastNotebookId,_that.mainToolbar,_that.verseSelection,_that.textSelection,_that.searchHistory,_that.interlinearDirection,_that.theme,_that.themeLayout,_that.studyPanels,_that.studyPanelIndex,_that.studyPanelBottomPosition,_that.tutorials,_that.completedOnboardingSteps,_that.highlightStyleOverrides,_that.planProgressByType,_that.completedPlans,_that.audio,_that.languageOverride);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _User extends User {
  const _User({required this.translation, this.studyTranslation = BibleTranslation.bsb, this.audioTranslation = BibleTranslation.bsb, this.oldTestamentTranslation = BibleTranslation.oshb, this.newTestamentTranslation = BibleTranslation.statresgnt, final  List<BibleTranslation>? bibles, final  List<CommentaryType>? commentaries, @ChapterPositionFromReference('lastReference') this.lastPosition = const ChapterPosition(reference: ChapterReference(chapterNum: 1, book: BookType.genesis)), this.currentBookmarkId, @ChapterPositionFromReference('viewHistory') final  List<ChapterPosition> viewHistory = const [], @JsonKey(readValue: _readLastHighlightStyle) this.lastHighlightStyle = HighlightStyle.fallback, final  Map<String, Bookmark> bookmarkById = const {}, final  List<Annotation> annotations = const [], final  List<Notebook> notebooks = const [], this.lastNotebookId, this.mainToolbar = const MainToolbarConfiguration(), this.verseSelection = const VerseSelectionConfiguration(), this.textSelection = const TextSelectionConfiguration(), final  List<String> searchHistory = const [], this.interlinearDirection = InterlinearDirection.reverse, this.theme = ThemeMode.system, this.themeLayout = const ThemeLayoutConfiguration(), final  List<StudyPanel> studyPanels = const [], this.studyPanelIndex, this.studyPanelBottomPosition = 0.5, @nullUnknownEnum final  Set<Tutorial?> tutorials = const {}, final  List<OnboardingStep>? completedOnboardingSteps, @JsonKey(name: 'highlightStyles') final  List<(HighlightStyle, String label)>? highlightStyleOverrides, final  Map<BiblePlanType, BiblePlanProgress> planProgressByType = const {}, final  Set<BiblePlanType> completedPlans = const {}, this.audio = const AudioBibleConfiguration(), this.languageOverride}): _bibles = bibles,_commentaries = commentaries,_viewHistory = viewHistory,_bookmarkById = bookmarkById,_annotations = annotations,_notebooks = notebooks,_searchHistory = searchHistory,_studyPanels = studyPanels,_tutorials = tutorials,_completedOnboardingSteps = completedOnboardingSteps,_highlightStyleOverrides = highlightStyleOverrides,_planProgressByType = planProgressByType,_completedPlans = completedPlans,super._();
  factory _User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

@override final  BibleTranslation translation;
@override@JsonKey() final  BibleTranslation studyTranslation;
@override@JsonKey() final  BibleTranslation audioTranslation;
@override@JsonKey() final  BibleTranslation oldTestamentTranslation;
@override@JsonKey() final  BibleTranslation newTestamentTranslation;
 final  List<BibleTranslation>? _bibles;
@override List<BibleTranslation>? get bibles {
  final value = _bibles;
  if (value == null) return null;
  if (_bibles is EqualUnmodifiableListView) return _bibles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<CommentaryType>? _commentaries;
@override List<CommentaryType>? get commentaries {
  final value = _commentaries;
  if (value == null) return null;
  if (_commentaries is EqualUnmodifiableListView) return _commentaries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@ChapterPositionFromReference('lastReference') final  ChapterPosition lastPosition;
@override final  String? currentBookmarkId;
 final  List<ChapterPosition> _viewHistory;
@override@ChapterPositionFromReference('viewHistory') List<ChapterPosition> get viewHistory {
  if (_viewHistory is EqualUnmodifiableListView) return _viewHistory;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_viewHistory);
}

@override@JsonKey(readValue: _readLastHighlightStyle) final  HighlightStyle lastHighlightStyle;
 final  Map<String, Bookmark> _bookmarkById;
@override@JsonKey() Map<String, Bookmark> get bookmarkById {
  if (_bookmarkById is EqualUnmodifiableMapView) return _bookmarkById;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_bookmarkById);
}

 final  List<Annotation> _annotations;
@override@JsonKey() List<Annotation> get annotations {
  if (_annotations is EqualUnmodifiableListView) return _annotations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_annotations);
}

 final  List<Notebook> _notebooks;
@override@JsonKey() List<Notebook> get notebooks {
  if (_notebooks is EqualUnmodifiableListView) return _notebooks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_notebooks);
}

@override final  String? lastNotebookId;
@override@JsonKey() final  MainToolbarConfiguration mainToolbar;
@override@JsonKey() final  VerseSelectionConfiguration verseSelection;
@override@JsonKey() final  TextSelectionConfiguration textSelection;
 final  List<String> _searchHistory;
@override@JsonKey() List<String> get searchHistory {
  if (_searchHistory is EqualUnmodifiableListView) return _searchHistory;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_searchHistory);
}

@override@JsonKey() final  InterlinearDirection interlinearDirection;
@override@JsonKey() final  ThemeMode theme;
@override@JsonKey() final  ThemeLayoutConfiguration themeLayout;
 final  List<StudyPanel> _studyPanels;
@override@JsonKey() List<StudyPanel> get studyPanels {
  if (_studyPanels is EqualUnmodifiableListView) return _studyPanels;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_studyPanels);
}

@override final  int? studyPanelIndex;
@override@JsonKey() final  double studyPanelBottomPosition;
 final  Set<Tutorial?> _tutorials;
@override@nullUnknownEnum Set<Tutorial?> get tutorials {
  if (_tutorials is EqualUnmodifiableSetView) return _tutorials;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_tutorials);
}

 final  List<OnboardingStep>? _completedOnboardingSteps;
@override List<OnboardingStep>? get completedOnboardingSteps {
  final value = _completedOnboardingSteps;
  if (value == null) return null;
  if (_completedOnboardingSteps is EqualUnmodifiableListView) return _completedOnboardingSteps;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<(HighlightStyle, String label)>? _highlightStyleOverrides;
@override@JsonKey(name: 'highlightStyles') List<(HighlightStyle, String label)>? get highlightStyleOverrides {
  final value = _highlightStyleOverrides;
  if (value == null) return null;
  if (_highlightStyleOverrides is EqualUnmodifiableListView) return _highlightStyleOverrides;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  Map<BiblePlanType, BiblePlanProgress> _planProgressByType;
@override@JsonKey() Map<BiblePlanType, BiblePlanProgress> get planProgressByType {
  if (_planProgressByType is EqualUnmodifiableMapView) return _planProgressByType;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_planProgressByType);
}

 final  Set<BiblePlanType> _completedPlans;
@override@JsonKey() Set<BiblePlanType> get completedPlans {
  if (_completedPlans is EqualUnmodifiableSetView) return _completedPlans;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_completedPlans);
}

@override@JsonKey() final  AudioBibleConfiguration audio;
@override final  Language? languageOverride;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserCopyWith<_User> get copyWith => __$UserCopyWithImpl<_User>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _User&&(identical(other.translation, translation) || other.translation == translation)&&(identical(other.studyTranslation, studyTranslation) || other.studyTranslation == studyTranslation)&&(identical(other.audioTranslation, audioTranslation) || other.audioTranslation == audioTranslation)&&(identical(other.oldTestamentTranslation, oldTestamentTranslation) || other.oldTestamentTranslation == oldTestamentTranslation)&&(identical(other.newTestamentTranslation, newTestamentTranslation) || other.newTestamentTranslation == newTestamentTranslation)&&const DeepCollectionEquality().equals(other._bibles, _bibles)&&const DeepCollectionEquality().equals(other._commentaries, _commentaries)&&(identical(other.lastPosition, lastPosition) || other.lastPosition == lastPosition)&&(identical(other.currentBookmarkId, currentBookmarkId) || other.currentBookmarkId == currentBookmarkId)&&const DeepCollectionEquality().equals(other._viewHistory, _viewHistory)&&(identical(other.lastHighlightStyle, lastHighlightStyle) || other.lastHighlightStyle == lastHighlightStyle)&&const DeepCollectionEquality().equals(other._bookmarkById, _bookmarkById)&&const DeepCollectionEquality().equals(other._annotations, _annotations)&&const DeepCollectionEquality().equals(other._notebooks, _notebooks)&&(identical(other.lastNotebookId, lastNotebookId) || other.lastNotebookId == lastNotebookId)&&(identical(other.mainToolbar, mainToolbar) || other.mainToolbar == mainToolbar)&&(identical(other.verseSelection, verseSelection) || other.verseSelection == verseSelection)&&(identical(other.textSelection, textSelection) || other.textSelection == textSelection)&&const DeepCollectionEquality().equals(other._searchHistory, _searchHistory)&&(identical(other.interlinearDirection, interlinearDirection) || other.interlinearDirection == interlinearDirection)&&(identical(other.theme, theme) || other.theme == theme)&&(identical(other.themeLayout, themeLayout) || other.themeLayout == themeLayout)&&const DeepCollectionEquality().equals(other._studyPanels, _studyPanels)&&(identical(other.studyPanelIndex, studyPanelIndex) || other.studyPanelIndex == studyPanelIndex)&&(identical(other.studyPanelBottomPosition, studyPanelBottomPosition) || other.studyPanelBottomPosition == studyPanelBottomPosition)&&const DeepCollectionEquality().equals(other._tutorials, _tutorials)&&const DeepCollectionEquality().equals(other._completedOnboardingSteps, _completedOnboardingSteps)&&const DeepCollectionEquality().equals(other._highlightStyleOverrides, _highlightStyleOverrides)&&const DeepCollectionEquality().equals(other._planProgressByType, _planProgressByType)&&const DeepCollectionEquality().equals(other._completedPlans, _completedPlans)&&(identical(other.audio, audio) || other.audio == audio)&&(identical(other.languageOverride, languageOverride) || other.languageOverride == languageOverride));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,translation,studyTranslation,audioTranslation,oldTestamentTranslation,newTestamentTranslation,const DeepCollectionEquality().hash(_bibles),const DeepCollectionEquality().hash(_commentaries),lastPosition,currentBookmarkId,const DeepCollectionEquality().hash(_viewHistory),lastHighlightStyle,const DeepCollectionEquality().hash(_bookmarkById),const DeepCollectionEquality().hash(_annotations),const DeepCollectionEquality().hash(_notebooks),lastNotebookId,mainToolbar,verseSelection,textSelection,const DeepCollectionEquality().hash(_searchHistory),interlinearDirection,theme,themeLayout,const DeepCollectionEquality().hash(_studyPanels),studyPanelIndex,studyPanelBottomPosition,const DeepCollectionEquality().hash(_tutorials),const DeepCollectionEquality().hash(_completedOnboardingSteps),const DeepCollectionEquality().hash(_highlightStyleOverrides),const DeepCollectionEquality().hash(_planProgressByType),const DeepCollectionEquality().hash(_completedPlans),audio,languageOverride]);

@override
String toString() {
  return 'User(translation: $translation, studyTranslation: $studyTranslation, audioTranslation: $audioTranslation, oldTestamentTranslation: $oldTestamentTranslation, newTestamentTranslation: $newTestamentTranslation, bibles: $bibles, commentaries: $commentaries, lastPosition: $lastPosition, currentBookmarkId: $currentBookmarkId, viewHistory: $viewHistory, lastHighlightStyle: $lastHighlightStyle, bookmarkById: $bookmarkById, annotations: $annotations, notebooks: $notebooks, lastNotebookId: $lastNotebookId, mainToolbar: $mainToolbar, verseSelection: $verseSelection, textSelection: $textSelection, searchHistory: $searchHistory, interlinearDirection: $interlinearDirection, theme: $theme, themeLayout: $themeLayout, studyPanels: $studyPanels, studyPanelIndex: $studyPanelIndex, studyPanelBottomPosition: $studyPanelBottomPosition, tutorials: $tutorials, completedOnboardingSteps: $completedOnboardingSteps, highlightStyleOverrides: $highlightStyleOverrides, planProgressByType: $planProgressByType, completedPlans: $completedPlans, audio: $audio, languageOverride: $languageOverride)';
}


}

/// @nodoc
abstract mixin class _$UserCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$UserCopyWith(_User value, $Res Function(_User) _then) = __$UserCopyWithImpl;
@override @useResult
$Res call({
 BibleTranslation translation, BibleTranslation studyTranslation, BibleTranslation audioTranslation, BibleTranslation oldTestamentTranslation, BibleTranslation newTestamentTranslation, List<BibleTranslation>? bibles, List<CommentaryType>? commentaries,@ChapterPositionFromReference('lastReference') ChapterPosition lastPosition, String? currentBookmarkId,@ChapterPositionFromReference('viewHistory') List<ChapterPosition> viewHistory,@JsonKey(readValue: _readLastHighlightStyle) HighlightStyle lastHighlightStyle, Map<String, Bookmark> bookmarkById, List<Annotation> annotations, List<Notebook> notebooks, String? lastNotebookId, MainToolbarConfiguration mainToolbar, VerseSelectionConfiguration verseSelection, TextSelectionConfiguration textSelection, List<String> searchHistory, InterlinearDirection interlinearDirection, ThemeMode theme, ThemeLayoutConfiguration themeLayout, List<StudyPanel> studyPanels, int? studyPanelIndex, double studyPanelBottomPosition,@nullUnknownEnum Set<Tutorial?> tutorials, List<OnboardingStep>? completedOnboardingSteps,@JsonKey(name: 'highlightStyles') List<(HighlightStyle, String label)>? highlightStyleOverrides, Map<BiblePlanType, BiblePlanProgress> planProgressByType, Set<BiblePlanType> completedPlans, AudioBibleConfiguration audio, Language? languageOverride
});


@override $ChapterPositionCopyWith<$Res> get lastPosition;@override $HighlightStyleCopyWith<$Res> get lastHighlightStyle;@override $MainToolbarConfigurationCopyWith<$Res> get mainToolbar;@override $VerseSelectionConfigurationCopyWith<$Res> get verseSelection;@override $TextSelectionConfigurationCopyWith<$Res> get textSelection;@override $ThemeLayoutConfigurationCopyWith<$Res> get themeLayout;@override $AudioBibleConfigurationCopyWith<$Res> get audio;

}
/// @nodoc
class __$UserCopyWithImpl<$Res>
    implements _$UserCopyWith<$Res> {
  __$UserCopyWithImpl(this._self, this._then);

  final _User _self;
  final $Res Function(_User) _then;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? translation = null,Object? studyTranslation = null,Object? audioTranslation = null,Object? oldTestamentTranslation = null,Object? newTestamentTranslation = null,Object? bibles = freezed,Object? commentaries = freezed,Object? lastPosition = null,Object? currentBookmarkId = freezed,Object? viewHistory = null,Object? lastHighlightStyle = null,Object? bookmarkById = null,Object? annotations = null,Object? notebooks = null,Object? lastNotebookId = freezed,Object? mainToolbar = null,Object? verseSelection = null,Object? textSelection = null,Object? searchHistory = null,Object? interlinearDirection = null,Object? theme = null,Object? themeLayout = null,Object? studyPanels = null,Object? studyPanelIndex = freezed,Object? studyPanelBottomPosition = null,Object? tutorials = null,Object? completedOnboardingSteps = freezed,Object? highlightStyleOverrides = freezed,Object? planProgressByType = null,Object? completedPlans = null,Object? audio = null,Object? languageOverride = freezed,}) {
  return _then(_User(
translation: null == translation ? _self.translation : translation // ignore: cast_nullable_to_non_nullable
as BibleTranslation,studyTranslation: null == studyTranslation ? _self.studyTranslation : studyTranslation // ignore: cast_nullable_to_non_nullable
as BibleTranslation,audioTranslation: null == audioTranslation ? _self.audioTranslation : audioTranslation // ignore: cast_nullable_to_non_nullable
as BibleTranslation,oldTestamentTranslation: null == oldTestamentTranslation ? _self.oldTestamentTranslation : oldTestamentTranslation // ignore: cast_nullable_to_non_nullable
as BibleTranslation,newTestamentTranslation: null == newTestamentTranslation ? _self.newTestamentTranslation : newTestamentTranslation // ignore: cast_nullable_to_non_nullable
as BibleTranslation,bibles: freezed == bibles ? _self._bibles : bibles // ignore: cast_nullable_to_non_nullable
as List<BibleTranslation>?,commentaries: freezed == commentaries ? _self._commentaries : commentaries // ignore: cast_nullable_to_non_nullable
as List<CommentaryType>?,lastPosition: null == lastPosition ? _self.lastPosition : lastPosition // ignore: cast_nullable_to_non_nullable
as ChapterPosition,currentBookmarkId: freezed == currentBookmarkId ? _self.currentBookmarkId : currentBookmarkId // ignore: cast_nullable_to_non_nullable
as String?,viewHistory: null == viewHistory ? _self._viewHistory : viewHistory // ignore: cast_nullable_to_non_nullable
as List<ChapterPosition>,lastHighlightStyle: null == lastHighlightStyle ? _self.lastHighlightStyle : lastHighlightStyle // ignore: cast_nullable_to_non_nullable
as HighlightStyle,bookmarkById: null == bookmarkById ? _self._bookmarkById : bookmarkById // ignore: cast_nullable_to_non_nullable
as Map<String, Bookmark>,annotations: null == annotations ? _self._annotations : annotations // ignore: cast_nullable_to_non_nullable
as List<Annotation>,notebooks: null == notebooks ? _self._notebooks : notebooks // ignore: cast_nullable_to_non_nullable
as List<Notebook>,lastNotebookId: freezed == lastNotebookId ? _self.lastNotebookId : lastNotebookId // ignore: cast_nullable_to_non_nullable
as String?,mainToolbar: null == mainToolbar ? _self.mainToolbar : mainToolbar // ignore: cast_nullable_to_non_nullable
as MainToolbarConfiguration,verseSelection: null == verseSelection ? _self.verseSelection : verseSelection // ignore: cast_nullable_to_non_nullable
as VerseSelectionConfiguration,textSelection: null == textSelection ? _self.textSelection : textSelection // ignore: cast_nullable_to_non_nullable
as TextSelectionConfiguration,searchHistory: null == searchHistory ? _self._searchHistory : searchHistory // ignore: cast_nullable_to_non_nullable
as List<String>,interlinearDirection: null == interlinearDirection ? _self.interlinearDirection : interlinearDirection // ignore: cast_nullable_to_non_nullable
as InterlinearDirection,theme: null == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as ThemeMode,themeLayout: null == themeLayout ? _self.themeLayout : themeLayout // ignore: cast_nullable_to_non_nullable
as ThemeLayoutConfiguration,studyPanels: null == studyPanels ? _self._studyPanels : studyPanels // ignore: cast_nullable_to_non_nullable
as List<StudyPanel>,studyPanelIndex: freezed == studyPanelIndex ? _self.studyPanelIndex : studyPanelIndex // ignore: cast_nullable_to_non_nullable
as int?,studyPanelBottomPosition: null == studyPanelBottomPosition ? _self.studyPanelBottomPosition : studyPanelBottomPosition // ignore: cast_nullable_to_non_nullable
as double,tutorials: null == tutorials ? _self._tutorials : tutorials // ignore: cast_nullable_to_non_nullable
as Set<Tutorial?>,completedOnboardingSteps: freezed == completedOnboardingSteps ? _self._completedOnboardingSteps : completedOnboardingSteps // ignore: cast_nullable_to_non_nullable
as List<OnboardingStep>?,highlightStyleOverrides: freezed == highlightStyleOverrides ? _self._highlightStyleOverrides : highlightStyleOverrides // ignore: cast_nullable_to_non_nullable
as List<(HighlightStyle, String label)>?,planProgressByType: null == planProgressByType ? _self._planProgressByType : planProgressByType // ignore: cast_nullable_to_non_nullable
as Map<BiblePlanType, BiblePlanProgress>,completedPlans: null == completedPlans ? _self._completedPlans : completedPlans // ignore: cast_nullable_to_non_nullable
as Set<BiblePlanType>,audio: null == audio ? _self.audio : audio // ignore: cast_nullable_to_non_nullable
as AudioBibleConfiguration,languageOverride: freezed == languageOverride ? _self.languageOverride : languageOverride // ignore: cast_nullable_to_non_nullable
as Language?,
  ));
}

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChapterPositionCopyWith<$Res> get lastPosition {
  
  return $ChapterPositionCopyWith<$Res>(_self.lastPosition, (value) {
    return _then(_self.copyWith(lastPosition: value));
  });
}/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HighlightStyleCopyWith<$Res> get lastHighlightStyle {
  
  return $HighlightStyleCopyWith<$Res>(_self.lastHighlightStyle, (value) {
    return _then(_self.copyWith(lastHighlightStyle: value));
  });
}/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MainToolbarConfigurationCopyWith<$Res> get mainToolbar {
  
  return $MainToolbarConfigurationCopyWith<$Res>(_self.mainToolbar, (value) {
    return _then(_self.copyWith(mainToolbar: value));
  });
}/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VerseSelectionConfigurationCopyWith<$Res> get verseSelection {
  
  return $VerseSelectionConfigurationCopyWith<$Res>(_self.verseSelection, (value) {
    return _then(_self.copyWith(verseSelection: value));
  });
}/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TextSelectionConfigurationCopyWith<$Res> get textSelection {
  
  return $TextSelectionConfigurationCopyWith<$Res>(_self.textSelection, (value) {
    return _then(_self.copyWith(textSelection: value));
  });
}/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ThemeLayoutConfigurationCopyWith<$Res> get themeLayout {
  
  return $ThemeLayoutConfigurationCopyWith<$Res>(_self.themeLayout, (value) {
    return _then(_self.copyWith(themeLayout: value));
  });
}/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AudioBibleConfigurationCopyWith<$Res> get audio {
  
  return $AudioBibleConfigurationCopyWith<$Res>(_self.audio, (value) {
    return _then(_self.copyWith(audio: value));
  });
}
}

// dart format on
