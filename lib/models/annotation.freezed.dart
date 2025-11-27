// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'annotation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Annotation {

 List<Selection> get selections; List<Passage> get passages; ColorEnum get color; String? get note; DateTime get createdAt;
/// Create a copy of Annotation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnnotationCopyWith<Annotation> get copyWith => _$AnnotationCopyWithImpl<Annotation>(this as Annotation, _$identity);

  /// Serializes this Annotation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Annotation&&const DeepCollectionEquality().equals(other.selections, selections)&&const DeepCollectionEquality().equals(other.passages, passages)&&(identical(other.color, color) || other.color == color)&&(identical(other.note, note) || other.note == note)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(selections),const DeepCollectionEquality().hash(passages),color,note,createdAt);

@override
String toString() {
  return 'Annotation(selections: $selections, passages: $passages, color: $color, note: $note, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $AnnotationCopyWith<$Res>  {
  factory $AnnotationCopyWith(Annotation value, $Res Function(Annotation) _then) = _$AnnotationCopyWithImpl;
@useResult
$Res call({
 List<Selection> selections, List<Passage> passages, ColorEnum color, String? note, DateTime createdAt
});




}
/// @nodoc
class _$AnnotationCopyWithImpl<$Res>
    implements $AnnotationCopyWith<$Res> {
  _$AnnotationCopyWithImpl(this._self, this._then);

  final Annotation _self;
  final $Res Function(Annotation) _then;

/// Create a copy of Annotation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? selections = null,Object? passages = null,Object? color = null,Object? note = freezed,Object? createdAt = null,}) {
  return _then(_self.copyWith(
selections: null == selections ? _self.selections : selections // ignore: cast_nullable_to_non_nullable
as List<Selection>,passages: null == passages ? _self.passages : passages // ignore: cast_nullable_to_non_nullable
as List<Passage>,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as ColorEnum,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [Annotation].
extension AnnotationPatterns on Annotation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Annotation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Annotation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Annotation value)  $default,){
final _that = this;
switch (_that) {
case _Annotation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Annotation value)?  $default,){
final _that = this;
switch (_that) {
case _Annotation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Selection> selections,  List<Passage> passages,  ColorEnum color,  String? note,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Annotation() when $default != null:
return $default(_that.selections,_that.passages,_that.color,_that.note,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Selection> selections,  List<Passage> passages,  ColorEnum color,  String? note,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _Annotation():
return $default(_that.selections,_that.passages,_that.color,_that.note,_that.createdAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Selection> selections,  List<Passage> passages,  ColorEnum color,  String? note,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _Annotation() when $default != null:
return $default(_that.selections,_that.passages,_that.color,_that.note,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Annotation extends Annotation {
  const _Annotation({final  List<Selection> selections = const [], final  List<Passage> passages = const [], this.color = ColorEnum.stone, this.note, required this.createdAt}): _selections = selections,_passages = passages,super._();
  factory _Annotation.fromJson(Map<String, dynamic> json) => _$AnnotationFromJson(json);

 final  List<Selection> _selections;
@override@JsonKey() List<Selection> get selections {
  if (_selections is EqualUnmodifiableListView) return _selections;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_selections);
}

 final  List<Passage> _passages;
@override@JsonKey() List<Passage> get passages {
  if (_passages is EqualUnmodifiableListView) return _passages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_passages);
}

@override@JsonKey() final  ColorEnum color;
@override final  String? note;
@override final  DateTime createdAt;

/// Create a copy of Annotation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AnnotationCopyWith<_Annotation> get copyWith => __$AnnotationCopyWithImpl<_Annotation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AnnotationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Annotation&&const DeepCollectionEquality().equals(other._selections, _selections)&&const DeepCollectionEquality().equals(other._passages, _passages)&&(identical(other.color, color) || other.color == color)&&(identical(other.note, note) || other.note == note)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_selections),const DeepCollectionEquality().hash(_passages),color,note,createdAt);

@override
String toString() {
  return 'Annotation(selections: $selections, passages: $passages, color: $color, note: $note, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$AnnotationCopyWith<$Res> implements $AnnotationCopyWith<$Res> {
  factory _$AnnotationCopyWith(_Annotation value, $Res Function(_Annotation) _then) = __$AnnotationCopyWithImpl;
@override @useResult
$Res call({
 List<Selection> selections, List<Passage> passages, ColorEnum color, String? note, DateTime createdAt
});




}
/// @nodoc
class __$AnnotationCopyWithImpl<$Res>
    implements _$AnnotationCopyWith<$Res> {
  __$AnnotationCopyWithImpl(this._self, this._then);

  final _Annotation _self;
  final $Res Function(_Annotation) _then;

/// Create a copy of Annotation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? selections = null,Object? passages = null,Object? color = null,Object? note = freezed,Object? createdAt = null,}) {
  return _then(_Annotation(
selections: null == selections ? _self._selections : selections // ignore: cast_nullable_to_non_nullable
as List<Selection>,passages: null == passages ? _self._passages : passages // ignore: cast_nullable_to_non_nullable
as List<Passage>,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as ColorEnum,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
