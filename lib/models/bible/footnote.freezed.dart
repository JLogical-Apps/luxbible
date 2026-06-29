// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'footnote.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Footnote {

@JsonKey(name: 'o') int get offset;@JsonKey(name: 't') String get text;
/// Create a copy of Footnote
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FootnoteCopyWith<Footnote> get copyWith => _$FootnoteCopyWithImpl<Footnote>(this as Footnote, _$identity);

  /// Serializes this Footnote to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Footnote&&(identical(other.offset, offset) || other.offset == offset)&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,offset,text);

@override
String toString() {
  return 'Footnote(offset: $offset, text: $text)';
}


}

/// @nodoc
abstract mixin class $FootnoteCopyWith<$Res>  {
  factory $FootnoteCopyWith(Footnote value, $Res Function(Footnote) _then) = _$FootnoteCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'o') int offset,@JsonKey(name: 't') String text
});




}
/// @nodoc
class _$FootnoteCopyWithImpl<$Res>
    implements $FootnoteCopyWith<$Res> {
  _$FootnoteCopyWithImpl(this._self, this._then);

  final Footnote _self;
  final $Res Function(Footnote) _then;

/// Create a copy of Footnote
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? offset = null,Object? text = null,}) {
  return _then(_self.copyWith(
offset: null == offset ? _self.offset : offset // ignore: cast_nullable_to_non_nullable
as int,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Footnote].
extension FootnotePatterns on Footnote {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Footnote value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Footnote() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Footnote value)  $default,){
final _that = this;
switch (_that) {
case _Footnote():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Footnote value)?  $default,){
final _that = this;
switch (_that) {
case _Footnote() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'o')  int offset, @JsonKey(name: 't')  String text)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Footnote() when $default != null:
return $default(_that.offset,_that.text);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'o')  int offset, @JsonKey(name: 't')  String text)  $default,) {final _that = this;
switch (_that) {
case _Footnote():
return $default(_that.offset,_that.text);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'o')  int offset, @JsonKey(name: 't')  String text)?  $default,) {final _that = this;
switch (_that) {
case _Footnote() when $default != null:
return $default(_that.offset,_that.text);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Footnote implements Footnote {
  const _Footnote({@JsonKey(name: 'o') required this.offset, @JsonKey(name: 't') required this.text});
  factory _Footnote.fromJson(Map<String, dynamic> json) => _$FootnoteFromJson(json);

@override@JsonKey(name: 'o') final  int offset;
@override@JsonKey(name: 't') final  String text;

/// Create a copy of Footnote
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FootnoteCopyWith<_Footnote> get copyWith => __$FootnoteCopyWithImpl<_Footnote>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FootnoteToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Footnote&&(identical(other.offset, offset) || other.offset == offset)&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,offset,text);

@override
String toString() {
  return 'Footnote(offset: $offset, text: $text)';
}


}

/// @nodoc
abstract mixin class _$FootnoteCopyWith<$Res> implements $FootnoteCopyWith<$Res> {
  factory _$FootnoteCopyWith(_Footnote value, $Res Function(_Footnote) _then) = __$FootnoteCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'o') int offset,@JsonKey(name: 't') String text
});




}
/// @nodoc
class __$FootnoteCopyWithImpl<$Res>
    implements _$FootnoteCopyWith<$Res> {
  __$FootnoteCopyWithImpl(this._self, this._then);

  final _Footnote _self;
  final $Res Function(_Footnote) _then;

/// Create a copy of Footnote
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? offset = null,Object? text = null,}) {
  return _then(_Footnote(
offset: null == offset ? _self.offset : offset // ignore: cast_nullable_to_non_nullable
as int,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
