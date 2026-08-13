// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'audio_bible_configuration.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AudioBibleConfiguration {

 bool get isOpen; double get speed; DateTime? get endTime;
/// Create a copy of AudioBibleConfiguration
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AudioBibleConfigurationCopyWith<AudioBibleConfiguration> get copyWith => _$AudioBibleConfigurationCopyWithImpl<AudioBibleConfiguration>(this as AudioBibleConfiguration, _$identity);

  /// Serializes this AudioBibleConfiguration to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AudioBibleConfiguration&&(identical(other.isOpen, isOpen) || other.isOpen == isOpen)&&(identical(other.speed, speed) || other.speed == speed)&&(identical(other.endTime, endTime) || other.endTime == endTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isOpen,speed,endTime);

@override
String toString() {
  return 'AudioBibleConfiguration(isOpen: $isOpen, speed: $speed, endTime: $endTime)';
}


}

/// @nodoc
abstract mixin class $AudioBibleConfigurationCopyWith<$Res>  {
  factory $AudioBibleConfigurationCopyWith(AudioBibleConfiguration value, $Res Function(AudioBibleConfiguration) _then) = _$AudioBibleConfigurationCopyWithImpl;
@useResult
$Res call({
 bool isOpen, double speed, DateTime? endTime
});




}
/// @nodoc
class _$AudioBibleConfigurationCopyWithImpl<$Res>
    implements $AudioBibleConfigurationCopyWith<$Res> {
  _$AudioBibleConfigurationCopyWithImpl(this._self, this._then);

  final AudioBibleConfiguration _self;
  final $Res Function(AudioBibleConfiguration) _then;

/// Create a copy of AudioBibleConfiguration
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isOpen = null,Object? speed = null,Object? endTime = freezed,}) {
  return _then(AudioBibleConfiguration(
isOpen: null == isOpen ? _self.isOpen : isOpen // ignore: cast_nullable_to_non_nullable
as bool,speed: null == speed ? _self.speed : speed // ignore: cast_nullable_to_non_nullable
as double,endTime: freezed == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [AudioBibleConfiguration].
extension AudioBibleConfigurationPatterns on AudioBibleConfiguration {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AudioBibleConfiguration value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AudioBibleConfiguration() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AudioBibleConfiguration value)  $default,){
final _that = this;
switch (_that) {
case _AudioBibleConfiguration():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AudioBibleConfiguration value)?  $default,){
final _that = this;
switch (_that) {
case _AudioBibleConfiguration() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isOpen,  double speed,  DateTime? endTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AudioBibleConfiguration() when $default != null:
return $default(_that.isOpen,_that.speed,_that.endTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isOpen,  double speed,  DateTime? endTime)  $default,) {final _that = this;
switch (_that) {
case _AudioBibleConfiguration():
return $default(_that.isOpen,_that.speed,_that.endTime);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isOpen,  double speed,  DateTime? endTime)?  $default,) {final _that = this;
switch (_that) {
case _AudioBibleConfiguration() when $default != null:
return $default(_that.isOpen,_that.speed,_that.endTime);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AudioBibleConfiguration extends AudioBibleConfiguration {
  const _AudioBibleConfiguration({this.isOpen = false, this.speed = 1, this.endTime}): super._();
  factory _AudioBibleConfiguration.fromJson(Map<String, dynamic> json) => _$AudioBibleConfigurationFromJson(json);

@override@JsonKey() final  bool isOpen;
@override@JsonKey() final  double speed;
@override final  DateTime? endTime;

/// Create a copy of AudioBibleConfiguration
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AudioBibleConfigurationCopyWith<_AudioBibleConfiguration> get copyWith => __$AudioBibleConfigurationCopyWithImpl<_AudioBibleConfiguration>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AudioBibleConfigurationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AudioBibleConfiguration&&(identical(other.isOpen, isOpen) || other.isOpen == isOpen)&&(identical(other.speed, speed) || other.speed == speed)&&(identical(other.endTime, endTime) || other.endTime == endTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isOpen,speed,endTime);

@override
String toString() {
  return 'AudioBibleConfiguration(isOpen: $isOpen, speed: $speed, endTime: $endTime)';
}


}

/// @nodoc
abstract mixin class _$AudioBibleConfigurationCopyWith<$Res> implements $AudioBibleConfigurationCopyWith<$Res> {
  factory _$AudioBibleConfigurationCopyWith(_AudioBibleConfiguration value, $Res Function(_AudioBibleConfiguration) _then) = __$AudioBibleConfigurationCopyWithImpl;
@override @useResult
$Res call({
 bool isOpen, double speed, DateTime? endTime
});




}
/// @nodoc
class __$AudioBibleConfigurationCopyWithImpl<$Res>
    implements _$AudioBibleConfigurationCopyWith<$Res> {
  __$AudioBibleConfigurationCopyWithImpl(this._self, this._then);

  final _AudioBibleConfiguration _self;
  final $Res Function(_AudioBibleConfiguration) _then;

/// Create a copy of AudioBibleConfiguration
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isOpen = null,Object? speed = null,Object? endTime = freezed,}) {
  return _then(_AudioBibleConfiguration(
isOpen: null == isOpen ? _self.isOpen : isOpen // ignore: cast_nullable_to_non_nullable
as bool,speed: null == speed ? _self.speed : speed // ignore: cast_nullable_to_non_nullable
as double,endTime: freezed == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
