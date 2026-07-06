// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'highlight_style.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HighlightStyle {

 ColorEnum get color; HighlightStyleType get type;
/// Create a copy of HighlightStyle
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HighlightStyleCopyWith<HighlightStyle> get copyWith => _$HighlightStyleCopyWithImpl<HighlightStyle>(this as HighlightStyle, _$identity);

  /// Serializes this HighlightStyle to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HighlightStyle&&(identical(other.color, color) || other.color == color)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,color,type);

@override
String toString() {
  return 'HighlightStyle(color: $color, type: $type)';
}


}

/// @nodoc
abstract mixin class $HighlightStyleCopyWith<$Res>  {
  factory $HighlightStyleCopyWith(HighlightStyle value, $Res Function(HighlightStyle) _then) = _$HighlightStyleCopyWithImpl;
@useResult
$Res call({
 ColorEnum color, HighlightStyleType type
});




}
/// @nodoc
class _$HighlightStyleCopyWithImpl<$Res>
    implements $HighlightStyleCopyWith<$Res> {
  _$HighlightStyleCopyWithImpl(this._self, this._then);

  final HighlightStyle _self;
  final $Res Function(HighlightStyle) _then;

/// Create a copy of HighlightStyle
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? color = null,Object? type = null,}) {
  return _then(_self.copyWith(
color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as ColorEnum,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as HighlightStyleType,
  ));
}

}


/// Adds pattern-matching-related methods to [HighlightStyle].
extension HighlightStylePatterns on HighlightStyle {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HighlightStyle value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HighlightStyle() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HighlightStyle value)  $default,){
final _that = this;
switch (_that) {
case _HighlightStyle():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HighlightStyle value)?  $default,){
final _that = this;
switch (_that) {
case _HighlightStyle() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ColorEnum color,  HighlightStyleType type)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HighlightStyle() when $default != null:
return $default(_that.color,_that.type);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ColorEnum color,  HighlightStyleType type)  $default,) {final _that = this;
switch (_that) {
case _HighlightStyle():
return $default(_that.color,_that.type);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ColorEnum color,  HighlightStyleType type)?  $default,) {final _that = this;
switch (_that) {
case _HighlightStyle() when $default != null:
return $default(_that.color,_that.type);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HighlightStyle extends HighlightStyle {
  const _HighlightStyle({required this.color, required this.type}): super._();
  factory _HighlightStyle.fromJson(Map<String, dynamic> json) => _$HighlightStyleFromJson(json);

@override final  ColorEnum color;
@override final  HighlightStyleType type;

/// Create a copy of HighlightStyle
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HighlightStyleCopyWith<_HighlightStyle> get copyWith => __$HighlightStyleCopyWithImpl<_HighlightStyle>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HighlightStyleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HighlightStyle&&(identical(other.color, color) || other.color == color)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,color,type);

@override
String toString() {
  return 'HighlightStyle(color: $color, type: $type)';
}


}

/// @nodoc
abstract mixin class _$HighlightStyleCopyWith<$Res> implements $HighlightStyleCopyWith<$Res> {
  factory _$HighlightStyleCopyWith(_HighlightStyle value, $Res Function(_HighlightStyle) _then) = __$HighlightStyleCopyWithImpl;
@override @useResult
$Res call({
 ColorEnum color, HighlightStyleType type
});




}
/// @nodoc
class __$HighlightStyleCopyWithImpl<$Res>
    implements _$HighlightStyleCopyWith<$Res> {
  __$HighlightStyleCopyWithImpl(this._self, this._then);

  final _HighlightStyle _self;
  final $Res Function(_HighlightStyle) _then;

/// Create a copy of HighlightStyle
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? color = null,Object? type = null,}) {
  return _then(_HighlightStyle(
color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as ColorEnum,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as HighlightStyleType,
  ));
}


}

// dart format on
