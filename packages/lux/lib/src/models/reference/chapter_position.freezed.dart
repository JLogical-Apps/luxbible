// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chapter_position.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChapterPosition {

 ChapterReference get reference; int? get verseNum;
/// Create a copy of ChapterPosition
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChapterPositionCopyWith<ChapterPosition> get copyWith => _$ChapterPositionCopyWithImpl<ChapterPosition>(this as ChapterPosition, _$identity);

  /// Serializes this ChapterPosition to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChapterPosition&&(identical(other.reference, reference) || other.reference == reference)&&(identical(other.verseNum, verseNum) || other.verseNum == verseNum));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,reference,verseNum);

@override
String toString() {
  return 'ChapterPosition(reference: $reference, verseNum: $verseNum)';
}


}

/// @nodoc
abstract mixin class $ChapterPositionCopyWith<$Res>  {
  factory $ChapterPositionCopyWith(ChapterPosition value, $Res Function(ChapterPosition) _then) = _$ChapterPositionCopyWithImpl;
@useResult
$Res call({
 ChapterReference reference, int? verseNum
});




}
/// @nodoc
class _$ChapterPositionCopyWithImpl<$Res>
    implements $ChapterPositionCopyWith<$Res> {
  _$ChapterPositionCopyWithImpl(this._self, this._then);

  final ChapterPosition _self;
  final $Res Function(ChapterPosition) _then;

/// Create a copy of ChapterPosition
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? reference = null,Object? verseNum = freezed,}) {
  return _then(ChapterPosition(
reference: null == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as ChapterReference,verseNum: freezed == verseNum ? _self.verseNum : verseNum // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [ChapterPosition].
extension ChapterPositionPatterns on ChapterPosition {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChapterPosition value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChapterPosition() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChapterPosition value)  $default,){
final _that = this;
switch (_that) {
case _ChapterPosition():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChapterPosition value)?  $default,){
final _that = this;
switch (_that) {
case _ChapterPosition() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ChapterReference reference,  int? verseNum)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChapterPosition() when $default != null:
return $default(_that.reference,_that.verseNum);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ChapterReference reference,  int? verseNum)  $default,) {final _that = this;
switch (_that) {
case _ChapterPosition():
return $default(_that.reference,_that.verseNum);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ChapterReference reference,  int? verseNum)?  $default,) {final _that = this;
switch (_that) {
case _ChapterPosition() when $default != null:
return $default(_that.reference,_that.verseNum);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChapterPosition extends ChapterPosition {
  const _ChapterPosition({required this.reference, this.verseNum}): super._();
  factory _ChapterPosition.fromJson(Map<String, dynamic> json) => _$ChapterPositionFromJson(json);

@override final  ChapterReference reference;
@override final  int? verseNum;

/// Create a copy of ChapterPosition
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChapterPositionCopyWith<_ChapterPosition> get copyWith => __$ChapterPositionCopyWithImpl<_ChapterPosition>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChapterPositionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChapterPosition&&(identical(other.reference, reference) || other.reference == reference)&&(identical(other.verseNum, verseNum) || other.verseNum == verseNum));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,reference,verseNum);

@override
String toString() {
  return 'ChapterPosition(reference: $reference, verseNum: $verseNum)';
}


}

/// @nodoc
abstract mixin class _$ChapterPositionCopyWith<$Res> implements $ChapterPositionCopyWith<$Res> {
  factory _$ChapterPositionCopyWith(_ChapterPosition value, $Res Function(_ChapterPosition) _then) = __$ChapterPositionCopyWithImpl;
@override @useResult
$Res call({
 ChapterReference reference, int? verseNum
});




}
/// @nodoc
class __$ChapterPositionCopyWithImpl<$Res>
    implements _$ChapterPositionCopyWith<$Res> {
  __$ChapterPositionCopyWithImpl(this._self, this._then);

  final _ChapterPosition _self;
  final $Res Function(_ChapterPosition) _then;

/// Create a copy of ChapterPosition
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? reference = null,Object? verseNum = freezed,}) {
  return _then(_ChapterPosition(
reference: null == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as ChapterReference,verseNum: freezed == verseNum ? _self.verseNum : verseNum // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
