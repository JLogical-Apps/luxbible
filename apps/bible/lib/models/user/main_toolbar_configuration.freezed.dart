// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'main_toolbar_configuration.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MainToolbarConfiguration {

 MainToolbarShortcut get pinnedShortcut1; MainToolbarShortcut get pinnedShortcut2; MainToolbarShortcut get longPressShortcut; bool get pinToBottom;
/// Create a copy of MainToolbarConfiguration
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MainToolbarConfigurationCopyWith<MainToolbarConfiguration> get copyWith => _$MainToolbarConfigurationCopyWithImpl<MainToolbarConfiguration>(this as MainToolbarConfiguration, _$identity);

  /// Serializes this MainToolbarConfiguration to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MainToolbarConfiguration&&(identical(other.pinnedShortcut1, pinnedShortcut1) || other.pinnedShortcut1 == pinnedShortcut1)&&(identical(other.pinnedShortcut2, pinnedShortcut2) || other.pinnedShortcut2 == pinnedShortcut2)&&(identical(other.longPressShortcut, longPressShortcut) || other.longPressShortcut == longPressShortcut)&&(identical(other.pinToBottom, pinToBottom) || other.pinToBottom == pinToBottom));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pinnedShortcut1,pinnedShortcut2,longPressShortcut,pinToBottom);

@override
String toString() {
  return 'MainToolbarConfiguration(pinnedShortcut1: $pinnedShortcut1, pinnedShortcut2: $pinnedShortcut2, longPressShortcut: $longPressShortcut, pinToBottom: $pinToBottom)';
}


}

