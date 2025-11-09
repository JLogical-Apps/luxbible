// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserProfile {

 BibleTranslation get translation; List<ChapterReference> get tabs; List<ChapterReference> get previouslyViewed;
/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserProfileCopyWith<UserProfile> get copyWith => _$UserProfileCopyWithImpl<UserProfile>(this as UserProfile, _$identity);

  /// Serializes this UserProfile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserProfile&&(identical(other.translation, translation) || other.translation == translation)&&const DeepCollectionEquality().equals(other.tabs, tabs)&&const DeepCollectionEquality().equals(other.previouslyViewed, previouslyViewed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,translation,const DeepCollectionEquality().hash(tabs),const DeepCollectionEquality().hash(previouslyViewed));

@override
String toString() {
  return 'UserProfile(translation: $translation, tabs: $tabs, previouslyViewed: $previouslyViewed)';
}


}

/// @nodoc
abstract mixin class $UserProfileCopyWith<$Res>  {
  factory $UserProfileCopyWith(UserProfile value, $Res Function(UserProfile) _then) = _$UserProfileCopyWithImpl;
@useResult
$Res call({
 BibleTranslation translation, List<ChapterReference> tabs, List<ChapterReference> previouslyViewed
});




}
/// @nodoc
class _$UserProfileCopyWithImpl<$Res>
    implements $UserProfileCopyWith<$Res> {
  _$UserProfileCopyWithImpl(this._self, this._then);

  final UserProfile _self;
  final $Res Function(UserProfile) _then;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? translation = null,Object? tabs = null,Object? previouslyViewed = null,}) {
  return _then(_self.copyWith(
translation: null == translation ? _self.translation : translation // ignore: cast_nullable_to_non_nullable
as BibleTranslation,tabs: null == tabs ? _self.tabs : tabs // ignore: cast_nullable_to_non_nullable
as List<ChapterReference>,previouslyViewed: null == previouslyViewed ? _self.previouslyViewed : previouslyViewed // ignore: cast_nullable_to_non_nullable
as List<ChapterReference>,
  ));
}

}


/// Adds pattern-matching-related methods to [UserProfile].
extension UserProfilePatterns on UserProfile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserProfile value)  $default,){
final _that = this;
switch (_that) {
case _UserProfile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserProfile value)?  $default,){
final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BibleTranslation translation,  List<ChapterReference> tabs,  List<ChapterReference> previouslyViewed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
return $default(_that.translation,_that.tabs,_that.previouslyViewed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BibleTranslation translation,  List<ChapterReference> tabs,  List<ChapterReference> previouslyViewed)  $default,) {final _that = this;
switch (_that) {
case _UserProfile():
return $default(_that.translation,_that.tabs,_that.previouslyViewed);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BibleTranslation translation,  List<ChapterReference> tabs,  List<ChapterReference> previouslyViewed)?  $default,) {final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
return $default(_that.translation,_that.tabs,_that.previouslyViewed);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserProfile extends UserProfile {
  const _UserProfile({this.translation = BibleTranslation.asv, final  List<ChapterReference> tabs = const [], final  List<ChapterReference> previouslyViewed = const []}): _tabs = tabs,_previouslyViewed = previouslyViewed,super._();
  factory _UserProfile.fromJson(Map<String, dynamic> json) => _$UserProfileFromJson(json);

@override@JsonKey() final  BibleTranslation translation;
 final  List<ChapterReference> _tabs;
@override@JsonKey() List<ChapterReference> get tabs {
  if (_tabs is EqualUnmodifiableListView) return _tabs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tabs);
}

 final  List<ChapterReference> _previouslyViewed;
@override@JsonKey() List<ChapterReference> get previouslyViewed {
  if (_previouslyViewed is EqualUnmodifiableListView) return _previouslyViewed;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_previouslyViewed);
}


/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserProfileCopyWith<_UserProfile> get copyWith => __$UserProfileCopyWithImpl<_UserProfile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserProfileToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserProfile&&(identical(other.translation, translation) || other.translation == translation)&&const DeepCollectionEquality().equals(other._tabs, _tabs)&&const DeepCollectionEquality().equals(other._previouslyViewed, _previouslyViewed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,translation,const DeepCollectionEquality().hash(_tabs),const DeepCollectionEquality().hash(_previouslyViewed));

@override
String toString() {
  return 'UserProfile(translation: $translation, tabs: $tabs, previouslyViewed: $previouslyViewed)';
}


}

/// @nodoc
abstract mixin class _$UserProfileCopyWith<$Res> implements $UserProfileCopyWith<$Res> {
  factory _$UserProfileCopyWith(_UserProfile value, $Res Function(_UserProfile) _then) = __$UserProfileCopyWithImpl;
@override @useResult
$Res call({
 BibleTranslation translation, List<ChapterReference> tabs, List<ChapterReference> previouslyViewed
});




}
/// @nodoc
class __$UserProfileCopyWithImpl<$Res>
    implements _$UserProfileCopyWith<$Res> {
  __$UserProfileCopyWithImpl(this._self, this._then);

  final _UserProfile _self;
  final $Res Function(_UserProfile) _then;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? translation = null,Object? tabs = null,Object? previouslyViewed = null,}) {
  return _then(_UserProfile(
translation: null == translation ? _self.translation : translation // ignore: cast_nullable_to_non_nullable
as BibleTranslation,tabs: null == tabs ? _self._tabs : tabs // ignore: cast_nullable_to_non_nullable
as List<ChapterReference>,previouslyViewed: null == previouslyViewed ? _self._previouslyViewed : previouslyViewed // ignore: cast_nullable_to_non_nullable
as List<ChapterReference>,
  ));
}


}

// dart format on
