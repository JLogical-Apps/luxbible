// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'passage_configuration.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PassageConfiguration {

 PassageShortcut get pinnedShortcut1; PassageShortcut get pinnedShortcut2; PassageShortcut get pinnedShortcut3;
/// Create a copy of PassageConfiguration
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PassageConfigurationCopyWith<PassageConfiguration> get copyWith => _$PassageConfigurationCopyWithImpl<PassageConfiguration>(this as PassageConfiguration, _$identity);

  /// Serializes this PassageConfiguration to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PassageConfiguration&&(identical(other.pinnedShortcut1, pinnedShortcut1) || other.pinnedShortcut1 == pinnedShortcut1)&&(identical(other.pinnedShortcut2, pinnedShortcut2) || other.pinnedShortcut2 == pinnedShortcut2)&&(identical(other.pinnedShortcut3, pinnedShortcut3) || other.pinnedShortcut3 == pinnedShortcut3));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pinnedShortcut1,pinnedShortcut2,pinnedShortcut3);

@override
String toString() {
  return 'PassageConfiguration(pinnedShortcut1: $pinnedShortcut1, pinnedShortcut2: $pinnedShortcut2, pinnedShortcut3: $pinnedShortcut3)';
}


}

/// @nodoc
abstract mixin class $PassageConfigurationCopyWith<$Res>  {
  factory $PassageConfigurationCopyWith(PassageConfiguration value, $Res Function(PassageConfiguration) _then) = _$PassageConfigurationCopyWithImpl;
@useResult
$Res call({
 PassageShortcut pinnedShortcut1, PassageShortcut pinnedShortcut2, PassageShortcut pinnedShortcut3
});




}
/// @nodoc
class _$PassageConfigurationCopyWithImpl<$Res>
    implements $PassageConfigurationCopyWith<$Res> {
  _$PassageConfigurationCopyWithImpl(this._self, this._then);

  final PassageConfiguration _self;
  final $Res Function(PassageConfiguration) _then;

/// Create a copy of PassageConfiguration
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pinnedShortcut1 = null,Object? pinnedShortcut2 = null,Object? pinnedShortcut3 = null,}) {
  return _then(_self.copyWith(
pinnedShortcut1: null == pinnedShortcut1 ? _self.pinnedShortcut1 : pinnedShortcut1 // ignore: cast_nullable_to_non_nullable
as PassageShortcut,pinnedShortcut2: null == pinnedShortcut2 ? _self.pinnedShortcut2 : pinnedShortcut2 // ignore: cast_nullable_to_non_nullable
as PassageShortcut,pinnedShortcut3: null == pinnedShortcut3 ? _self.pinnedShortcut3 : pinnedShortcut3 // ignore: cast_nullable_to_non_nullable
as PassageShortcut,
  ));
}

}


/// Adds pattern-matching-related methods to [PassageConfiguration].
extension PassageConfigurationPatterns on PassageConfiguration {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PassageConfiguration value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PassageConfiguration() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PassageConfiguration value)  $default,){
final _that = this;
switch (_that) {
case _PassageConfiguration():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PassageConfiguration value)?  $default,){
final _that = this;
switch (_that) {
case _PassageConfiguration() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PassageShortcut pinnedShortcut1,  PassageShortcut pinnedShortcut2,  PassageShortcut pinnedShortcut3)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PassageConfiguration() when $default != null:
return $default(_that.pinnedShortcut1,_that.pinnedShortcut2,_that.pinnedShortcut3);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PassageShortcut pinnedShortcut1,  PassageShortcut pinnedShortcut2,  PassageShortcut pinnedShortcut3)  $default,) {final _that = this;
switch (_that) {
case _PassageConfiguration():
return $default(_that.pinnedShortcut1,_that.pinnedShortcut2,_that.pinnedShortcut3);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PassageShortcut pinnedShortcut1,  PassageShortcut pinnedShortcut2,  PassageShortcut pinnedShortcut3)?  $default,) {final _that = this;
switch (_that) {
case _PassageConfiguration() when $default != null:
return $default(_that.pinnedShortcut1,_that.pinnedShortcut2,_that.pinnedShortcut3);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PassageConfiguration extends PassageConfiguration {
  const _PassageConfiguration({this.pinnedShortcut1 = PassageShortcut.annotate, this.pinnedShortcut2 = PassageShortcut.commentary, this.pinnedShortcut3 = PassageShortcut.interlinear}): super._();
  factory _PassageConfiguration.fromJson(Map<String, dynamic> json) => _$PassageConfigurationFromJson(json);

@override@JsonKey() final  PassageShortcut pinnedShortcut1;
@override@JsonKey() final  PassageShortcut pinnedShortcut2;
@override@JsonKey() final  PassageShortcut pinnedShortcut3;

/// Create a copy of PassageConfiguration
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PassageConfigurationCopyWith<_PassageConfiguration> get copyWith => __$PassageConfigurationCopyWithImpl<_PassageConfiguration>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PassageConfigurationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PassageConfiguration&&(identical(other.pinnedShortcut1, pinnedShortcut1) || other.pinnedShortcut1 == pinnedShortcut1)&&(identical(other.pinnedShortcut2, pinnedShortcut2) || other.pinnedShortcut2 == pinnedShortcut2)&&(identical(other.pinnedShortcut3, pinnedShortcut3) || other.pinnedShortcut3 == pinnedShortcut3));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pinnedShortcut1,pinnedShortcut2,pinnedShortcut3);

@override
String toString() {
  return 'PassageConfiguration(pinnedShortcut1: $pinnedShortcut1, pinnedShortcut2: $pinnedShortcut2, pinnedShortcut3: $pinnedShortcut3)';
}


}

/// @nodoc
abstract mixin class _$PassageConfigurationCopyWith<$Res> implements $PassageConfigurationCopyWith<$Res> {
  factory _$PassageConfigurationCopyWith(_PassageConfiguration value, $Res Function(_PassageConfiguration) _then) = __$PassageConfigurationCopyWithImpl;
@override @useResult
$Res call({
 PassageShortcut pinnedShortcut1, PassageShortcut pinnedShortcut2, PassageShortcut pinnedShortcut3
});




}
/// @nodoc
class __$PassageConfigurationCopyWithImpl<$Res>
    implements _$PassageConfigurationCopyWith<$Res> {
  __$PassageConfigurationCopyWithImpl(this._self, this._then);

  final _PassageConfiguration _self;
  final $Res Function(_PassageConfiguration) _then;

/// Create a copy of PassageConfiguration
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pinnedShortcut1 = null,Object? pinnedShortcut2 = null,Object? pinnedShortcut3 = null,}) {
  return _then(_PassageConfiguration(
pinnedShortcut1: null == pinnedShortcut1 ? _self.pinnedShortcut1 : pinnedShortcut1 // ignore: cast_nullable_to_non_nullable
as PassageShortcut,pinnedShortcut2: null == pinnedShortcut2 ? _self.pinnedShortcut2 : pinnedShortcut2 // ignore: cast_nullable_to_non_nullable
as PassageShortcut,pinnedShortcut3: null == pinnedShortcut3 ? _self.pinnedShortcut3 : pinnedShortcut3 // ignore: cast_nullable_to_non_nullable
as PassageShortcut,
  ));
}


}

// dart format on
