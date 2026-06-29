// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'theme_layout_configuration.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ThemeLayoutConfiguration {

 ThemeFont get font; FontSizeSpacing get fontSizeSpacing; bool get redLetters; bool get sections; bool get verseNumbers; bool get paragraphs; bool get footnotes;
/// Create a copy of ThemeLayoutConfiguration
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ThemeLayoutConfigurationCopyWith<ThemeLayoutConfiguration> get copyWith => _$ThemeLayoutConfigurationCopyWithImpl<ThemeLayoutConfiguration>(this as ThemeLayoutConfiguration, _$identity);

  /// Serializes this ThemeLayoutConfiguration to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ThemeLayoutConfiguration&&(identical(other.font, font) || other.font == font)&&(identical(other.fontSizeSpacing, fontSizeSpacing) || other.fontSizeSpacing == fontSizeSpacing)&&(identical(other.redLetters, redLetters) || other.redLetters == redLetters)&&(identical(other.sections, sections) || other.sections == sections)&&(identical(other.verseNumbers, verseNumbers) || other.verseNumbers == verseNumbers)&&(identical(other.paragraphs, paragraphs) || other.paragraphs == paragraphs)&&(identical(other.footnotes, footnotes) || other.footnotes == footnotes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,font,fontSizeSpacing,redLetters,sections,verseNumbers,paragraphs,footnotes);

@override
String toString() {
  return 'ThemeLayoutConfiguration(font: $font, fontSizeSpacing: $fontSizeSpacing, redLetters: $redLetters, sections: $sections, verseNumbers: $verseNumbers, paragraphs: $paragraphs, footnotes: $footnotes)';
}


}

