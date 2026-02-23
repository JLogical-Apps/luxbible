// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'toolbar_configuration.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ToolbarConfiguration {

 ToolbarShortcut get pinnedShortcut1; ToolbarShortcut get pinnedShortcut2;
/// Create a copy of ToolbarConfiguration
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ToolbarConfigurationCopyWith<ToolbarConfiguration> get copyWith => _$ToolbarConfigurationCopyWithImpl<ToolbarConfiguration>(this as ToolbarConfiguration, _$identity);

  /// Serializes this ToolbarConfiguration to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ToolbarConfiguration&&(identical(other.pinnedShortcut1, pinnedShortcut1) || other.pinnedShortcut1 == pinnedShortcut1)&&(identical(other.pinnedShortcut2, pinnedShortcut2) || other.pinnedShortcut2 == pinnedShortcut2));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pinnedShortcut1,pinnedShortcut2);

@override
String toString() {
  return 'ToolbarConfiguration(pinnedShortcut1: $pinnedShortcut1, pinnedShortcut2: $pinnedShortcut2)';
}


}

/// @nodoc
abstract mixin class $ToolbarConfigurationCopyWith<$Res>  {
  factory $ToolbarConfigurationCopyWith(ToolbarConfiguration value, $Res Function(ToolbarConfiguration) _then) = _$ToolbarConfigurationCopyWithImpl;
@useResult
$Res call({
 ToolbarShortcut pinnedShortcut1, ToolbarShortcut pinnedShortcut2
});




}
/// @nodoc
class _$ToolbarConfigurationCopyWithImpl<$Res>
    implements $ToolbarConfigurationCopyWith<$Res> {
  _$ToolbarConfigurationCopyWithImpl(this._self, this._then);

  final ToolbarConfiguration _self;
  final $Res Function(ToolbarConfiguration) _then;

/// Create a copy of ToolbarConfiguration
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pinnedShortcut1 = null,Object? pinnedShortcut2 = null,}) {
  return _then(_self.copyWith(
pinnedShortcut1: null == pinnedShortcut1 ? _self.pinnedShortcut1 : pinnedShortcut1 // ignore: cast_nullable_to_non_nullable
as ToolbarShortcut,pinnedShortcut2: null == pinnedShortcut2 ? _self.pinnedShortcut2 : pinnedShortcut2 // ignore: cast_nullable_to_non_nullable
as ToolbarShortcut,
  ));
}

}


/// Adds pattern-matching-related methods to [ToolbarConfiguration].
extension ToolbarConfigurationPatterns on ToolbarConfiguration {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ToolbarConfiguration value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ToolbarConfiguration() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ToolbarConfiguration value)  $default,){
final _that = this;
switch (_that) {
case _ToolbarConfiguration():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ToolbarConfiguration value)?  $default,){
final _that = this;
switch (_that) {
case _ToolbarConfiguration() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ToolbarShortcut pinnedShortcut1,  ToolbarShortcut pinnedShortcut2)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ToolbarConfiguration() when $default != null:
return $default(_that.pinnedShortcut1,_that.pinnedShortcut2);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ToolbarShortcut pinnedShortcut1,  ToolbarShortcut pinnedShortcut2)  $default,) {final _that = this;
switch (_that) {
case _ToolbarConfiguration():
return $default(_that.pinnedShortcut1,_that.pinnedShortcut2);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ToolbarShortcut pinnedShortcut1,  ToolbarShortcut pinnedShortcut2)?  $default,) {final _that = this;
switch (_that) {
case _ToolbarConfiguration() when $default != null:
return $default(_that.pinnedShortcut1,_that.pinnedShortcut2);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ToolbarConfiguration extends ToolbarConfiguration {
  const _ToolbarConfiguration({this.pinnedShortcut1 = ToolbarShortcut.bookmark, this.pinnedShortcut2 = ToolbarShortcut.interlinear}): super._();
  factory _ToolbarConfiguration.fromJson(Map<String, dynamic> json) => _$ToolbarConfigurationFromJson(json);

@override@JsonKey() final  ToolbarShortcut pinnedShortcut1;
@override@JsonKey() final  ToolbarShortcut pinnedShortcut2;

/// Create a copy of ToolbarConfiguration
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ToolbarConfigurationCopyWith<_ToolbarConfiguration> get copyWith => __$ToolbarConfigurationCopyWithImpl<_ToolbarConfiguration>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ToolbarConfigurationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ToolbarConfiguration&&(identical(other.pinnedShortcut1, pinnedShortcut1) || other.pinnedShortcut1 == pinnedShortcut1)&&(identical(other.pinnedShortcut2, pinnedShortcut2) || other.pinnedShortcut2 == pinnedShortcut2));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pinnedShortcut1,pinnedShortcut2);

@override
String toString() {
  return 'ToolbarConfiguration(pinnedShortcut1: $pinnedShortcut1, pinnedShortcut2: $pinnedShortcut2)';
}


}

/// @nodoc
abstract mixin class _$ToolbarConfigurationCopyWith<$Res> implements $ToolbarConfigurationCopyWith<$Res> {
  factory _$ToolbarConfigurationCopyWith(_ToolbarConfiguration value, $Res Function(_ToolbarConfiguration) _then) = __$ToolbarConfigurationCopyWithImpl;
@override @useResult
$Res call({
 ToolbarShortcut pinnedShortcut1, ToolbarShortcut pinnedShortcut2
});




}
/// @nodoc
class __$ToolbarConfigurationCopyWithImpl<$Res>
    implements _$ToolbarConfigurationCopyWith<$Res> {
  __$ToolbarConfigurationCopyWithImpl(this._self, this._then);

  final _ToolbarConfiguration _self;
  final $Res Function(_ToolbarConfiguration) _then;

/// Create a copy of ToolbarConfiguration
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pinnedShortcut1 = null,Object? pinnedShortcut2 = null,}) {
  return _then(_ToolbarConfiguration(
pinnedShortcut1: null == pinnedShortcut1 ? _self.pinnedShortcut1 : pinnedShortcut1 // ignore: cast_nullable_to_non_nullable
as ToolbarShortcut,pinnedShortcut2: null == pinnedShortcut2 ? _self.pinnedShortcut2 : pinnedShortcut2 // ignore: cast_nullable_to_non_nullable
as ToolbarShortcut,
  ));
}


}

// dart format on
