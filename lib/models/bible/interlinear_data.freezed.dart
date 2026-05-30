// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'interlinear_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$InterlinearData {

@JsonKey(name: 'o') int get originalPosition;@JsonKey(name: 'i', includeIfNull: false) String? get inflection;@JsonKey(name: 's', includeIfNull: false) String? get strongId;@JsonKey(name: 'm', includeIfNull: false) String? get morphology;
/// Create a copy of InterlinearData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InterlinearDataCopyWith<InterlinearData> get copyWith => _$InterlinearDataCopyWithImpl<InterlinearData>(this as InterlinearData, _$identity);

  /// Serializes this InterlinearData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InterlinearData&&(identical(other.originalPosition, originalPosition) || other.originalPosition == originalPosition)&&(identical(other.inflection, inflection) || other.inflection == inflection)&&(identical(other.strongId, strongId) || other.strongId == strongId)&&(identical(other.morphology, morphology) || other.morphology == morphology));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,originalPosition,inflection,strongId,morphology);

@override
String toString() {
  return 'InterlinearData(originalPosition: $originalPosition, inflection: $inflection, strongId: $strongId, morphology: $morphology)';
}


}

/// @nodoc
abstract mixin class $InterlinearDataCopyWith<$Res>  {
  factory $InterlinearDataCopyWith(InterlinearData value, $Res Function(InterlinearData) _then) = _$InterlinearDataCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'o') int originalPosition,@JsonKey(name: 'i', includeIfNull: false) String? inflection,@JsonKey(name: 's', includeIfNull: false) String? strongId,@JsonKey(name: 'm', includeIfNull: false) String? morphology
});




}
/// @nodoc
class _$InterlinearDataCopyWithImpl<$Res>
    implements $InterlinearDataCopyWith<$Res> {
  _$InterlinearDataCopyWithImpl(this._self, this._then);

  final InterlinearData _self;
  final $Res Function(InterlinearData) _then;

/// Create a copy of InterlinearData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? originalPosition = null,Object? inflection = freezed,Object? strongId = freezed,Object? morphology = freezed,}) {
  return _then(_self.copyWith(
originalPosition: null == originalPosition ? _self.originalPosition : originalPosition // ignore: cast_nullable_to_non_nullable
as int,inflection: freezed == inflection ? _self.inflection : inflection // ignore: cast_nullable_to_non_nullable
as String?,strongId: freezed == strongId ? _self.strongId : strongId // ignore: cast_nullable_to_non_nullable
as String?,morphology: freezed == morphology ? _self.morphology : morphology // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [InterlinearData].
extension InterlinearDataPatterns on InterlinearData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InterlinearData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InterlinearData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InterlinearData value)  $default,){
final _that = this;
switch (_that) {
case _InterlinearData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InterlinearData value)?  $default,){
final _that = this;
switch (_that) {
case _InterlinearData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'o')  int originalPosition, @JsonKey(name: 'i', includeIfNull: false)  String? inflection, @JsonKey(name: 's', includeIfNull: false)  String? strongId, @JsonKey(name: 'm', includeIfNull: false)  String? morphology)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InterlinearData() when $default != null:
return $default(_that.originalPosition,_that.inflection,_that.strongId,_that.morphology);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'o')  int originalPosition, @JsonKey(name: 'i', includeIfNull: false)  String? inflection, @JsonKey(name: 's', includeIfNull: false)  String? strongId, @JsonKey(name: 'm', includeIfNull: false)  String? morphology)  $default,) {final _that = this;
switch (_that) {
case _InterlinearData():
return $default(_that.originalPosition,_that.inflection,_that.strongId,_that.morphology);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'o')  int originalPosition, @JsonKey(name: 'i', includeIfNull: false)  String? inflection, @JsonKey(name: 's', includeIfNull: false)  String? strongId, @JsonKey(name: 'm', includeIfNull: false)  String? morphology)?  $default,) {final _that = this;
switch (_that) {
case _InterlinearData() when $default != null:
return $default(_that.originalPosition,_that.inflection,_that.strongId,_that.morphology);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InterlinearData implements InterlinearData {
  const _InterlinearData({@JsonKey(name: 'o') required this.originalPosition, @JsonKey(name: 'i', includeIfNull: false) required this.inflection, @JsonKey(name: 's', includeIfNull: false) this.strongId, @JsonKey(name: 'm', includeIfNull: false) this.morphology});
  factory _InterlinearData.fromJson(Map<String, dynamic> json) => _$InterlinearDataFromJson(json);

@override@JsonKey(name: 'o') final  int originalPosition;
@override@JsonKey(name: 'i', includeIfNull: false) final  String? inflection;
@override@JsonKey(name: 's', includeIfNull: false) final  String? strongId;
@override@JsonKey(name: 'm', includeIfNull: false) final  String? morphology;

/// Create a copy of InterlinearData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InterlinearDataCopyWith<_InterlinearData> get copyWith => __$InterlinearDataCopyWithImpl<_InterlinearData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InterlinearDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InterlinearData&&(identical(other.originalPosition, originalPosition) || other.originalPosition == originalPosition)&&(identical(other.inflection, inflection) || other.inflection == inflection)&&(identical(other.strongId, strongId) || other.strongId == strongId)&&(identical(other.morphology, morphology) || other.morphology == morphology));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,originalPosition,inflection,strongId,morphology);

@override
String toString() {
  return 'InterlinearData(originalPosition: $originalPosition, inflection: $inflection, strongId: $strongId, morphology: $morphology)';
}


}

/// @nodoc
abstract mixin class _$InterlinearDataCopyWith<$Res> implements $InterlinearDataCopyWith<$Res> {
  factory _$InterlinearDataCopyWith(_InterlinearData value, $Res Function(_InterlinearData) _then) = __$InterlinearDataCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'o') int originalPosition,@JsonKey(name: 'i', includeIfNull: false) String? inflection,@JsonKey(name: 's', includeIfNull: false) String? strongId,@JsonKey(name: 'm', includeIfNull: false) String? morphology
});




}
/// @nodoc
class __$InterlinearDataCopyWithImpl<$Res>
    implements _$InterlinearDataCopyWith<$Res> {
  __$InterlinearDataCopyWithImpl(this._self, this._then);

  final _InterlinearData _self;
  final $Res Function(_InterlinearData) _then;

/// Create a copy of InterlinearData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? originalPosition = null,Object? inflection = freezed,Object? strongId = freezed,Object? morphology = freezed,}) {
  return _then(_InterlinearData(
originalPosition: null == originalPosition ? _self.originalPosition : originalPosition // ignore: cast_nullable_to_non_nullable
as int,inflection: freezed == inflection ? _self.inflection : inflection // ignore: cast_nullable_to_non_nullable
as String?,strongId: freezed == strongId ? _self.strongId : strongId // ignore: cast_nullable_to_non_nullable
as String?,morphology: freezed == morphology ? _self.morphology : morphology // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
