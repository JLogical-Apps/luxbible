// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'verse_selection_configuration.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VerseSelectionConfiguration {

 VerseSelectionShortcut get pinnedShortcut1; VerseSelectionShortcut get pinnedShortcut2; VerseSelectionShortcut get pinnedShortcut3; VerseSelectionShortcut get longPressShortcut; bool get expandToAnnotation; bool get rangeSelection;
/// Create a copy of VerseSelectionConfiguration
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VerseSelectionConfigurationCopyWith<VerseSelectionConfiguration> get copyWith => _$VerseSelectionConfigurationCopyWithImpl<VerseSelectionConfiguration>(this as VerseSelectionConfiguration, _$identity);

  /// Serializes this VerseSelectionConfiguration to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerseSelectionConfiguration&&(identical(other.pinnedShortcut1, pinnedShortcut1) || other.pinnedShortcut1 == pinnedShortcut1)&&(identical(other.pinnedShortcut2, pinnedShortcut2) || other.pinnedShortcut2 == pinnedShortcut2)&&(identical(other.pinnedShortcut3, pinnedShortcut3) || other.pinnedShortcut3 == pinnedShortcut3)&&(identical(other.longPressShortcut, longPressShortcut) || other.longPressShortcut == longPressShortcut)&&(identical(other.expandToAnnotation, expandToAnnotation) || other.expandToAnnotation == expandToAnnotation)&&(identical(other.rangeSelection, rangeSelection) || other.rangeSelection == rangeSelection));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pinnedShortcut1,pinnedShortcut2,pinnedShortcut3,longPressShortcut,expandToAnnotation,rangeSelection);

@override
String toString() {
  return 'VerseSelectionConfiguration(pinnedShortcut1: $pinnedShortcut1, pinnedShortcut2: $pinnedShortcut2, pinnedShortcut3: $pinnedShortcut3, longPressShortcut: $longPressShortcut, expandToAnnotation: $expandToAnnotation, rangeSelection: $rangeSelection)';
}


}

