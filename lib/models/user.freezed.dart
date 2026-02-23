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

 BibleTranslation get translation; ChapterReference get lastReference; List<ChapterReference> get previouslyViewed; ColorEnum get highlightColor; List<Bookmark> get bookmarks; List<Annotation> get annotations; ToolbarConfiguration get toolbar;
/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserCopyWith<User> get copyWith => _$UserCopyWithImpl<User>(this as User, _$identity);

  /// Serializes this User to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is User&&(identical(other.translation, translation) || other.translation == translation)&&(identical(other.lastReference, lastReference) || other.lastReference == lastReference)&&const DeepCollectionEquality().equals(other.previouslyViewed, previouslyViewed)&&(identical(other.highlightColor, highlightColor) || other.highlightColor == highlightColor)&&const DeepCollectionEquality().equals(other.bookmarks, bookmarks)&&const DeepCollectionEquality().equals(other.annotations, annotations)&&(identical(other.toolbar, toolbar) || other.toolbar == toolbar));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,translation,lastReference,const DeepCollectionEquality().hash(previouslyViewed),highlightColor,const DeepCollectionEquality().hash(bookmarks),const DeepCollectionEquality().hash(annotations),toolbar);

@override
String toString() {
  return 'User(translation: $translation, lastReference: $lastReference, previouslyViewed: $previouslyViewed, highlightColor: $highlightColor, bookmarks: $bookmarks, annotations: $annotations, toolbar: $toolbar)';
}


}

/// @nodoc
abstract mixin class $UserCopyWith<$Res>  {
  factory $UserCopyWith(User value, $Res Function(User) _then) = _$UserCopyWithImpl;
@useResult
$Res call({
 BibleTranslation translation, ChapterReference lastReference, List<ChapterReference> previouslyViewed, ColorEnum highlightColor, List<Bookmark> bookmarks, List<Annotation> annotations, ToolbarConfiguration toolbar
});


$ToolbarConfigurationCopyWith<$Res> get toolbar;

}
/// @nodoc
class _$UserCopyWithImpl<$Res>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._self, this._then);

  final User _self;
  final $Res Function(User) _then;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? translation = null,Object? lastReference = null,Object? previouslyViewed = null,Object? highlightColor = null,Object? bookmarks = null,Object? annotations = null,Object? toolbar = null,}) {
  return _then(_self.copyWith(
translation: null == translation ? _self.translation : translation // ignore: cast_nullable_to_non_nullable
as BibleTranslation,lastReference: null == lastReference ? _self.lastReference : lastReference // ignore: cast_nullable_to_non_nullable
as ChapterReference,previouslyViewed: null == previouslyViewed ? _self.previouslyViewed : previouslyViewed // ignore: cast_nullable_to_non_nullable
as List<ChapterReference>,highlightColor: null == highlightColor ? _self.highlightColor : highlightColor // ignore: cast_nullable_to_non_nullable
as ColorEnum,bookmarks: null == bookmarks ? _self.bookmarks : bookmarks // ignore: cast_nullable_to_non_nullable
as List<Bookmark>,annotations: null == annotations ? _self.annotations : annotations // ignore: cast_nullable_to_non_nullable
as List<Annotation>,toolbar: null == toolbar ? _self.toolbar : toolbar // ignore: cast_nullable_to_non_nullable
as ToolbarConfiguration,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BibleTranslation translation,  ChapterReference lastReference,  List<ChapterReference> previouslyViewed,  ColorEnum highlightColor,  List<Bookmark> bookmarks,  List<Annotation> annotations,  ToolbarConfiguration toolbar)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _User() when $default != null:
return $default(_that.translation,_that.lastReference,_that.previouslyViewed,_that.highlightColor,_that.bookmarks,_that.annotations,_that.toolbar);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BibleTranslation translation,  ChapterReference lastReference,  List<ChapterReference> previouslyViewed,  ColorEnum highlightColor,  List<Bookmark> bookmarks,  List<Annotation> annotations,  ToolbarConfiguration toolbar)  $default,) {final _that = this;
switch (_that) {
case _User():
return $default(_that.translation,_that.lastReference,_that.previouslyViewed,_that.highlightColor,_that.bookmarks,_that.annotations,_that.toolbar);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BibleTranslation translation,  ChapterReference lastReference,  List<ChapterReference> previouslyViewed,  ColorEnum highlightColor,  List<Bookmark> bookmarks,  List<Annotation> annotations,  ToolbarConfiguration toolbar)?  $default,) {final _that = this;
switch (_that) {
case _User() when $default != null:
return $default(_that.translation,_that.lastReference,_that.previouslyViewed,_that.highlightColor,_that.bookmarks,_that.annotations,_that.toolbar);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _User extends User {
  const _User({this.translation = BibleTranslation.asv, this.lastReference = const ChapterReference(chapterNum: 1, book: BookType.genesis), final  List<ChapterReference> previouslyViewed = const [], this.highlightColor = ColorEnum.yellow, final  List<Bookmark> bookmarks = const [], final  List<Annotation> annotations = const [], this.toolbar = const ToolbarConfiguration()}): _previouslyViewed = previouslyViewed,_bookmarks = bookmarks,_annotations = annotations,super._();
  factory _User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

@override@JsonKey() final  BibleTranslation translation;
@override@JsonKey() final  ChapterReference lastReference;
 final  List<ChapterReference> _previouslyViewed;
@override@JsonKey() List<ChapterReference> get previouslyViewed {
  if (_previouslyViewed is EqualUnmodifiableListView) return _previouslyViewed;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_previouslyViewed);
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _User&&(identical(other.translation, translation) || other.translation == translation)&&(identical(other.lastReference, lastReference) || other.lastReference == lastReference)&&const DeepCollectionEquality().equals(other._previouslyViewed, _previouslyViewed)&&(identical(other.highlightColor, highlightColor) || other.highlightColor == highlightColor)&&const DeepCollectionEquality().equals(other._bookmarks, _bookmarks)&&const DeepCollectionEquality().equals(other._annotations, _annotations)&&(identical(other.toolbar, toolbar) || other.toolbar == toolbar));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,translation,lastReference,const DeepCollectionEquality().hash(_previouslyViewed),highlightColor,const DeepCollectionEquality().hash(_bookmarks),const DeepCollectionEquality().hash(_annotations),toolbar);

@override
String toString() {
  return 'User(translation: $translation, lastReference: $lastReference, previouslyViewed: $previouslyViewed, highlightColor: $highlightColor, bookmarks: $bookmarks, annotations: $annotations, toolbar: $toolbar)';
}


}

