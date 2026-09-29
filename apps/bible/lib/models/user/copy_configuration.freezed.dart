// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'copy_configuration.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CopyConfiguration {

 bool get includesReference; bool get includesTranslation;
/// Create a copy of CopyConfiguration
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CopyConfigurationCopyWith<CopyConfiguration> get copyWith => _$CopyConfigurationCopyWithImpl<CopyConfiguration>(this as CopyConfiguration, _$identity);

  /// Serializes this CopyConfiguration to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CopyConfiguration&&(identical(other.includesReference, includesReference) || other.includesReference == includesReference)&&(identical(other.includesTranslation, includesTranslation) || other.includesTranslation == includesTranslation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,includesReference,includesTranslation);

@override
String toString() {
  return 'CopyConfiguration(includesReference: $includesReference, includesTranslation: $includesTranslation)';
}


}

/// @nodoc
abstract mixin class $CopyConfigurationCopyWith<$Res>  {
  factory $CopyConfigurationCopyWith(CopyConfiguration value, $Res Function(CopyConfiguration) _then) = _$CopyConfigurationCopyWithImpl;
@useResult
$Res call({
 bool includesReference, bool includesTranslation
});




}
/// @nodoc
class _$CopyConfigurationCopyWithImpl<$Res>
    implements $CopyConfigurationCopyWith<$Res> {
  _$CopyConfigurationCopyWithImpl(this._self, this._then);

  final CopyConfiguration _self;
  final $Res Function(CopyConfiguration) _then;

/// Create a copy of CopyConfiguration
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? includesReference = null,Object? includesTranslation = null,}) {
  return _then(CopyConfiguration(
includesReference: null == includesReference ? _self.includesReference : includesReference // ignore: cast_nullable_to_non_nullable
as bool,includesTranslation: null == includesTranslation ? _self.includesTranslation : includesTranslation // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CopyConfiguration].
extension CopyConfigurationPatterns on CopyConfiguration {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CopyConfiguration value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CopyConfiguration() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CopyConfiguration value)  $default,){
final _that = this;
switch (_that) {
case _CopyConfiguration():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CopyConfiguration value)?  $default,){
final _that = this;
switch (_that) {
case _CopyConfiguration() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool includesReference,  bool includesTranslation)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CopyConfiguration() when $default != null:
return $default(_that.includesReference,_that.includesTranslation);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool includesReference,  bool includesTranslation)  $default,) {final _that = this;
switch (_that) {
case _CopyConfiguration():
return $default(_that.includesReference,_that.includesTranslation);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool includesReference,  bool includesTranslation)?  $default,) {final _that = this;
switch (_that) {
case _CopyConfiguration() when $default != null:
return $default(_that.includesReference,_that.includesTranslation);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CopyConfiguration extends CopyConfiguration {
  const _CopyConfiguration({this.includesReference = false, this.includesTranslation = false}): super._();
  factory _CopyConfiguration.fromJson(Map<String, dynamic> json) => _$CopyConfigurationFromJson(json);

@override@JsonKey() final  bool includesReference;
@override@JsonKey() final  bool includesTranslation;

/// Create a copy of CopyConfiguration
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CopyConfigurationCopyWith<_CopyConfiguration> get copyWith => __$CopyConfigurationCopyWithImpl<_CopyConfiguration>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CopyConfigurationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CopyConfiguration&&(identical(other.includesReference, includesReference) || other.includesReference == includesReference)&&(identical(other.includesTranslation, includesTranslation) || other.includesTranslation == includesTranslation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,includesReference,includesTranslation);

@override
String toString() {
  return 'CopyConfiguration(includesReference: $includesReference, includesTranslation: $includesTranslation)';
}


}

/// @nodoc
abstract mixin class _$CopyConfigurationCopyWith<$Res> implements $CopyConfigurationCopyWith<$Res> {
  factory _$CopyConfigurationCopyWith(_CopyConfiguration value, $Res Function(_CopyConfiguration) _then) = __$CopyConfigurationCopyWithImpl;
@override @useResult
$Res call({
 bool includesReference, bool includesTranslation
});




}
/// @nodoc
class __$CopyConfigurationCopyWithImpl<$Res>
    implements _$CopyConfigurationCopyWith<$Res> {
  __$CopyConfigurationCopyWithImpl(this._self, this._then);

  final _CopyConfiguration _self;
  final $Res Function(_CopyConfiguration) _then;

/// Create a copy of CopyConfiguration
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? includesReference = null,Object? includesTranslation = null,}) {
  return _then(_CopyConfiguration(
includesReference: null == includesReference ? _self.includesReference : includesReference // ignore: cast_nullable_to_non_nullable
as bool,includesTranslation: null == includesTranslation ? _self.includesTranslation : includesTranslation // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
