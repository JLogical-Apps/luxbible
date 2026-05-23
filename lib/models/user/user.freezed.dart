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

 BibleTranslation get translation; ChapterReference get lastReference; String? get currentBookmarkId; List<ChapterReference> get viewHistory; ColorEnum get highlightColor; Map<String, Bookmark> get bookmarkById; List<Annotation> get annotations; MainToolbarConfiguration get mainToolbar; VerseSelectionConfiguration get verseSelection; TextSelectionConfiguration get textSelection; List<String> get searchHistory; InterlinearDirection get interlinearDirection; ThemeMode get theme;
/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserCopyWith<User> get copyWith => _$UserCopyWithImpl<User>(this as User, _$identity);

  /// Serializes this User to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is User&&(identical(other.translation, translation) || other.translation == translation)&&(identical(other.lastReference, lastReference) || other.lastReference == lastReference)&&(identical(other.currentBookmarkId, currentBookmarkId) || other.currentBookmarkId == currentBookmarkId)&&const DeepCollectionEquality().equals(other.viewHistory, viewHistory)&&(identical(other.highlightColor, highlightColor) || other.highlightColor == highlightColor)&&const DeepCollectionEquality().equals(other.bookmarkById, bookmarkById)&&const DeepCollectionEquality().equals(other.annotations, annotations)&&(identical(other.mainToolbar, mainToolbar) || other.mainToolbar == mainToolbar)&&(identical(other.verseSelection, verseSelection) || other.verseSelection == verseSelection)&&(identical(other.textSelection, textSelection) || other.textSelection == textSelection)&&const DeepCollectionEquality().equals(other.searchHistory, searchHistory)&&(identical(other.interlinearDirection, interlinearDirection) || other.interlinearDirection == interlinearDirection)&&(identical(other.theme, theme) || other.theme == theme));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,translation,lastReference,currentBookmarkId,const DeepCollectionEquality().hash(viewHistory),highlightColor,const DeepCollectionEquality().hash(bookmarkById),const DeepCollectionEquality().hash(annotations),mainToolbar,verseSelection,textSelection,const DeepCollectionEquality().hash(searchHistory),interlinearDirection,theme);

@override
String toString() {
  return 'User(translation: $translation, lastReference: $lastReference, currentBookmarkId: $currentBookmarkId, viewHistory: $viewHistory, highlightColor: $highlightColor, bookmarkById: $bookmarkById, annotations: $annotations, mainToolbar: $mainToolbar, verseSelection: $verseSelection, textSelection: $textSelection, searchHistory: $searchHistory, interlinearDirection: $interlinearDirection, theme: $theme)';
}


}

