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

 BibleTranslation get translation; ChapterReference get lastReference; String? get currentSessionId; Map<String, ChapterReference> get sessionById; ColorEnum get highlightColor; List<Bookmark> get bookmarks; List<Annotation> get annotations; ToolbarConfiguration get toolbar; PassageConfiguration get passage; SelectionConfiguration get selection; List<String> get searchHistory;
/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserCopyWith<User> get copyWith => _$UserCopyWithImpl<User>(this as User, _$identity);

  /// Serializes this User to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is User&&(identical(other.translation, translation) || other.translation == translation)&&(identical(other.lastReference, lastReference) || other.lastReference == lastReference)&&(identical(other.currentSessionId, currentSessionId) || other.currentSessionId == currentSessionId)&&const DeepCollectionEquality().equals(other.sessionById, sessionById)&&(identical(other.highlightColor, highlightColor) || other.highlightColor == highlightColor)&&const DeepCollectionEquality().equals(other.bookmarks, bookmarks)&&const DeepCollectionEquality().equals(other.annotations, annotations)&&(identical(other.toolbar, toolbar) || other.toolbar == toolbar)&&(identical(other.passage, passage) || other.passage == passage)&&(identical(other.selection, selection) || other.selection == selection)&&const DeepCollectionEquality().equals(other.searchHistory, searchHistory));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,translation,lastReference,currentSessionId,const DeepCollectionEquality().hash(sessionById),highlightColor,const DeepCollectionEquality().hash(bookmarks),const DeepCollectionEquality().hash(annotations),toolbar,passage,selection,const DeepCollectionEquality().hash(searchHistory));

@override
String toString() {
  return 'User(translation: $translation, lastReference: $lastReference, currentSessionId: $currentSessionId, sessionById: $sessionById, highlightColor: $highlightColor, bookmarks: $bookmarks, annotations: $annotations, toolbar: $toolbar, passage: $passage, selection: $selection, searchHistory: $searchHistory)';
}


}