/// @nodoc
abstract mixin class $ThemeLayoutConfigurationCopyWith<$Res>  {
  factory $ThemeLayoutConfigurationCopyWith(ThemeLayoutConfiguration value, $Res Function(ThemeLayoutConfiguration) _then) = _$ThemeLayoutConfigurationCopyWithImpl;
@useResult
$Res call({
 ThemeFont font, FontSizeSpacing fontSizeSpacing, bool redLetters, bool sections, bool verseNumbers, bool paragraphs, bool footnotes
});




}
/// @nodoc
class _$ThemeLayoutConfigurationCopyWithImpl<$Res>
    implements $ThemeLayoutConfigurationCopyWith<$Res> {
  _$ThemeLayoutConfigurationCopyWithImpl(this._self, this._then);

  final ThemeLayoutConfiguration _self;
  final $Res Function(ThemeLayoutConfiguration) _then;

/// Create a copy of ThemeLayoutConfiguration
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? font = null,Object? fontSizeSpacing = null,Object? redLetters = null,Object? sections = null,Object? verseNumbers = null,Object? paragraphs = null,Object? footnotes = null,}) {
  return _then(_self.copyWith(
font: null == font ? _self.font : font // ignore: cast_nullable_to_non_nullable
as ThemeFont,fontSizeSpacing: null == fontSizeSpacing ? _self.fontSizeSpacing : fontSizeSpacing // ignore: cast_nullable_to_non_nullable
as FontSizeSpacing,redLetters: null == redLetters ? _self.redLetters : redLetters // ignore: cast_nullable_to_non_nullable
as bool,sections: null == sections ? _self.sections : sections // ignore: cast_nullable_to_non_nullable
as bool,verseNumbers: null == verseNumbers ? _self.verseNumbers : verseNumbers // ignore: cast_nullable_to_non_nullable
as bool,paragraphs: null == paragraphs ? _self.paragraphs : paragraphs // ignore: cast_nullable_to_non_nullable
as bool,footnotes: null == footnotes ? _self.footnotes : footnotes // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ThemeLayoutConfiguration].
extension ThemeLayoutConfigurationPatterns on ThemeLayoutConfiguration {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ThemeLayoutConfiguration value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ThemeLayoutConfiguration() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ThemeLayoutConfiguration value)  $default,){
final _that = this;
switch (_that) {
case _ThemeLayoutConfiguration():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ThemeLayoutConfiguration value)?  $default,){
final _that = this;
switch (_that) {
case _ThemeLayoutConfiguration() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ThemeFont font,  FontSizeSpacing fontSizeSpacing,  bool redLetters,  bool sections,  bool verseNumbers,  bool paragraphs,  bool footnotes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ThemeLayoutConfiguration() when $default != null:
return $default(_that.font,_that.fontSizeSpacing,_that.redLetters,_that.sections,_that.verseNumbers,_that.paragraphs,_that.footnotes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ThemeFont font,  FontSizeSpacing fontSizeSpacing,  bool redLetters,  bool sections,  bool verseNumbers,  bool paragraphs,  bool footnotes)  $default,) {final _that = this;
switch (_that) {
case _ThemeLayoutConfiguration():
return $default(_that.font,_that.fontSizeSpacing,_that.redLetters,_that.sections,_that.verseNumbers,_that.paragraphs,_that.footnotes);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ThemeFont font,  FontSizeSpacing fontSizeSpacing,  bool redLetters,  bool sections,  bool verseNumbers,  bool paragraphs,  bool footnotes)?  $default,) {final _that = this;
switch (_that) {
case _ThemeLayoutConfiguration() when $default != null:
return $default(_that.font,_that.fontSizeSpacing,_that.redLetters,_that.sections,_that.verseNumbers,_that.paragraphs,_that.footnotes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ThemeLayoutConfiguration extends ThemeLayoutConfiguration {
  const _ThemeLayoutConfiguration({this.font = ThemeFont.inter, this.fontSizeSpacing = FontSizeSpacing.standard, this.redLetters = true, this.sections = true, this.verseNumbers = true, this.paragraphs = true, this.footnotes = true}): super._();
  factory _ThemeLayoutConfiguration.fromJson(Map<String, dynamic> json) => _$ThemeLayoutConfigurationFromJson(json);

@override@JsonKey() final  ThemeFont font;
@override@JsonKey() final  FontSizeSpacing fontSizeSpacing;
@override@JsonKey() final  bool redLetters;
@override@JsonKey() final  bool sections;
@override@JsonKey() final  bool verseNumbers;
@override@JsonKey() final  bool paragraphs;
@override@JsonKey() final  bool footnotes;

/// Create a copy of ThemeLayoutConfiguration
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ThemeLayoutConfigurationCopyWith<_ThemeLayoutConfiguration> get copyWith => __$ThemeLayoutConfigurationCopyWithImpl<_ThemeLayoutConfiguration>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ThemeLayoutConfigurationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ThemeLayoutConfiguration&&(identical(other.font, font) || other.font == font)&&(identical(other.fontSizeSpacing, fontSizeSpacing) || other.fontSizeSpacing == fontSizeSpacing)&&(identical(other.redLetters, redLetters) || other.redLetters == redLetters)&&(identical(other.sections, sections) || other.sections == sections)&&(identical(other.verseNumbers, verseNumbers) || other.verseNumbers == verseNumbers)&&(identical(other.paragraphs, paragraphs) || other.paragraphs == paragraphs)&&(identical(other.footnotes, footnotes) || other.footnotes == footnotes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,font,fontSizeSpacing,redLetters,sections,verseNumbers,paragraphs,footnotes);

@override
String toString() {
  return 'ThemeLayoutConfiguration(font: $font, fontSizeSpacing: $fontSizeSpacing, redLetters: $redLetters, sections: $sections, verseNumbers: $verseNumbers, paragraphs: $paragraphs, footnotes: $footnotes)';
}


}

/// @nodoc
abstract mixin class _$ThemeLayoutConfigurationCopyWith<$Res> implements $ThemeLayoutConfigurationCopyWith<$Res> {
  factory _$ThemeLayoutConfigurationCopyWith(_ThemeLayoutConfiguration value, $Res Function(_ThemeLayoutConfiguration) _then) = __$ThemeLayoutConfigurationCopyWithImpl;
@override @useResult
$Res call({
 ThemeFont font, FontSizeSpacing fontSizeSpacing, bool redLetters, bool sections, bool verseNumbers, bool paragraphs, bool footnotes
});




}
/// @nodoc
class __$ThemeLayoutConfigurationCopyWithImpl<$Res>
    implements _$ThemeLayoutConfigurationCopyWith<$Res> {
  __$ThemeLayoutConfigurationCopyWithImpl(this._self, this._then);

  final _ThemeLayoutConfiguration _self;
  final $Res Function(_ThemeLayoutConfiguration) _then;

/// Create a copy of ThemeLayoutConfiguration
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? font = null,Object? fontSizeSpacing = null,Object? redLetters = null,Object? sections = null,Object? verseNumbers = null,Object? paragraphs = null,Object? footnotes = null,}) {
  return _then(_ThemeLayoutConfiguration(
font: null == font ? _self.font : font // ignore: cast_nullable_to_non_nullable
as ThemeFont,fontSizeSpacing: null == fontSizeSpacing ? _self.fontSizeSpacing : fontSizeSpacing // ignore: cast_nullable_to_non_nullable
as FontSizeSpacing,redLetters: null == redLetters ? _self.redLetters : redLetters // ignore: cast_nullable_to_non_nullable
as bool,sections: null == sections ? _self.sections : sections // ignore: cast_nullable_to_non_nullable
as bool,verseNumbers: null == verseNumbers ? _self.verseNumbers : verseNumbers // ignore: cast_nullable_to_non_nullable
as bool,paragraphs: null == paragraphs ? _self.paragraphs : paragraphs // ignore: cast_nullable_to_non_nullable
as bool,footnotes: null == footnotes ? _self.footnotes : footnotes // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