/// @nodoc
abstract mixin class $MainToolbarConfigurationCopyWith<$Res>  {
  factory $MainToolbarConfigurationCopyWith(MainToolbarConfiguration value, $Res Function(MainToolbarConfiguration) _then) = _$MainToolbarConfigurationCopyWithImpl;
@useResult
$Res call({
 MainToolbarShortcut pinnedShortcut1, MainToolbarShortcut pinnedShortcut2, MainToolbarShortcut longPressShortcut, bool pinToBottom
});




}
/// @nodoc
class _$MainToolbarConfigurationCopyWithImpl<$Res>
    implements $MainToolbarConfigurationCopyWith<$Res> {
  _$MainToolbarConfigurationCopyWithImpl(this._self, this._then);

  final MainToolbarConfiguration _self;
  final $Res Function(MainToolbarConfiguration) _then;

/// Create a copy of MainToolbarConfiguration
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pinnedShortcut1 = null,Object? pinnedShortcut2 = null,Object? longPressShortcut = null,Object? pinToBottom = null,}) {
  return _then(MainToolbarConfiguration(
pinnedShortcut1: null == pinnedShortcut1 ? _self.pinnedShortcut1 : pinnedShortcut1 // ignore: cast_nullable_to_non_nullable
as MainToolbarShortcut,pinnedShortcut2: null == pinnedShortcut2 ? _self.pinnedShortcut2 : pinnedShortcut2 // ignore: cast_nullable_to_non_nullable
as MainToolbarShortcut,longPressShortcut: null == longPressShortcut ? _self.longPressShortcut : longPressShortcut // ignore: cast_nullable_to_non_nullable
as MainToolbarShortcut,pinToBottom: null == pinToBottom ? _self.pinToBottom : pinToBottom // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [MainToolbarConfiguration].
extension MainToolbarConfigurationPatterns on MainToolbarConfiguration {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MainToolbarConfiguration value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MainToolbarConfiguration() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MainToolbarConfiguration value)  $default,){
final _that = this;
switch (_that) {
case _MainToolbarConfiguration():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MainToolbarConfiguration value)?  $default,){
final _that = this;
switch (_that) {
case _MainToolbarConfiguration() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( MainToolbarShortcut pinnedShortcut1,  MainToolbarShortcut pinnedShortcut2,  MainToolbarShortcut longPressShortcut,  bool pinToBottom)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MainToolbarConfiguration() when $default != null:
return $default(_that.pinnedShortcut1,_that.pinnedShortcut2,_that.longPressShortcut,_that.pinToBottom);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( MainToolbarShortcut pinnedShortcut1,  MainToolbarShortcut pinnedShortcut2,  MainToolbarShortcut longPressShortcut,  bool pinToBottom)  $default,) {final _that = this;
switch (_that) {
case _MainToolbarConfiguration():
return $default(_that.pinnedShortcut1,_that.pinnedShortcut2,_that.longPressShortcut,_that.pinToBottom);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( MainToolbarShortcut pinnedShortcut1,  MainToolbarShortcut pinnedShortcut2,  MainToolbarShortcut longPressShortcut,  bool pinToBottom)?  $default,) {final _that = this;
switch (_that) {
case _MainToolbarConfiguration() when $default != null:
return $default(_that.pinnedShortcut1,_that.pinnedShortcut2,_that.longPressShortcut,_that.pinToBottom);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MainToolbarConfiguration extends MainToolbarConfiguration {
  const _MainToolbarConfiguration({this.pinnedShortcut1 = MainToolbarShortcut.bookmark, this.pinnedShortcut2 = MainToolbarShortcut.search, this.longPressShortcut = MainToolbarShortcut.plans, this.pinToBottom = false}): super._();
  factory _MainToolbarConfiguration.fromJson(Map<String, dynamic> json) => _$MainToolbarConfigurationFromJson(json);

@override@JsonKey() final  MainToolbarShortcut pinnedShortcut1;
@override@JsonKey() final  MainToolbarShortcut pinnedShortcut2;
@override@JsonKey() final  MainToolbarShortcut longPressShortcut;
@override@JsonKey() final  bool pinToBottom;

/// Create a copy of MainToolbarConfiguration
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MainToolbarConfigurationCopyWith<_MainToolbarConfiguration> get copyWith => __$MainToolbarConfigurationCopyWithImpl<_MainToolbarConfiguration>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MainToolbarConfigurationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MainToolbarConfiguration&&(identical(other.pinnedShortcut1, pinnedShortcut1) || other.pinnedShortcut1 == pinnedShortcut1)&&(identical(other.pinnedShortcut2, pinnedShortcut2) || other.pinnedShortcut2 == pinnedShortcut2)&&(identical(other.longPressShortcut, longPressShortcut) || other.longPressShortcut == longPressShortcut)&&(identical(other.pinToBottom, pinToBottom) || other.pinToBottom == pinToBottom));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pinnedShortcut1,pinnedShortcut2,longPressShortcut,pinToBottom);

@override
String toString() {
  return 'MainToolbarConfiguration(pinnedShortcut1: $pinnedShortcut1, pinnedShortcut2: $pinnedShortcut2, longPressShortcut: $longPressShortcut, pinToBottom: $pinToBottom)';
}


}

/// @nodoc
abstract mixin class _$MainToolbarConfigurationCopyWith<$Res> implements $MainToolbarConfigurationCopyWith<$Res> {
  factory _$MainToolbarConfigurationCopyWith(_MainToolbarConfiguration value, $Res Function(_MainToolbarConfiguration) _then) = __$MainToolbarConfigurationCopyWithImpl;
@override @useResult
$Res call({
 MainToolbarShortcut pinnedShortcut1, MainToolbarShortcut pinnedShortcut2, MainToolbarShortcut longPressShortcut, bool pinToBottom
});




}
/// @nodoc
class __$MainToolbarConfigurationCopyWithImpl<$Res>
    implements _$MainToolbarConfigurationCopyWith<$Res> {
  __$MainToolbarConfigurationCopyWithImpl(this._self, this._then);

  final _MainToolbarConfiguration _self;
  final $Res Function(_MainToolbarConfiguration) _then;

/// Create a copy of MainToolbarConfiguration
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pinnedShortcut1 = null,Object? pinnedShortcut2 = null,Object? longPressShortcut = null,Object? pinToBottom = null,}) {
  return _then(_MainToolbarConfiguration(
pinnedShortcut1: null == pinnedShortcut1 ? _self.pinnedShortcut1 : pinnedShortcut1 // ignore: cast_nullable_to_non_nullable
as MainToolbarShortcut,pinnedShortcut2: null == pinnedShortcut2 ? _self.pinnedShortcut2 : pinnedShortcut2 // ignore: cast_nullable_to_non_nullable
as MainToolbarShortcut,longPressShortcut: null == longPressShortcut ? _self.longPressShortcut : longPressShortcut // ignore: cast_nullable_to_non_nullable
as MainToolbarShortcut,pinToBottom: null == pinToBottom ? _self.pinToBottom : pinToBottom // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
