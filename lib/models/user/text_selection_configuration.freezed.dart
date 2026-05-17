// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'text_selection_configuration.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TextSelectionConfiguration {

 TextSelectionShortcut get pinnedShortcut1; TextSelectionShortcut get pinnedShortcut2; TextSelectionShortcut get pinnedShortcut3; bool get expandToAnnotation;
/// Create a copy of TextSelectionConfiguration
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TextSelectionConfigurationCopyWith<TextSelectionConfiguration> get copyWith => _$TextSelectionConfigurationCopyWithImpl<TextSelectionConfiguration>(this as TextSelectionConfiguration, _$identity);

  /// Serializes this TextSelectionConfiguration to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TextSelectionConfiguration&&(identical(other.pinnedShortcut1, pinnedShortcut1) || other.pinnedShortcut1 == pinnedShortcut1)&&(identical(other.pinnedShortcut2, pinnedShortcut2) || other.pinnedShortcut2 == pinnedShortcut2)&&(identical(other.pinnedShortcut3, pinnedShortcut3) || other.pinnedShortcut3 == pinnedShortcut3)&&(identical(other.expandToAnnotation, expandToAnnotation) || other.expandToAnnotation == expandToAnnotation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pinnedShortcut1,pinnedShortcut2,pinnedShortcut3,expandToAnnotation);

@override
String toString() {
  return 'TextSelectionConfiguration(pinnedShortcut1: $pinnedShortcut1, pinnedShortcut2: $pinnedShortcut2, pinnedShortcut3: $pinnedShortcut3, expandToAnnotation: $expandToAnnotation)';
}


}

