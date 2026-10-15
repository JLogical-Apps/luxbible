// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'navigation_configuration.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NavigationConfiguration {

 NavigationLayout get layout; bool get showsRecents; bool get opensKeyboard;
/// Create a copy of NavigationConfiguration
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NavigationConfigurationCopyWith<NavigationConfiguration> get copyWith => _$NavigationConfigurationCopyWithImpl<NavigationConfiguration>(this as NavigationConfiguration, _$identity);

  /// Serializes this NavigationConfiguration to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NavigationConfiguration&&(identical(other.layout, layout) || other.layout == layout)&&(identical(other.showsRecents, showsRecents) || other.showsRecents == showsRecents)&&(identical(other.opensKeyboard, opensKeyboard) || other.opensKeyboard == opensKeyboard));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,layout,showsRecents,opensKeyboard);

@override
String toString() {
  return 'NavigationConfiguration(layout: $layout, showsRecents: $showsRecents, opensKeyboard: $opensKeyboard)';
}


}

/// @nodoc
abstract mixin class $NavigationConfigurationCopyWith<$Res>  {
  factory $NavigationConfigurationCopyWith(NavigationConfiguration value, $Res Function(NavigationConfiguration) _then) = _$NavigationConfigurationCopyWithImpl;
@useResult
$Res call({
 NavigationLayout layout, bool showsRecents, bool opensKeyboard
});




}
/// @nodoc
class _$NavigationConfigurationCopyWithImpl<$Res>
    implements $NavigationConfigurationCopyWith<$Res> {
  _$NavigationConfigurationCopyWithImpl(this._self, this._then);

  final NavigationConfiguration _self;
  final $Res Function(NavigationConfiguration) _then;

/// Create a copy of NavigationConfiguration
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? layout = null,Object? showsRecents = null,Object? opensKeyboard = null,}) {
  return _then(NavigationConfiguration(
layout: null == layout ? _self.layout : layout // ignore: cast_nullable_to_non_nullable
as NavigationLayout,showsRecents: null == showsRecents ? _self.showsRecents : showsRecents // ignore: cast_nullable_to_non_nullable
as bool,opensKeyboard: null == opensKeyboard ? _self.opensKeyboard : opensKeyboard // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [NavigationConfiguration].
extension NavigationConfigurationPatterns on NavigationConfiguration {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NavigationConfiguration value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NavigationConfiguration() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NavigationConfiguration value)  $default,){
final _that = this;
switch (_that) {
case _NavigationConfiguration():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NavigationConfiguration value)?  $default,){
final _that = this;
switch (_that) {
case _NavigationConfiguration() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( NavigationLayout layout,  bool showsRecents,  bool opensKeyboard)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NavigationConfiguration() when $default != null:
return $default(_that.layout,_that.showsRecents,_that.opensKeyboard);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( NavigationLayout layout,  bool showsRecents,  bool opensKeyboard)  $default,) {final _that = this;
switch (_that) {
case _NavigationConfiguration():
return $default(_that.layout,_that.showsRecents,_that.opensKeyboard);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( NavigationLayout layout,  bool showsRecents,  bool opensKeyboard)?  $default,) {final _that = this;
switch (_that) {
case _NavigationConfiguration() when $default != null:
return $default(_that.layout,_that.showsRecents,_that.opensKeyboard);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NavigationConfiguration implements NavigationConfiguration {
  const _NavigationConfiguration({this.layout = NavigationLayout.list, this.showsRecents = true, this.opensKeyboard = true});
  factory _NavigationConfiguration.fromJson(Map<String, dynamic> json) => _$NavigationConfigurationFromJson(json);

@override@JsonKey() final  NavigationLayout layout;
@override@JsonKey() final  bool showsRecents;
@override@JsonKey() final  bool opensKeyboard;

/// Create a copy of NavigationConfiguration
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NavigationConfigurationCopyWith<_NavigationConfiguration> get copyWith => __$NavigationConfigurationCopyWithImpl<_NavigationConfiguration>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NavigationConfigurationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NavigationConfiguration&&(identical(other.layout, layout) || other.layout == layout)&&(identical(other.showsRecents, showsRecents) || other.showsRecents == showsRecents)&&(identical(other.opensKeyboard, opensKeyboard) || other.opensKeyboard == opensKeyboard));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,layout,showsRecents,opensKeyboard);

@override
String toString() {
  return 'NavigationConfiguration(layout: $layout, showsRecents: $showsRecents, opensKeyboard: $opensKeyboard)';
}


}

/// @nodoc
abstract mixin class _$NavigationConfigurationCopyWith<$Res> implements $NavigationConfigurationCopyWith<$Res> {
  factory _$NavigationConfigurationCopyWith(_NavigationConfiguration value, $Res Function(_NavigationConfiguration) _then) = __$NavigationConfigurationCopyWithImpl;
@override @useResult
$Res call({
 NavigationLayout layout, bool showsRecents, bool opensKeyboard
});




}
/// @nodoc
class __$NavigationConfigurationCopyWithImpl<$Res>
    implements _$NavigationConfigurationCopyWith<$Res> {
  __$NavigationConfigurationCopyWithImpl(this._self, this._then);

  final _NavigationConfiguration _self;
  final $Res Function(_NavigationConfiguration) _then;

/// Create a copy of NavigationConfiguration
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? layout = null,Object? showsRecents = null,Object? opensKeyboard = null,}) {
  return _then(_NavigationConfiguration(
layout: null == layout ? _self.layout : layout // ignore: cast_nullable_to_non_nullable
as NavigationLayout,showsRecents: null == showsRecents ? _self.showsRecents : showsRecents // ignore: cast_nullable_to_non_nullable
as bool,opensKeyboard: null == opensKeyboard ? _self.opensKeyboard : opensKeyboard // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
