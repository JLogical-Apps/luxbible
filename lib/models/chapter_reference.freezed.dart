// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chapter_reference.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChapterReference implements DiagnosticableTreeMixin {

 BookType get book; int get chapterNum;
/// Create a copy of ChapterReference
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChapterReferenceCopyWith<ChapterReference> get copyWith => _$ChapterReferenceCopyWithImpl<ChapterReference>(this as ChapterReference, _$identity);

  /// Serializes this ChapterReference to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ChapterReference'))
    ..add(DiagnosticsProperty('book', book))..add(DiagnosticsProperty('chapterNum', chapterNum));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChapterReference&&(identical(other.book, book) || other.book == book)&&(identical(other.chapterNum, chapterNum) || other.chapterNum == chapterNum));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,book,chapterNum);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ChapterReference(book: $book, chapterNum: $chapterNum)';
}


}

/// @nodoc
abstract mixin class $ChapterReferenceCopyWith<$Res>  {
  factory $ChapterReferenceCopyWith(ChapterReference value, $Res Function(ChapterReference) _then) = _$ChapterReferenceCopyWithImpl;
@useResult
$Res call({
 BookType book, int chapterNum
});




}
/// @nodoc
class _$ChapterReferenceCopyWithImpl<$Res>
    implements $ChapterReferenceCopyWith<$Res> {
  _$ChapterReferenceCopyWithImpl(this._self, this._then);

  final ChapterReference _self;
  final $Res Function(ChapterReference) _then;

/// Create a copy of ChapterReference
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? book = null,Object? chapterNum = null,}) {
  return _then(_self.copyWith(
book: null == book ? _self.book : book // ignore: cast_nullable_to_non_nullable
as BookType,chapterNum: null == chapterNum ? _self.chapterNum : chapterNum // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ChapterReference].
extension ChapterReferencePatterns on ChapterReference {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChapterReference value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChapterReference() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChapterReference value)  $default,){
final _that = this;
switch (_that) {
case _ChapterReference():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChapterReference value)?  $default,){
final _that = this;
switch (_that) {
case _ChapterReference() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BookType book,  int chapterNum)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChapterReference() when $default != null:
return $default(_that.book,_that.chapterNum);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BookType book,  int chapterNum)  $default,) {final _that = this;
switch (_that) {
case _ChapterReference():
return $default(_that.book,_that.chapterNum);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BookType book,  int chapterNum)?  $default,) {final _that = this;
switch (_that) {
case _ChapterReference() when $default != null:
return $default(_that.book,_that.chapterNum);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChapterReference extends ChapterReference with DiagnosticableTreeMixin {
  const _ChapterReference({required this.book, required this.chapterNum}): super._();
  factory _ChapterReference.fromJson(Map<String, dynamic> json) => _$ChapterReferenceFromJson(json);

@override final  BookType book;
@override final  int chapterNum;

/// Create a copy of ChapterReference
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChapterReferenceCopyWith<_ChapterReference> get copyWith => __$ChapterReferenceCopyWithImpl<_ChapterReference>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChapterReferenceToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ChapterReference'))
    ..add(DiagnosticsProperty('book', book))..add(DiagnosticsProperty('chapterNum', chapterNum));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChapterReference&&(identical(other.book, book) || other.book == book)&&(identical(other.chapterNum, chapterNum) || other.chapterNum == chapterNum));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,book,chapterNum);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ChapterReference(book: $book, chapterNum: $chapterNum)';
}


}

/// @nodoc
abstract mixin class _$ChapterReferenceCopyWith<$Res> implements $ChapterReferenceCopyWith<$Res> {
  factory _$ChapterReferenceCopyWith(_ChapterReference value, $Res Function(_ChapterReference) _then) = __$ChapterReferenceCopyWithImpl;
@override @useResult
$Res call({
 BookType book, int chapterNum
});




}
/// @nodoc
class __$ChapterReferenceCopyWithImpl<$Res>
    implements _$ChapterReferenceCopyWith<$Res> {
  __$ChapterReferenceCopyWithImpl(this._self, this._then);

  final _ChapterReference _self;
  final $Res Function(_ChapterReference) _then;

/// Create a copy of ChapterReference
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? book = null,Object? chapterNum = null,}) {
  return _then(_ChapterReference(
book: null == book ? _self.book : book // ignore: cast_nullable_to_non_nullable
as BookType,chapterNum: null == chapterNum ? _self.chapterNum : chapterNum // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