/// @nodoc
abstract mixin class $TextSelectionConfigurationCopyWith<$Res>  {
  factory $TextSelectionConfigurationCopyWith(TextSelectionConfiguration value, $Res Function(TextSelectionConfiguration) _then) = _$TextSelectionConfigurationCopyWithImpl;
@useResult
$Res call({
 TextSelectionShortcut pinnedShortcut1, TextSelectionShortcut pinnedShortcut2, TextSelectionShortcut pinnedShortcut3, bool expandToAnnotation
});




}
/// @nodoc
class _$TextSelectionConfigurationCopyWithImpl<$Res>
    implements $TextSelectionConfigurationCopyWith<$Res> {
  _$TextSelectionConfigurationCopyWithImpl(this._self, this._then);

  final TextSelectionConfiguration _self;
  final $Res Function(TextSelectionConfiguration) _then;

/// Create a copy of TextSelectionConfiguration
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pinnedShortcut1 = null,Object? pinnedShortcut2 = null,Object? pinnedShortcut3 = null,Object? expandToAnnotation = null,}) {
  return _then(_self.copyWith(
pinnedShortcut1: null == pinnedShortcut1 ? _self.pinnedShortcut1 : pinnedShortcut1 // ignore: cast_nullable_to_non_nullable
as TextSelectionShortcut,pinnedShortcut2: null == pinnedShortcut2 ? _self.pinnedShortcut2 : pinnedShortcut2 // ignore: cast_nullable_to_non_nullable
as TextSelectionShortcut,pinnedShortcut3: null == pinnedShortcut3 ? _self.pinnedShortcut3 : pinnedShortcut3 // ignore: cast_nullable_to_non_nullable
as TextSelectionShortcut,expandToAnnotation: null == expandToAnnotation ? _self.expandToAnnotation : expandToAnnotation // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [TextSelectionConfiguration].
extension TextSelectionConfigurationPatterns on TextSelectionConfiguration {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TextSelectionConfiguration value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TextSelectionConfiguration() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TextSelectionConfiguration value)  $default,){
final _that = this;
switch (_that) {
case _TextSelectionConfiguration():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TextSelectionConfiguration value)?  $default,){
final _that = this;
switch (_that) {
case _TextSelectionConfiguration() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TextSelectionShortcut pinnedShortcut1,  TextSelectionShortcut pinnedShortcut2,  TextSelectionShortcut pinnedShortcut3,  bool expandToAnnotation)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TextSelectionConfiguration() when $default != null:
return $default(_that.pinnedShortcut1,_that.pinnedShortcut2,_that.pinnedShortcut3,_that.expandToAnnotation);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TextSelectionShortcut pinnedShortcut1,  TextSelectionShortcut pinnedShortcut2,  TextSelectionShortcut pinnedShortcut3,  bool expandToAnnotation)  $default,) {final _that = this;
switch (_that) {
case _TextSelectionConfiguration():
return $default(_that.pinnedShortcut1,_that.pinnedShortcut2,_that.pinnedShortcut3,_that.expandToAnnotation);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TextSelectionShortcut pinnedShortcut1,  TextSelectionShortcut pinnedShortcut2,  TextSelectionShortcut pinnedShortcut3,  bool expandToAnnotation)?  $default,) {final _that = this;
switch (_that) {
case _TextSelectionConfiguration() when $default != null:
return $default(_that.pinnedShortcut1,_that.pinnedShortcut2,_that.pinnedShortcut3,_that.expandToAnnotation);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TextSelectionConfiguration extends TextSelectionConfiguration {
  const _TextSelectionConfiguration({this.pinnedShortcut1 = TextSelectionShortcut.annotate, this.pinnedShortcut2 = TextSelectionShortcut.search, this.pinnedShortcut3 = TextSelectionShortcut.copy, this.expandToAnnotation = false}): super._();
  factory _TextSelectionConfiguration.fromJson(Map<String, dynamic> json) => _$TextSelectionConfigurationFromJson(json);

@override@JsonKey() final  TextSelectionShortcut pinnedShortcut1;
@override@JsonKey() final  TextSelectionShortcut pinnedShortcut2;
@override@JsonKey() final  TextSelectionShortcut pinnedShortcut3;
@override@JsonKey() final  bool expandToAnnotation;

/// Create a copy of TextSelectionConfiguration
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TextSelectionConfigurationCopyWith<_TextSelectionConfiguration> get copyWith => __$TextSelectionConfigurationCopyWithImpl<_TextSelectionConfiguration>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TextSelectionConfigurationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TextSelectionConfiguration&&(identical(other.pinnedShortcut1, pinnedShortcut1) || other.pinnedShortcut1 == pinnedShortcut1)&&(identical(other.pinnedShortcut2, pinnedShortcut2) || other.pinnedShortcut2 == pinnedShortcut2)&&(identical(other.pinnedShortcut3, pinnedShortcut3) || other.pinnedShortcut3 == pinnedShortcut3)&&(identical(other.expandToAnnotation, expandToAnnotation) || other.expandToAnnotation == expandToAnnotation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pinnedShortcut1,pinnedShortcut2,pinnedShortcut3,expandToAnnotation);

@override
String toString() {
  return 'TextSelectionConfiguration(pinnedShortcut1: $pinnedShortcut1, pinnedShortcut2: $pinnedShortcut2, pinnedShortcut3: $pinnedShortcut3, expandToAnnotation: $expandToAnnotation)';
}


}

/// @nodoc
abstract mixin class _$TextSelectionConfigurationCopyWith<$Res> implements $TextSelectionConfigurationCopyWith<$Res> {
  factory _$TextSelectionConfigurationCopyWith(_TextSelectionConfiguration value, $Res Function(_TextSelectionConfiguration) _then) = __$TextSelectionConfigurationCopyWithImpl;
@override @useResult
$Res call({
 TextSelectionShortcut pinnedShortcut1, TextSelectionShortcut pinnedShortcut2, TextSelectionShortcut pinnedShortcut3, bool expandToAnnotation
});




}
/// @nodoc
class __$TextSelectionConfigurationCopyWithImpl<$Res>
    implements _$TextSelectionConfigurationCopyWith<$Res> {
  __$TextSelectionConfigurationCopyWithImpl(this._self, this._then);

  final _TextSelectionConfiguration _self;
  final $Res Function(_TextSelectionConfiguration) _then;

/// Create a copy of TextSelectionConfiguration
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pinnedShortcut1 = null,Object? pinnedShortcut2 = null,Object? pinnedShortcut3 = null,Object? expandToAnnotation = null,}) {
  return _then(_TextSelectionConfiguration(
pinnedShortcut1: null == pinnedShortcut1 ? _self.pinnedShortcut1 : pinnedShortcut1 // ignore: cast_nullable_to_non_nullable
as TextSelectionShortcut,pinnedShortcut2: null == pinnedShortcut2 ? _self.pinnedShortcut2 : pinnedShortcut2 // ignore: cast_nullable_to_non_nullable
as TextSelectionShortcut,pinnedShortcut3: null == pinnedShortcut3 ? _self.pinnedShortcut3 : pinnedShortcut3 // ignore: cast_nullable_to_non_nullable
as TextSelectionShortcut,expandToAnnotation: null == expandToAnnotation ? _self.expandToAnnotation : expandToAnnotation // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
