// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'selection.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Selection {

 SelectionWordAnchor get start; SelectionWordAnchor get end; BibleTranslation get translation;
/// Create a copy of Selection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SelectionCopyWith<Selection> get copyWith => _$SelectionCopyWithImpl<Selection>(this as Selection, _$identity);

  /// Serializes this Selection to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Selection&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end)&&(identical(other.translation, translation) || other.translation == translation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,start,end,translation);

@override
String toString() {
  return 'Selection(start: $start, end: $end, translation: $translation)';
}


}

/// @nodoc
abstract mixin class $SelectionCopyWith<$Res>  {
  factory $SelectionCopyWith(Selection value, $Res Function(Selection) _then) = _$SelectionCopyWithImpl;
@useResult
$Res call({
 SelectionWordAnchor start, SelectionWordAnchor end, BibleTranslation translation
});




}
/// @nodoc
class _$SelectionCopyWithImpl<$Res>
    implements $SelectionCopyWith<$Res> {
  _$SelectionCopyWithImpl(this._self, this._then);

  final Selection _self;
  final $Res Function(Selection) _then;

/// Create a copy of Selection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? start = null,Object? end = null,Object? translation = null,}) {
  return _then(_self.copyWith(
start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as SelectionWordAnchor,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as SelectionWordAnchor,translation: null == translation ? _self.translation : translation // ignore: cast_nullable_to_non_nullable
as BibleTranslation,
  ));
}

}


/// Adds pattern-matching-related methods to [Selection].
extension SelectionPatterns on Selection {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Selection value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Selection() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Selection value)  $default,){
final _that = this;
switch (_that) {
case _Selection():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Selection value)?  $default,){
final _that = this;
switch (_that) {
case _Selection() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SelectionWordAnchor start,  SelectionWordAnchor end,  BibleTranslation translation)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Selection() when $default != null:
return $default(_that.start,_that.end,_that.translation);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SelectionWordAnchor start,  SelectionWordAnchor end,  BibleTranslation translation)  $default,) {final _that = this;
switch (_that) {
case _Selection():
return $default(_that.start,_that.end,_that.translation);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SelectionWordAnchor start,  SelectionWordAnchor end,  BibleTranslation translation)?  $default,) {final _that = this;
switch (_that) {
case _Selection() when $default != null:
return $default(_that.start,_that.end,_that.translation);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Selection extends Selection {
  const _Selection({required this.start, required this.end, required this.translation}): super._();
  factory _Selection.fromJson(Map<String, dynamic> json) => _$SelectionFromJson(json);

@override final  SelectionWordAnchor start;
@override final  SelectionWordAnchor end;
@override final  BibleTranslation translation;

/// Create a copy of Selection
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SelectionCopyWith<_Selection> get copyWith => __$SelectionCopyWithImpl<_Selection>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SelectionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Selection&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end)&&(identical(other.translation, translation) || other.translation == translation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,start,end,translation);

@override
String toString() {
  return 'Selection(start: $start, end: $end, translation: $translation)';
}


}

/// @nodoc
abstract mixin class _$SelectionCopyWith<$Res> implements $SelectionCopyWith<$Res> {
  factory _$SelectionCopyWith(_Selection value, $Res Function(_Selection) _then) = __$SelectionCopyWithImpl;
@override @useResult
$Res call({
 SelectionWordAnchor start, SelectionWordAnchor end, BibleTranslation translation
});




}
/// @nodoc
class __$SelectionCopyWithImpl<$Res>
    implements _$SelectionCopyWith<$Res> {
  __$SelectionCopyWithImpl(this._self, this._then);

  final _Selection _self;
  final $Res Function(_Selection) _then;

/// Create a copy of Selection
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? start = null,Object? end = null,Object? translation = null,}) {
  return _then(_Selection(
start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as SelectionWordAnchor,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as SelectionWordAnchor,translation: null == translation ? _self.translation : translation // ignore: cast_nullable_to_non_nullable
as BibleTranslation,
  ));
}


}

// dart format on