/// @nodoc
abstract mixin class $VerseSelectionConfigurationCopyWith<$Res>  {
  factory $VerseSelectionConfigurationCopyWith(VerseSelectionConfiguration value, $Res Function(VerseSelectionConfiguration) _then) = _$VerseSelectionConfigurationCopyWithImpl;
@useResult
$Res call({
 VerseSelectionShortcut pinnedShortcut1, VerseSelectionShortcut pinnedShortcut2, VerseSelectionShortcut pinnedShortcut3, VerseSelectionShortcut longPressShortcut, bool expandToAnnotation, bool rangeSelection
});




}
/// @nodoc
class _$VerseSelectionConfigurationCopyWithImpl<$Res>
    implements $VerseSelectionConfigurationCopyWith<$Res> {
  _$VerseSelectionConfigurationCopyWithImpl(this._self, this._then);

  final VerseSelectionConfiguration _self;
  final $Res Function(VerseSelectionConfiguration) _then;

/// Create a copy of VerseSelectionConfiguration
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pinnedShortcut1 = null,Object? pinnedShortcut2 = null,Object? pinnedShortcut3 = null,Object? longPressShortcut = null,Object? expandToAnnotation = null,Object? rangeSelection = null,}) {
  return _then(_self.copyWith(
pinnedShortcut1: null == pinnedShortcut1 ? _self.pinnedShortcut1 : pinnedShortcut1 // ignore: cast_nullable_to_non_nullable
as VerseSelectionShortcut,pinnedShortcut2: null == pinnedShortcut2 ? _self.pinnedShortcut2 : pinnedShortcut2 // ignore: cast_nullable_to_non_nullable
as VerseSelectionShortcut,pinnedShortcut3: null == pinnedShortcut3 ? _self.pinnedShortcut3 : pinnedShortcut3 // ignore: cast_nullable_to_non_nullable
as VerseSelectionShortcut,longPressShortcut: null == longPressShortcut ? _self.longPressShortcut : longPressShortcut // ignore: cast_nullable_to_non_nullable
as VerseSelectionShortcut,expandToAnnotation: null == expandToAnnotation ? _self.expandToAnnotation : expandToAnnotation // ignore: cast_nullable_to_non_nullable
as bool,rangeSelection: null == rangeSelection ? _self.rangeSelection : rangeSelection // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [VerseSelectionConfiguration].
extension VerseSelectionConfigurationPatterns on VerseSelectionConfiguration {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VerseSelectionConfiguration value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VerseSelectionConfiguration() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VerseSelectionConfiguration value)  $default,){
final _that = this;
switch (_that) {
case _VerseSelectionConfiguration():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VerseSelectionConfiguration value)?  $default,){
final _that = this;
switch (_that) {
case _VerseSelectionConfiguration() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( VerseSelectionShortcut pinnedShortcut1,  VerseSelectionShortcut pinnedShortcut2,  VerseSelectionShortcut pinnedShortcut3,  VerseSelectionShortcut longPressShortcut,  bool expandToAnnotation,  bool rangeSelection)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VerseSelectionConfiguration() when $default != null:
return $default(_that.pinnedShortcut1,_that.pinnedShortcut2,_that.pinnedShortcut3,_that.longPressShortcut,_that.expandToAnnotation,_that.rangeSelection);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( VerseSelectionShortcut pinnedShortcut1,  VerseSelectionShortcut pinnedShortcut2,  VerseSelectionShortcut pinnedShortcut3,  VerseSelectionShortcut longPressShortcut,  bool expandToAnnotation,  bool rangeSelection)  $default,) {final _that = this;
switch (_that) {
case _VerseSelectionConfiguration():
return $default(_that.pinnedShortcut1,_that.pinnedShortcut2,_that.pinnedShortcut3,_that.longPressShortcut,_that.expandToAnnotation,_that.rangeSelection);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( VerseSelectionShortcut pinnedShortcut1,  VerseSelectionShortcut pinnedShortcut2,  VerseSelectionShortcut pinnedShortcut3,  VerseSelectionShortcut longPressShortcut,  bool expandToAnnotation,  bool rangeSelection)?  $default,) {final _that = this;
switch (_that) {
case _VerseSelectionConfiguration() when $default != null:
return $default(_that.pinnedShortcut1,_that.pinnedShortcut2,_that.pinnedShortcut3,_that.longPressShortcut,_that.expandToAnnotation,_that.rangeSelection);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VerseSelectionConfiguration extends VerseSelectionConfiguration {
  const _VerseSelectionConfiguration({this.pinnedShortcut1 = VerseSelectionShortcut.annotate, this.pinnedShortcut2 = VerseSelectionShortcut.commentary, this.pinnedShortcut3 = VerseSelectionShortcut.interlinear, this.longPressShortcut = VerseSelectionShortcut.highlight, this.expandToAnnotation = false, this.rangeSelection = true}): super._();
  factory _VerseSelectionConfiguration.fromJson(Map<String, dynamic> json) => _$VerseSelectionConfigurationFromJson(json);

@override@JsonKey() final  VerseSelectionShortcut pinnedShortcut1;
@override@JsonKey() final  VerseSelectionShortcut pinnedShortcut2;
@override@JsonKey() final  VerseSelectionShortcut pinnedShortcut3;
@override@JsonKey() final  VerseSelectionShortcut longPressShortcut;
@override@JsonKey() final  bool expandToAnnotation;
@override@JsonKey() final  bool rangeSelection;

/// Create a copy of VerseSelectionConfiguration
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VerseSelectionConfigurationCopyWith<_VerseSelectionConfiguration> get copyWith => __$VerseSelectionConfigurationCopyWithImpl<_VerseSelectionConfiguration>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VerseSelectionConfigurationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VerseSelectionConfiguration&&(identical(other.pinnedShortcut1, pinnedShortcut1) || other.pinnedShortcut1 == pinnedShortcut1)&&(identical(other.pinnedShortcut2, pinnedShortcut2) || other.pinnedShortcut2 == pinnedShortcut2)&&(identical(other.pinnedShortcut3, pinnedShortcut3) || other.pinnedShortcut3 == pinnedShortcut3)&&(identical(other.longPressShortcut, longPressShortcut) || other.longPressShortcut == longPressShortcut)&&(identical(other.expandToAnnotation, expandToAnnotation) || other.expandToAnnotation == expandToAnnotation)&&(identical(other.rangeSelection, rangeSelection) || other.rangeSelection == rangeSelection));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pinnedShortcut1,pinnedShortcut2,pinnedShortcut3,longPressShortcut,expandToAnnotation,rangeSelection);

@override
String toString() {
  return 'VerseSelectionConfiguration(pinnedShortcut1: $pinnedShortcut1, pinnedShortcut2: $pinnedShortcut2, pinnedShortcut3: $pinnedShortcut3, longPressShortcut: $longPressShortcut, expandToAnnotation: $expandToAnnotation, rangeSelection: $rangeSelection)';
}


}

/// @nodoc
abstract mixin class _$VerseSelectionConfigurationCopyWith<$Res> implements $VerseSelectionConfigurationCopyWith<$Res> {
  factory _$VerseSelectionConfigurationCopyWith(_VerseSelectionConfiguration value, $Res Function(_VerseSelectionConfiguration) _then) = __$VerseSelectionConfigurationCopyWithImpl;
@override @useResult
$Res call({
 VerseSelectionShortcut pinnedShortcut1, VerseSelectionShortcut pinnedShortcut2, VerseSelectionShortcut pinnedShortcut3, VerseSelectionShortcut longPressShortcut, bool expandToAnnotation, bool rangeSelection
});




}
/// @nodoc
class __$VerseSelectionConfigurationCopyWithImpl<$Res>
    implements _$VerseSelectionConfigurationCopyWith<$Res> {
  __$VerseSelectionConfigurationCopyWithImpl(this._self, this._then);

  final _VerseSelectionConfiguration _self;
  final $Res Function(_VerseSelectionConfiguration) _then;

/// Create a copy of VerseSelectionConfiguration
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pinnedShortcut1 = null,Object? pinnedShortcut2 = null,Object? pinnedShortcut3 = null,Object? longPressShortcut = null,Object? expandToAnnotation = null,Object? rangeSelection = null,}) {
  return _then(_VerseSelectionConfiguration(
pinnedShortcut1: null == pinnedShortcut1 ? _self.pinnedShortcut1 : pinnedShortcut1 // ignore: cast_nullable_to_non_nullable
as VerseSelectionShortcut,pinnedShortcut2: null == pinnedShortcut2 ? _self.pinnedShortcut2 : pinnedShortcut2 // ignore: cast_nullable_to_non_nullable
as VerseSelectionShortcut,pinnedShortcut3: null == pinnedShortcut3 ? _self.pinnedShortcut3 : pinnedShortcut3 // ignore: cast_nullable_to_non_nullable
as VerseSelectionShortcut,longPressShortcut: null == longPressShortcut ? _self.longPressShortcut : longPressShortcut // ignore: cast_nullable_to_non_nullable
as VerseSelectionShortcut,expandToAnnotation: null == expandToAnnotation ? _self.expandToAnnotation : expandToAnnotation // ignore: cast_nullable_to_non_nullable
as bool,rangeSelection: null == rangeSelection ? _self.rangeSelection : rangeSelection // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