/// @nodoc
abstract mixin class $UserCopyWith<$Res>  {
  factory $UserCopyWith(User value, $Res Function(User) _then) = _$UserCopyWithImpl;
@useResult
$Res call({
 BibleTranslation translation, ChapterReference lastReference, String? currentSessionId, Map<String, ChapterReference> sessionById, ColorEnum highlightColor, List<Bookmark> bookmarks, List<Annotation> annotations, ToolbarConfiguration toolbar, PassageConfiguration passage, SelectionConfiguration selection, List<String> searchHistory
});


$ToolbarConfigurationCopyWith<$Res> get toolbar;$PassageConfigurationCopyWith<$Res> get passage;$SelectionConfigurationCopyWith<$Res> get selection;

}
/// @nodoc
class _$UserCopyWithImpl<$Res>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._self, this._then);

  final User _self;
  final $Res Function(User) _then;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? translation = null,Object? lastReference = null,Object? currentSessionId = freezed,Object? sessionById = null,Object? highlightColor = null,Object? bookmarks = null,Object? annotations = null,Object? toolbar = null,Object? passage = null,Object? selection = null,Object? searchHistory = null,}) {
  return _then(_self.copyWith(
translation: null == translation ? _self.translation : translation // ignore: cast_nullable_to_non_nullable
as BibleTranslation,lastReference: null == lastReference ? _self.lastReference : lastReference // ignore: cast_nullable_to_non_nullable
as ChapterReference,currentSessionId: freezed == currentSessionId ? _self.currentSessionId : currentSessionId // ignore: cast_nullable_to_non_nullable
as String?,sessionById: null == sessionById ? _self.sessionById : sessionById // ignore: cast_nullable_to_non_nullable
as Map<String, ChapterReference>,highlightColor: null == highlightColor ? _self.highlightColor : highlightColor // ignore: cast_nullable_to_non_nullable
as ColorEnum,bookmarks: null == bookmarks ? _self.bookmarks : bookmarks // ignore: cast_nullable_to_non_nullable
as List<Bookmark>,annotations: null == annotations ? _self.annotations : annotations // ignore: cast_nullable_to_non_nullable
as List<Annotation>,toolbar: null == toolbar ? _self.toolbar : toolbar // ignore: cast_nullable_to_non_nullable
as ToolbarConfiguration,passage: null == passage ? _self.passage : passage // ignore: cast_nullable_to_non_nullable
as PassageConfiguration,selection: null == selection ? _self.selection : selection // ignore: cast_nullable_to_non_nullable
as SelectionConfiguration,searchHistory: null == searchHistory ? _self.searchHistory : searchHistory // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}
/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ToolbarConfigurationCopyWith<$Res> get toolbar {
  
  return $ToolbarConfigurationCopyWith<$Res>(_self.toolbar, (value) {
    return _then(_self.copyWith(toolbar: value));
  });
}/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PassageConfigurationCopyWith<$Res> get passage {
  
  return $PassageConfigurationCopyWith<$Res>(_self.passage, (value) {
    return _then(_self.copyWith(passage: value));
  });
}/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SelectionConfigurationCopyWith<$Res> get selection {
  
  return $SelectionConfigurationCopyWith<$Res>(_self.selection, (value) {
    return _then(_self.copyWith(selection: value));
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BibleTranslation translation,  ChapterReference lastReference,  String? currentSessionId,  Map<String, ChapterReference> sessionById,  ColorEnum highlightColor,  List<Bookmark> bookmarks,  List<Annotation> annotations,  ToolbarConfiguration toolbar,  PassageConfiguration passage,  SelectionConfiguration selection,  List<String> searchHistory)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _User() when $default != null:
return $default(_that.translation,_that.lastReference,_that.currentSessionId,_that.sessionById,_that.highlightColor,_that.bookmarks,_that.annotations,_that.toolbar,_that.passage,_that.selection,_that.searchHistory);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BibleTranslation translation,  ChapterReference lastReference,  String? currentSessionId,  Map<String, ChapterReference> sessionById,  ColorEnum highlightColor,  List<Bookmark> bookmarks,  List<Annotation> annotations,  ToolbarConfiguration toolbar,  PassageConfiguration passage,  SelectionConfiguration selection,  List<String> searchHistory)  $default,) {final _that = this;
switch (_that) {
case _User():
return $default(_that.translation,_that.lastReference,_that.currentSessionId,_that.sessionById,_that.highlightColor,_that.bookmarks,_that.annotations,_that.toolbar,_that.passage,_that.selection,_that.searchHistory);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BibleTranslation translation,  ChapterReference lastReference,  String? currentSessionId,  Map<String, ChapterReference> sessionById,  ColorEnum highlightColor,  List<Bookmark> bookmarks,  List<Annotation> annotations,  ToolbarConfiguration toolbar,  PassageConfiguration passage,  SelectionConfiguration selection,  List<String> searchHistory)?  $default,) {final _that = this;
switch (_that) {
case _User() when $default != null:
return $default(_that.translation,_that.lastReference,_that.currentSessionId,_that.sessionById,_that.highlightColor,_that.bookmarks,_that.annotations,_that.toolbar,_that.passage,_that.selection,_that.searchHistory);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _User extends User {
  const _User({this.translation = BibleTranslation.asv, this.lastReference = const ChapterReference(chapterNum: 1, book: BookType.genesis), this.currentSessionId, final  Map<String, ChapterReference> sessionById = const {}, this.highlightColor = ColorEnum.yellow, final  List<Bookmark> bookmarks = const [], final  List<Annotation> annotations = const [], this.toolbar = const ToolbarConfiguration(), this.passage = const PassageConfiguration(), this.selection = const SelectionConfiguration(), final  List<String> searchHistory = const []}): _sessionById = sessionById,_bookmarks = bookmarks,_annotations = annotations,_searchHistory = searchHistory,super._();
  factory _User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

@override@JsonKey() final  BibleTranslation translation;
@override@JsonKey() final  ChapterReference lastReference;
@override final  String? currentSessionId;
 final  Map<String, ChapterReference> _sessionById;
@override@JsonKey() Map<String, ChapterReference> get sessionById {
  if (_sessionById is EqualUnmodifiableMapView) return _sessionById;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_sessionById);
}

@override@JsonKey() final  ColorEnum highlightColor;
 final  List<Bookmark> _bookmarks;
@override@JsonKey() List<Bookmark> get bookmarks {
  if (_bookmarks is EqualUnmodifiableListView) return _bookmarks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_bookmarks);
}

 final  List<Annotation> _annotations;
@override@JsonKey() List<Annotation> get annotations {
  if (_annotations is EqualUnmodifiableListView) return _annotations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_annotations);
}

@override@JsonKey() final  ToolbarConfiguration toolbar;
@override@JsonKey() final  PassageConfiguration passage;
@override@JsonKey() final  SelectionConfiguration selection;
 final  List<String> _searchHistory;
@override@JsonKey() List<String> get searchHistory {
  if (_searchHistory is EqualUnmodifiableListView) return _searchHistory;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_searchHistory);
}


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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _User&&(identical(other.translation, translation) || other.translation == translation)&&(identical(other.lastReference, lastReference) || other.lastReference == lastReference)&&(identical(other.currentSessionId, currentSessionId) || other.currentSessionId == currentSessionId)&&const DeepCollectionEquality().equals(other._sessionById, _sessionById)&&(identical(other.highlightColor, highlightColor) || other.highlightColor == highlightColor)&&const DeepCollectionEquality().equals(other._bookmarks, _bookmarks)&&const DeepCollectionEquality().equals(other._annotations, _annotations)&&(identical(other.toolbar, toolbar) || other.toolbar == toolbar)&&(identical(other.passage, passage) || other.passage == passage)&&(identical(other.selection, selection) || other.selection == selection)&&const DeepCollectionEquality().equals(other._searchHistory, _searchHistory));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,translation,lastReference,currentSessionId,const DeepCollectionEquality().hash(_sessionById),highlightColor,const DeepCollectionEquality().hash(_bookmarks),const DeepCollectionEquality().hash(_annotations),toolbar,passage,selection,const DeepCollectionEquality().hash(_searchHistory));