/// @nodoc
abstract mixin class _$UserCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$UserCopyWith(_User value, $Res Function(_User) _then) = __$UserCopyWithImpl;
@override @useResult
$Res call({
 BibleTranslation translation, ChapterReference lastReference, List<ChapterReference> previouslyViewed, ColorEnum highlightColor, List<Bookmark> bookmarks, List<Annotation> annotations, ToolbarConfiguration toolbar
});


@override $ToolbarConfigurationCopyWith<$Res> get toolbar;

}
/// @nodoc
class __$UserCopyWithImpl<$Res>
    implements _$UserCopyWith<$Res> {
  __$UserCopyWithImpl(this._self, this._then);

  final _User _self;
  final $Res Function(_User) _then;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? translation = null,Object? lastReference = null,Object? previouslyViewed = null,Object? highlightColor = null,Object? bookmarks = null,Object? annotations = null,Object? toolbar = null,}) {
  return _then(_User(
translation: null == translation ? _self.translation : translation // ignore: cast_nullable_to_non_nullable
as BibleTranslation,lastReference: null == lastReference ? _self.lastReference : lastReference // ignore: cast_nullable_to_non_nullable
as ChapterReference,previouslyViewed: null == previouslyViewed ? _self._previouslyViewed : previouslyViewed // ignore: cast_nullable_to_non_nullable
as List<ChapterReference>,highlightColor: null == highlightColor ? _self.highlightColor : highlightColor // ignore: cast_nullable_to_non_nullable
as ColorEnum,bookmarks: null == bookmarks ? _self._bookmarks : bookmarks // ignore: cast_nullable_to_non_nullable
as List<Bookmark>,annotations: null == annotations ? _self._annotations : annotations // ignore: cast_nullable_to_non_nullable
as List<Annotation>,toolbar: null == toolbar ? _self.toolbar : toolbar // ignore: cast_nullable_to_non_nullable
as ToolbarConfiguration,
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
}
}

// dart format on
