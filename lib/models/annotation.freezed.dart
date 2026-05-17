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

 List<BibleTextSelection> get textSelections; List<VerseSelection> get verseSelections; ColorEnum get color; String? get note; DateTime get createdAt;
/// Create a copy of Annotation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnnotationCopyWith<Annotation> get copyWith => _$AnnotationCopyWithImpl<Annotation>(this as Annotation, _$identity);

  /// Serializes this Annotation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Annotation&&const DeepCollectionEquality().equals(other.textSelections, textSelections)&&const DeepCollectionEquality().equals(other.verseSelections, verseSelections)&&(identical(other.color, color) || other.color == color)&&(identical(other.note, note) || other.note == note)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(textSelections),const DeepCollectionEquality().hash(verseSelections),color,note,createdAt);

@override
String toString() {
  return 'Annotation(textSelections: $textSelections, verseSelections: $verseSelections, color: $color, note: $note, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $AnnotationCopyWith<$Res>  {
  factory $AnnotationCopyWith(Annotation value, $Res Function(Annotation) _then) = _$AnnotationCopyWithImpl;
@useResult
$Res call({
 List<BibleTextSelection> textSelections, List<VerseSelection> verseSelections, ColorEnum color, String? note, DateTime createdAt
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
@pragma('vm:prefer-inline') @override $Res call({Object? textSelections = null,Object? verseSelections = null,Object? color = null,Object? note = freezed,Object? createdAt = null,}) {
  return _then(_self.copyWith(
textSelections: null == textSelections ? _self.textSelections : textSelections // ignore: cast_nullable_to_non_nullable
as List<BibleTextSelection>,verseSelections: null == verseSelections ? _self.verseSelections : verseSelections // ignore: cast_nullable_to_non_nullable
as List<VerseSelection>,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<BibleTextSelection> textSelections,  List<VerseSelection> verseSelections,  ColorEnum color,  String? note,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Annotation() when $default != null:
return $default(_that.textSelections,_that.verseSelections,_that.color,_that.note,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<BibleTextSelection> textSelections,  List<VerseSelection> verseSelections,  ColorEnum color,  String? note,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _Annotation():
return $default(_that.textSelections,_that.verseSelections,_that.color,_that.note,_that.createdAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<BibleTextSelection> textSelections,  List<VerseSelection> verseSelections,  ColorEnum color,  String? note,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _Annotation() when $default != null:
return $default(_that.textSelections,_that.verseSelections,_that.color,_that.note,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Annotation extends Annotation {
  const _Annotation({final  List<BibleTextSelection> textSelections = const [], final  List<VerseSelection> verseSelections = const [], this.color = ColorEnum.stone, this.note, required this.createdAt}): _textSelections = textSelections,_verseSelections = verseSelections,super._();
  factory _Annotation.fromJson(Map<String, dynamic> json) => _$AnnotationFromJson(json);

 final  List<BibleTextSelection> _textSelections;
@override@JsonKey() List<BibleTextSelection> get textSelections {
  if (_textSelections is EqualUnmodifiableListView) return _textSelections;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_textSelections);
}

 final  List<VerseSelection> _verseSelections;
@override@JsonKey() List<VerseSelection> get verseSelections {
  if (_verseSelections is EqualUnmodifiableListView) return _verseSelections;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_verseSelections);
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Annotation&&const DeepCollectionEquality().equals(other._textSelections, _textSelections)&&const DeepCollectionEquality().equals(other._verseSelections, _verseSelections)&&(identical(other.color, color) || other.color == color)&&(identical(other.note, note) || other.note == note)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_textSelections),const DeepCollectionEquality().hash(_verseSelections),color,note,createdAt);

@override
String toString() {
  return 'Annotation(textSelections: $textSelections, verseSelections: $verseSelections, color: $color, note: $note, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$AnnotationCopyWith<$Res> implements $AnnotationCopyWith<$Res> {
  factory _$AnnotationCopyWith(_Annotation value, $Res Function(_Annotation) _then) = __$AnnotationCopyWithImpl;
@override @useResult
$Res call({
 List<BibleTextSelection> textSelections, List<VerseSelection> verseSelections, ColorEnum color, String? note, DateTime createdAt
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
@override @pragma('vm:prefer-inline') $Res call({Object? textSelections = null,Object? verseSelections = null,Object? color = null,Object? note = freezed,Object? createdAt = null,}) {
  return _then(_Annotation(
textSelections: null == textSelections ? _self._textSelections : textSelections // ignore: cast_nullable_to_non_nullable
as List<BibleTextSelection>,verseSelections: null == verseSelections ? _self._verseSelections : verseSelections // ignore: cast_nullable_to_non_nullable
as List<VerseSelection>,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as ColorEnum,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
