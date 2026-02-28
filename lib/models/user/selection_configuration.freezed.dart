// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'selection_configuration.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SelectionConfiguration {

 SelectionShortcut get pinnedShortcut1; SelectionShortcut get pinnedShortcut2; SelectionShortcut get pinnedShortcut3;
/// Create a copy of SelectionConfiguration
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SelectionConfigurationCopyWith<SelectionConfiguration> get copyWith => _$SelectionConfigurationCopyWithImpl<SelectionConfiguration>(this as SelectionConfiguration, _$identity);

  /// Serializes this SelectionConfiguration to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SelectionConfiguration&&(identical(other.pinnedShortcut1, pinnedShortcut1) || other.pinnedShortcut1 == pinnedShortcut1)&&(identical(other.pinnedShortcut2, pinnedShortcut2) || other.pinnedShortcut2 == pinnedShortcut2)&&(identical(other.pinnedShortcut3, pinnedShortcut3) || other.pinnedShortcut3 == pinnedShortcut3));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pinnedShortcut1,pinnedShortcut2,pinnedShortcut3);

@override
String toString() {
  return 'SelectionConfiguration(pinnedShortcut1: $pinnedShortcut1, pinnedShortcut2: $pinnedShortcut2, pinnedShortcut3: $pinnedShortcut3)';
}


}

/// @nodoc
abstract mixin class $SelectionConfigurationCopyWith<$Res>  {
  factory $SelectionConfigurationCopyWith(SelectionConfiguration value, $Res Function(SelectionConfiguration) _then) = _$SelectionConfigurationCopyWithImpl;
@useResult
$Res call({
 SelectionShortcut pinnedShortcut1, SelectionShortcut pinnedShortcut2, SelectionShortcut pinnedShortcut3
});




}
/// @nodoc
class _$SelectionConfigurationCopyWithImpl<$Res>
    implements $SelectionConfigurationCopyWith<$Res> {
  _$SelectionConfigurationCopyWithImpl(this._self, this._then);

  final SelectionConfiguration _self;
  final $Res Function(SelectionConfiguration) _then;

/// Create a copy of SelectionConfiguration
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pinnedShortcut1 = null,Object? pinnedShortcut2 = null,Object? pinnedShortcut3 = null,}) {
  return _then(_self.copyWith(
pinnedShortcut1: null == pinnedShortcut1 ? _self.pinnedShortcut1 : pinnedShortcut1 // ignore: cast_nullable_to_non_nullable
as SelectionShortcut,pinnedShortcut2: null == pinnedShortcut2 ? _self.pinnedShortcut2 : pinnedShortcut2 // ignore: cast_nullable_to_non_nullable
as SelectionShortcut,pinnedShortcut3: null == pinnedShortcut3 ? _self.pinnedShortcut3 : pinnedShortcut3 // ignore: cast_nullable_to_non_nullable
as SelectionShortcut,
  ));
}

}


/// Adds pattern-matching-related methods to [SelectionConfiguration].
extension SelectionConfigurationPatterns on SelectionConfiguration {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SelectionConfiguration value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SelectionConfiguration() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SelectionConfiguration value)  $default,){
final _that = this;
switch (_that) {
case _SelectionConfiguration():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SelectionConfiguration value)?  $default,){
final _that = this;
switch (_that) {
case _SelectionConfiguration() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SelectionShortcut pinnedShortcut1,  SelectionShortcut pinnedShortcut2,  SelectionShortcut pinnedShortcut3)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SelectionConfiguration() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SelectionShortcut pinnedShortcut1,  SelectionShortcut pinnedShortcut2,  SelectionShortcut pinnedShortcut3)  $default,) {final _that = this;
switch (_that) {
case _SelectionConfiguration():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SelectionShortcut pinnedShortcut1,  SelectionShortcut pinnedShortcut2,  SelectionShortcut pinnedShortcut3)?  $default,) {final _that = this;
switch (_that) {
case _SelectionConfiguration() when $default != null:
return $default(_that.pinnedShortcut1,_that.pinnedShortcut2,_that.pinnedShortcut3);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SelectionConfiguration extends SelectionConfiguration {
  const _SelectionConfiguration({this.pinnedShortcut1 = SelectionShortcut.annotate, this.pinnedShortcut2 = SelectionShortcut.highlight, this.pinnedShortcut3 = SelectionShortcut.copy}): super._();
  factory _SelectionConfiguration.fromJson(Map<String, dynamic> json) => _$SelectionConfigurationFromJson(json);

@override@JsonKey() final  SelectionShortcut pinnedShortcut1;
@override@JsonKey() final  SelectionShortcut pinnedShortcut2;
@override@JsonKey() final  SelectionShortcut pinnedShortcut3;

/// Create a copy of SelectionConfiguration
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SelectionConfigurationCopyWith<_SelectionConfiguration> get copyWith => __$SelectionConfigurationCopyWithImpl<_SelectionConfiguration>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SelectionConfigurationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SelectionConfiguration&&(identical(other.pinnedShortcut1, pinnedShortcut1) || other.pinnedShortcut1 == pinnedShortcut1)&&(identical(other.pinnedShortcut2, pinnedShortcut2) || other.pinnedShortcut2 == pinnedShortcut2)&&(identical(other.pinnedShortcut3, pinnedShortcut3) || other.pinnedShortcut3 == pinnedShortcut3));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pinnedShortcut1,pinnedShortcut2,pinnedShortcut3);

@override
String toString() {
  return 'SelectionConfiguration(pinnedShortcut1: $pinnedShortcut1, pinnedShortcut2: $pinnedShortcut2, pinnedShortcut3: $pinnedShortcut3)';
}


}

/// @nodoc
abstract mixin class _$SelectionConfigurationCopyWith<$Res> implements $SelectionConfigurationCopyWith<$Res> {
  factory _$SelectionConfigurationCopyWith(_SelectionConfiguration value, $Res Function(_SelectionConfiguration) _then) = __$SelectionConfigurationCopyWithImpl;
@override @useResult
$Res call({
 SelectionShortcut pinnedShortcut1, SelectionShortcut pinnedShortcut2, SelectionShortcut pinnedShortcut3
});




}
/// @nodoc
class __$SelectionConfigurationCopyWithImpl<$Res>
    implements _$SelectionConfigurationCopyWith<$Res> {
  __$SelectionConfigurationCopyWithImpl(this._self, this._then);

  final _SelectionConfiguration _self;
  final $Res Function(_SelectionConfiguration) _then;

/// Create a copy of SelectionConfiguration
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pinnedShortcut1 = null,Object? pinnedShortcut2 = null,Object? pinnedShortcut3 = null,}) {
  return _then(_SelectionConfiguration(
pinnedShortcut1: null == pinnedShortcut1 ? _self.pinnedShortcut1 : pinnedShortcut1 // ignore: cast_nullable_to_non_nullable
as SelectionShortcut,pinnedShortcut2: null == pinnedShortcut2 ? _self.pinnedShortcut2 : pinnedShortcut2 // ignore: cast_nullable_to_non_nullable
as SelectionShortcut,pinnedShortcut3: null == pinnedShortcut3 ? _self.pinnedShortcut3 : pinnedShortcut3 // ignore: cast_nullable_to_non_nullable
as SelectionShortcut,
  ));
}


}

// dart format on