/// @nodoc
abstract mixin class $UserCopyWith<$Res>  {
  factory $UserCopyWith(User value, $Res Function(User) _then) = _$UserCopyWithImpl;
@useResult
$Res call({
 BibleTranslation translation, ChapterReference lastReference, String? currentBookmarkId, List<ChapterReference> viewHistory, ColorEnum highlightColor, Map<String, Bookmark> bookmarkById, List<Annotation> annotations, MainToolbarConfiguration mainToolbar, VerseSelectionConfiguration verseSelection, TextSelectionConfiguration textSelection, List<String> searchHistory, InterlinearDirection interlinearDirection, ThemeMode theme
});


$MainToolbarConfigurationCopyWith<$Res> get mainToolbar;$VerseSelectionConfigurationCopyWith<$Res> get verseSelection;$TextSelectionConfigurationCopyWith<$Res> get textSelection;

}
/// @nodoc
class _$UserCopyWithImpl<$Res>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._self, this._then);

  final User _self;
  final $Res Function(User) _then;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? translation = null,Object? lastReference = null,Object? currentBookmarkId = freezed,Object? viewHistory = null,Object? highlightColor = null,Object? bookmarkById = null,Object? annotations = null,Object? mainToolbar = null,Object? verseSelection = null,Object? textSelection = null,Object? searchHistory = null,Object? interlinearDirection = null,Object? theme = null,}) {
  return _then(_self.copyWith(
translation: null == translation ? _self.translation : translation // ignore: cast_nullable_to_non_nullable
as BibleTranslation,lastReference: null == lastReference ? _self.lastReference : lastReference // ignore: cast_nullable_to_non_nullable
as ChapterReference,currentBookmarkId: freezed == currentBookmarkId ? _self.currentBookmarkId : currentBookmarkId // ignore: cast_nullable_to_non_nullable
as String?,viewHistory: null == viewHistory ? _self.viewHistory : viewHistory // ignore: cast_nullable_to_non_nullable
as List<ChapterReference>,highlightColor: null == highlightColor ? _self.highlightColor : highlightColor // ignore: cast_nullable_to_non_nullable
as ColorEnum,bookmarkById: null == bookmarkById ? _self.bookmarkById : bookmarkById // ignore: cast_nullable_to_non_nullable
as Map<String, Bookmark>,annotations: null == annotations ? _self.annotations : annotations // ignore: cast_nullable_to_non_nullable
as List<Annotation>,mainToolbar: null == mainToolbar ? _self.mainToolbar : mainToolbar // ignore: cast_nullable_to_non_nullable
as MainToolbarConfiguration,verseSelection: null == verseSelection ? _self.verseSelection : verseSelection // ignore: cast_nullable_to_non_nullable
as VerseSelectionConfiguration,textSelection: null == textSelection ? _self.textSelection : textSelection // ignore: cast_nullable_to_non_nullable
as TextSelectionConfiguration,searchHistory: null == searchHistory ? _self.searchHistory : searchHistory // ignore: cast_nullable_to_non_nullable
as List<String>,interlinearDirection: null == interlinearDirection ? _self.interlinearDirection : interlinearDirection // ignore: cast_nullable_to_non_nullable
as InterlinearDirection,theme: null == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as ThemeMode,
  ));
}
/// Create a copy of User
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BibleTranslation translation,  ChapterReference lastReference,  String? currentBookmarkId,  List<ChapterReference> viewHistory,  ColorEnum highlightColor,  Map<String, Bookmark> bookmarkById,  List<Annotation> annotations,  MainToolbarConfiguration mainToolbar,  VerseSelectionConfiguration verseSelection,  TextSelectionConfiguration textSelection,  List<String> searchHistory,  InterlinearDirection interlinearDirection,  ThemeMode theme)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _User() when $default != null:
return $default(_that.translation,_that.lastReference,_that.currentBookmarkId,_that.viewHistory,_that.highlightColor,_that.bookmarkById,_that.annotations,_that.mainToolbar,_that.verseSelection,_that.textSelection,_that.searchHistory,_that.interlinearDirection,_that.theme);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BibleTranslation translation,  ChapterReference lastReference,  String? currentBookmarkId,  List<ChapterReference> viewHistory,  ColorEnum highlightColor,  Map<String, Bookmark> bookmarkById,  List<Annotation> annotations,  MainToolbarConfiguration mainToolbar,  VerseSelectionConfiguration verseSelection,  TextSelectionConfiguration textSelection,  List<String> searchHistory,  InterlinearDirection interlinearDirection,  ThemeMode theme)  $default,) {final _that = this;
switch (_that) {
case _User():
return $default(_that.translation,_that.lastReference,_that.currentBookmarkId,_that.viewHistory,_that.highlightColor,_that.bookmarkById,_that.annotations,_that.mainToolbar,_that.verseSelection,_that.textSelection,_that.searchHistory,_that.interlinearDirection,_that.theme);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BibleTranslation translation,  ChapterReference lastReference,  String? currentBookmarkId,  List<ChapterReference> viewHistory,  ColorEnum highlightColor,  Map<String, Bookmark> bookmarkById,  List<Annotation> annotations,  MainToolbarConfiguration mainToolbar,  VerseSelectionConfiguration verseSelection,  TextSelectionConfiguration textSelection,  List<String> searchHistory,  InterlinearDirection interlinearDirection,  ThemeMode theme)?  $default,) {final _that = this;
switch (_that) {
case _User() when $default != null:
return $default(_that.translation,_that.lastReference,_that.currentBookmarkId,_that.viewHistory,_that.highlightColor,_that.bookmarkById,_that.annotations,_that.mainToolbar,_that.verseSelection,_that.textSelection,_that.searchHistory,_that.interlinearDirection,_that.theme);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _User extends User {
  const _User({this.translation = BibleTranslation.bsb, this.lastReference = const ChapterReference(chapterNum: 1, book: BookType.genesis), this.currentBookmarkId, final  List<ChapterReference> viewHistory = const [], this.highlightColor = ColorEnum.yellow, final  Map<String, Bookmark> bookmarkById = const {}, final  List<Annotation> annotations = const [], this.mainToolbar = const MainToolbarConfiguration(), this.verseSelection = const VerseSelectionConfiguration(), this.textSelection = const TextSelectionConfiguration(), final  List<String> searchHistory = const [], this.interlinearDirection = InterlinearDirection.reverse, this.theme = ThemeMode.system}): _viewHistory = viewHistory,_bookmarkById = bookmarkById,_annotations = annotations,_searchHistory = searchHistory,super._();
  factory _User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

@override@JsonKey() final  BibleTranslation translation;
@override@JsonKey() final  ChapterReference lastReference;
@override final  String? currentBookmarkId;
 final  List<ChapterReference> _viewHistory;
@override@JsonKey() List<ChapterReference> get viewHistory {
  if (_viewHistory is EqualUnmodifiableListView) return _viewHistory;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_viewHistory);
}

@override@JsonKey() final  ColorEnum highlightColor;
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _User&&(identical(other.translation, translation) || other.translation == translation)&&(identical(other.lastReference, lastReference) || other.lastReference == lastReference)&&(identical(other.currentBookmarkId, currentBookmarkId) || other.currentBookmarkId == currentBookmarkId)&&const DeepCollectionEquality().equals(other._viewHistory, _viewHistory)&&(identical(other.highlightColor, highlightColor) || other.highlightColor == highlightColor)&&const DeepCollectionEquality().equals(other._bookmarkById, _bookmarkById)&&const DeepCollectionEquality().equals(other._annotations, _annotations)&&(identical(other.mainToolbar, mainToolbar) || other.mainToolbar == mainToolbar)&&(identical(other.verseSelection, verseSelection) || other.verseSelection == verseSelection)&&(identical(other.textSelection, textSelection) || other.textSelection == textSelection)&&const DeepCollectionEquality().equals(other._searchHistory, _searchHistory)&&(identical(other.interlinearDirection, interlinearDirection) || other.interlinearDirection == interlinearDirection)&&(identical(other.theme, theme) || other.theme == theme));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,translation,lastReference,currentBookmarkId,const DeepCollectionEquality().hash(_viewHistory),highlightColor,const DeepCollectionEquality().hash(_bookmarkById),const DeepCollectionEquality().hash(_annotations),mainToolbar,verseSelection,textSelection,const DeepCollectionEquality().hash(_searchHistory),interlinearDirection,theme);

