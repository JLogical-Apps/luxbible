// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bible_map.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BibleMap {

@JsonKey(name: 'i') String get id;@JsonKey(name: 't') String get title;@JsonKey(name: 'c', includeIfNull: false) String? get caption;@JsonKey(name: 'p') List<VerseSelection> get passages;
/// Create a copy of BibleMap
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BibleMapCopyWith<BibleMap> get copyWith => _$BibleMapCopyWithImpl<BibleMap>(this as BibleMap, _$identity);

  /// Serializes this BibleMap to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BibleMap&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.caption, caption) || other.caption == caption)&&const DeepCollectionEquality().equals(other.passages, passages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,caption,const DeepCollectionEquality().hash(passages));

@override
String toString() {
  return 'BibleMap(id: $id, title: $title, caption: $caption, passages: $passages)';
}


}

/// @nodoc
abstract mixin class $BibleMapCopyWith<$Res>  {
  factory $BibleMapCopyWith(BibleMap value, $Res Function(BibleMap) _then) = _$BibleMapCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'i') String id,@JsonKey(name: 't') String title,@JsonKey(name: 'c', includeIfNull: false) String? caption,@JsonKey(name: 'p') List<VerseSelection> passages
});




}
/// @nodoc
class _$BibleMapCopyWithImpl<$Res>
    implements $BibleMapCopyWith<$Res> {
  _$BibleMapCopyWithImpl(this._self, this._then);

  final BibleMap _self;
  final $Res Function(BibleMap) _then;

/// Create a copy of BibleMap
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? caption = freezed,Object? passages = null,}) {
  return _then(BibleMap(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,caption: freezed == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String?,passages: null == passages ? _self.passages : passages // ignore: cast_nullable_to_non_nullable
as List<VerseSelection>,
  ));
}

}


/// Adds pattern-matching-related methods to [BibleMap].
extension BibleMapPatterns on BibleMap {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BibleMap value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BibleMap() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BibleMap value)  $default,){
final _that = this;
switch (_that) {
case _BibleMap():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BibleMap value)?  $default,){
final _that = this;
switch (_that) {
case _BibleMap() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'i')  String id, @JsonKey(name: 't')  String title, @JsonKey(name: 'c', includeIfNull: false)  String? caption, @JsonKey(name: 'p')  List<VerseSelection> passages)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BibleMap() when $default != null:
return $default(_that.id,_that.title,_that.caption,_that.passages);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'i')  String id, @JsonKey(name: 't')  String title, @JsonKey(name: 'c', includeIfNull: false)  String? caption, @JsonKey(name: 'p')  List<VerseSelection> passages)  $default,) {final _that = this;
switch (_that) {
case _BibleMap():
return $default(_that.id,_that.title,_that.caption,_that.passages);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'i')  String id, @JsonKey(name: 't')  String title, @JsonKey(name: 'c', includeIfNull: false)  String? caption, @JsonKey(name: 'p')  List<VerseSelection> passages)?  $default,) {final _that = this;
switch (_that) {
case _BibleMap() when $default != null:
return $default(_that.id,_that.title,_that.caption,_that.passages);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BibleMap extends BibleMap {
  const _BibleMap({@JsonKey(name: 'i') required this.id, @JsonKey(name: 't') required this.title, @JsonKey(name: 'c', includeIfNull: false) this.caption, @JsonKey(name: 'p') required  List<VerseSelection> passages}): _passages = passages,super._();
  factory _BibleMap.fromJson(Map<String, dynamic> json) => _$BibleMapFromJson(json);

@override@JsonKey(name: 'i') final  String id;
@override@JsonKey(name: 't') final  String title;
@override@JsonKey(name: 'c', includeIfNull: false) final  String? caption;
 final  List<VerseSelection> _passages;
@override@JsonKey(name: 'p') List<VerseSelection> get passages {
  if (_passages is EqualUnmodifiableListView) return _passages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_passages);
}


/// Create a copy of BibleMap
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BibleMapCopyWith<_BibleMap> get copyWith => __$BibleMapCopyWithImpl<_BibleMap>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BibleMapToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BibleMap&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.caption, caption) || other.caption == caption)&&const DeepCollectionEquality().equals(other._passages, _passages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,caption,const DeepCollectionEquality().hash(_passages));

@override
String toString() {
  return 'BibleMap(id: $id, title: $title, caption: $caption, passages: $passages)';
}


}

/// @nodoc
abstract mixin class _$BibleMapCopyWith<$Res> implements $BibleMapCopyWith<$Res> {
  factory _$BibleMapCopyWith(_BibleMap value, $Res Function(_BibleMap) _then) = __$BibleMapCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'i') String id,@JsonKey(name: 't') String title,@JsonKey(name: 'c', includeIfNull: false) String? caption,@JsonKey(name: 'p') List<VerseSelection> passages
});




}
/// @nodoc
class __$BibleMapCopyWithImpl<$Res>
    implements _$BibleMapCopyWith<$Res> {
  __$BibleMapCopyWithImpl(this._self, this._then);

  final _BibleMap _self;
  final $Res Function(_BibleMap) _then;

/// Create a copy of BibleMap
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? caption = freezed,Object? passages = null,}) {
  return _then(_BibleMap(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,caption: freezed == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String?,passages: null == passages ? _self._passages : passages // ignore: cast_nullable_to_non_nullable
as List<VerseSelection>,
  ));
}


}

// dart format on