@override
String toString() {
  return 'User(translation: $translation, lastReference: $lastReference, currentSessionId: $currentSessionId, sessionById: $sessionById, highlightColor: $highlightColor, bookmarks: $bookmarks, annotations: $annotations, toolbar: $toolbar, passage: $passage, selection: $selection, searchHistory: $searchHistory)';
}


}

/// @nodoc
abstract mixin class _$UserCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$UserCopyWith(_User value, $Res Function(_User) _then) = __$UserCopyWithImpl;
@override @useResult
$Res call({
 BibleTranslation translation, ChapterReference lastReference, String? currentSessionId, Map<String, ChapterReference> sessionById, ColorEnum highlightColor, List<Bookmark> bookmarks, List<Annotation> annotations, ToolbarConfiguration toolbar, PassageConfiguration passage, SelectionConfiguration selection, List<String> searchHistory
});


@override $ToolbarConfigurationCopyWith<$Res> get toolbar;@override $PassageConfigurationCopyWith<$Res> get passage;@override $SelectionConfigurationCopyWith<$Res> get selection;

}
/// @nodoc
class __$UserCopyWithImpl<$Res>
    implements _$UserCopyWith<$Res> {
  __$UserCopyWithImpl(this._self, this._then);

  final _User _self;
  final $Res Function(_User) _then;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? translation = null,Object? lastReference = null,Object? currentSessionId = freezed,Object? sessionById = null,Object? highlightColor = null,Object? bookmarks = null,Object? annotations = null,Object? toolbar = null,Object? passage = null,Object? selection = null,Object? searchHistory = null,}) {
  return _then(_User(
translation: null == translation ? _self.translation : translation // ignore: cast_nullable_to_non_nullable
as BibleTranslation,lastReference: null == lastReference ? _self.lastReference : lastReference // ignore: cast_nullable_to_non_nullable
as ChapterReference,currentSessionId: freezed == currentSessionId ? _self.currentSessionId : currentSessionId // ignore: cast_nullable_to_non_nullable
as String?,sessionById: null == sessionById ? _self._sessionById : sessionById // ignore: cast_nullable_to_non_nullable
as Map<String, ChapterReference>,highlightColor: null == highlightColor ? _self.highlightColor : highlightColor // ignore: cast_nullable_to_non_nullable
as ColorEnum,bookmarks: null == bookmarks ? _self._bookmarks : bookmarks // ignore: cast_nullable_to_non_nullable
as List<Bookmark>,annotations: null == annotations ? _self._annotations : annotations // ignore: cast_nullable_to_non_nullable
as List<Annotation>,toolbar: null == toolbar ? _self.toolbar : toolbar // ignore: cast_nullable_to_non_nullable
as ToolbarConfiguration,passage: null == passage ? _self.passage : passage // ignore: cast_nullable_to_non_nullable
as PassageConfiguration,selection: null == selection ? _self.selection : selection // ignore: cast_nullable_to_non_nullable
as SelectionConfiguration,searchHistory: null == searchHistory ? _self._searchHistory : searchHistory // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ToolbarConfigurationCopyWith<$Res> get toolbar {
  
  return $ToolbarConfigurationCopyWith<$Res>(_self.toolbar, (value) {
    return _then(_self.copyWith(toolbar: value));
  });
}/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PassageConfigurationCopyWith<$Res> get passage {
  
  return $PassageConfigurationCopyWith<$Res>(_self.passage, (value) {
    return _then(_self.copyWith(passage: value));
  });
}/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SelectionConfigurationCopyWith<$Res> get selection {
  
  return $SelectionConfigurationCopyWith<$Res>(_self.selection, (value) {
    return _then(_self.copyWith(selection: value));
  });
}
}

// dart format on
