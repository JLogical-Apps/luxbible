// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reference.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Reference implements DiagnosticableTreeMixin {

 BookType get book; int get chapterNum; int get verseNum;
/// Create a copy of Reference
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReferenceCopyWith<Reference> get copyWith => _$ReferenceCopyWithImpl<Reference>(this as Reference, _$identity);

  /// Serializes this Reference to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'Reference'))
    ..add(DiagnosticsProperty('book', book))..add(DiagnosticsProperty('chapterNum', chapterNum))..add(DiagnosticsProperty('verseNum', verseNum));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Reference&&(identical(other.book, book) || other.book == book)&&(identical(other.chapterNum, chapterNum) || other.chapterNum == chapterNum)&&(identical(other.verseNum, verseNum) || other.verseNum == verseNum));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,book,chapterNum,verseNum);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'Reference(book: $book, chapterNum: $chapterNum, verseNum: $verseNum)';
}


}

/// @nodoc
abstract mixin class $ReferenceCopyWith<$Res>  {
  factory $ReferenceCopyWith(Reference value, $Res Function(Reference) _then) = _$ReferenceCopyWithImpl;
@useResult
$Res call({
 BookType book, int chapterNum, int verseNum
});




}
/// @nodoc
class _$ReferenceCopyWithImpl<$Res>
    implements $ReferenceCopyWith<$Res> {
  _$ReferenceCopyWithImpl(this._self, this._then);

  final Reference _self;
  final $Res Function(Reference) _then;

/// Create a copy of Reference
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? book = null,Object? chapterNum = null,Object? verseNum = null,}) {
  return _then(_self.copyWith(
book: null == book ? _self.book : book // ignore: cast_nullable_to_non_nullable
as BookType,chapterNum: null == chapterNum ? _self.chapterNum : chapterNum // ignore: cast_nullable_to_non_nullable
as int,verseNum: null == verseNum ? _self.verseNum : verseNum // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Reference].
extension ReferencePatterns on Reference {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Reference value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Reference() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Reference value)  $default,){
final _that = this;
switch (_that) {
case _Reference():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Reference value)?  $default,){
final _that = this;
switch (_that) {
case _Reference() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BookType book,  int chapterNum,  int verseNum)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Reference() when $default != null:
return $default(_that.book,_that.chapterNum,_that.verseNum);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BookType book,  int chapterNum,  int verseNum)  $default,) {final _that = this;
switch (_that) {
case _Reference():
return $default(_that.book,_that.chapterNum,_that.verseNum);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BookType book,  int chapterNum,  int verseNum)?  $default,) {final _that = this;
switch (_that) {
case _Reference() when $default != null:
return $default(_that.book,_that.chapterNum,_that.verseNum);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Reference extends Reference with DiagnosticableTreeMixin {
  const _Reference({required this.book, required this.chapterNum, required this.verseNum}): super._();
  factory _Reference.fromJson(Map<String, dynamic> json) => _$ReferenceFromJson(json);

@override final  BookType book;
@override final  int chapterNum;
@override final  int verseNum;

/// Create a copy of Reference
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReferenceCopyWith<_Reference> get copyWith => __$ReferenceCopyWithImpl<_Reference>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReferenceToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'Reference'))
    ..add(DiagnosticsProperty('book', book))..add(DiagnosticsProperty('chapterNum', chapterNum))..add(DiagnosticsProperty('verseNum', verseNum));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Reference&&(identical(other.book, book) || other.book == book)&&(identical(other.chapterNum, chapterNum) || other.chapterNum == chapterNum)&&(identical(other.verseNum, verseNum) || other.verseNum == verseNum));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,book,chapterNum,verseNum);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'Reference(book: $book, chapterNum: $chapterNum, verseNum: $verseNum)';
}


}

/// @nodoc
abstract mixin class _$ReferenceCopyWith<$Res> implements $ReferenceCopyWith<$Res> {
  factory _$ReferenceCopyWith(_Reference value, $Res Function(_Reference) _then) = __$ReferenceCopyWithImpl;
@override @useResult
$Res call({
 BookType book, int chapterNum, int verseNum
});




}
/// @nodoc
class __$ReferenceCopyWithImpl<$Res>
    implements _$ReferenceCopyWith<$Res> {
  __$ReferenceCopyWithImpl(this._self, this._then);

  final _Reference _self;
  final $Res Function(_Reference) _then;

/// Create a copy of Reference
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? book = null,Object? chapterNum = null,Object? verseNum = null,}) {
  return _then(_Reference(
book: null == book ? _self.book : book // ignore: cast_nullable_to_non_nullable
as BookType,chapterNum: null == chapterNum ? _self.chapterNum : chapterNum // ignore: cast_nullable_to_non_nullable
as int,verseNum: null == verseNum ? _self.verseNum : verseNum // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