@override
String toString() {
  return 'User(translation: $translation, lastReference: $lastReference, currentBookmarkId: $currentBookmarkId, viewHistory: $viewHistory, highlightColor: $highlightColor, bookmarkById: $bookmarkById, annotations: $annotations, mainToolbar: $mainToolbar, verseSelection: $verseSelection, textSelection: $textSelection, searchHistory: $searchHistory, interlinearDirection: $interlinearDirection, theme: $theme)';
}


}

/// @nodoc
abstract mixin class _$UserCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$UserCopyWith(_User value, $Res Function(_User) _then) = __$UserCopyWithImpl;
@override @useResult
$Res call({
 BibleTranslation translation, ChapterReference lastReference, String? currentBookmarkId, List<ChapterReference> viewHistory, ColorEnum highlightColor, Map<String, Bookmark> bookmarkById, List<Annotation> annotations, MainToolbarConfiguration mainToolbar, VerseSelectionConfiguration verseSelection, TextSelectionConfiguration textSelection, List<String> searchHistory, InterlinearDirection interlinearDirection, ThemeMode theme
});


@override $MainToolbarConfigurationCopyWith<$Res> get mainToolbar;@override $VerseSelectionConfigurationCopyWith<$Res> get verseSelection;@override $TextSelectionConfigurationCopyWith<$Res> get textSelection;

}
/// @nodoc
class __$UserCopyWithImpl<$Res>
    implements _$UserCopyWith<$Res> {
  __$UserCopyWithImpl(this._self, this._then);

  final _User _self;
  final $Res Function(_User) _then;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? translation = null,Object? lastReference = null,Object? currentBookmarkId = freezed,Object? viewHistory = null,Object? highlightColor = null,Object? bookmarkById = null,Object? annotations = null,Object? mainToolbar = null,Object? verseSelection = null,Object? textSelection = null,Object? searchHistory = null,Object? interlinearDirection = null,Object? theme = null,}) {
  return _then(_User(
translation: null == translation ? _self.translation : translation // ignore: cast_nullable_to_non_nullable
as BibleTranslation,lastReference: null == lastReference ? _self.lastReference : lastReference // ignore: cast_nullable_to_non_nullable
as ChapterReference,currentBookmarkId: freezed == currentBookmarkId ? _self.currentBookmarkId : currentBookmarkId // ignore: cast_nullable_to_non_nullable
as String?,viewHistory: null == viewHistory ? _self._viewHistory : viewHistory // ignore: cast_nullable_to_non_nullable
as List<ChapterReference>,highlightColor: null == highlightColor ? _self.highlightColor : highlightColor // ignore: cast_nullable_to_non_nullable
as ColorEnum,bookmarkById: null == bookmarkById ? _self._bookmarkById : bookmarkById // ignore: cast_nullable_to_non_nullable
as Map<String, Bookmark>,annotations: null == annotations ? _self._annotations : annotations // ignore: cast_nullable_to_non_nullable
as List<Annotation>,mainToolbar: null == mainToolbar ? _self.mainToolbar : mainToolbar // ignore: cast_nullable_to_non_nullable
as MainToolbarConfiguration,verseSelection: null == verseSelection ? _self.verseSelection : verseSelection // ignore: cast_nullable_to_non_nullable
as VerseSelectionConfiguration,textSelection: null == textSelection ? _self.textSelection : textSelection // ignore: cast_nullable_to_non_nullable
as TextSelectionConfiguration,searchHistory: null == searchHistory ? _self._searchHistory : searchHistory // ignore: cast_nullable_to_non_nullable
as List<String>,interlinearDirection: null == interlinearDirection ? _self.interlinearDirection : interlinearDirection // ignore: cast_nullable_to_non_nullable
as InterlinearDirection,theme: null == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as ThemeMode,
  ));
}

/// Create a copy of User
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
}
}

// dart format on
