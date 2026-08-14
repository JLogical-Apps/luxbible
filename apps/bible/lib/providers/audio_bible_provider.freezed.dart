// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'audio_bible_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AudioBibleContextState {

 BibleTranslation get translation; VerseSelection get passage; Map<Reference, AudioBibleVerseTiming> get timings;
/// Create a copy of AudioBibleContextState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AudioBibleContextStateCopyWith<AudioBibleContextState> get copyWith => _$AudioBibleContextStateCopyWithImpl<AudioBibleContextState>(this as AudioBibleContextState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AudioBibleContextState&&(identical(other.translation, translation) || other.translation == translation)&&(identical(other.passage, passage) || other.passage == passage)&&const DeepCollectionEquality().equals(other.timings, timings));
}


@override
int get hashCode => Object.hash(runtimeType,translation,passage,const DeepCollectionEquality().hash(timings));

@override
String toString() {
  return 'AudioBibleContextState(translation: $translation, passage: $passage, timings: $timings)';
}


}

/// @nodoc
abstract mixin class $AudioBibleContextStateCopyWith<$Res>  {
  factory $AudioBibleContextStateCopyWith(AudioBibleContextState value, $Res Function(AudioBibleContextState) _then) = _$AudioBibleContextStateCopyWithImpl;
@useResult
$Res call({
 BibleTranslation translation, VerseSelection passage, Map<Reference, AudioBibleVerseTiming> timings
});




}
/// @nodoc
class _$AudioBibleContextStateCopyWithImpl<$Res>
    implements $AudioBibleContextStateCopyWith<$Res> {
  _$AudioBibleContextStateCopyWithImpl(this._self, this._then);

  final AudioBibleContextState _self;
  final $Res Function(AudioBibleContextState) _then;

/// Create a copy of AudioBibleContextState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? translation = null,Object? passage = null,Object? timings = null,}) {
  return _then(AudioBibleContextState(
translation: null == translation ? _self.translation : translation // ignore: cast_nullable_to_non_nullable
as BibleTranslation,passage: null == passage ? _self.passage : passage // ignore: cast_nullable_to_non_nullable
as VerseSelection,timings: null == timings ? _self.timings : timings // ignore: cast_nullable_to_non_nullable
as Map<Reference, AudioBibleVerseTiming>,
  ));
}

}


/// Adds pattern-matching-related methods to [AudioBibleContextState].
extension AudioBibleContextStatePatterns on AudioBibleContextState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AudioBibleContextState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AudioBibleContextState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AudioBibleContextState value)  $default,){
final _that = this;
switch (_that) {
case _AudioBibleContextState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AudioBibleContextState value)?  $default,){
final _that = this;
switch (_that) {
case _AudioBibleContextState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BibleTranslation translation,  VerseSelection passage,  Map<Reference, AudioBibleVerseTiming> timings)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AudioBibleContextState() when $default != null:
return $default(_that.translation,_that.passage,_that.timings);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BibleTranslation translation,  VerseSelection passage,  Map<Reference, AudioBibleVerseTiming> timings)  $default,) {final _that = this;
switch (_that) {
case _AudioBibleContextState():
return $default(_that.translation,_that.passage,_that.timings);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BibleTranslation translation,  VerseSelection passage,  Map<Reference, AudioBibleVerseTiming> timings)?  $default,) {final _that = this;
switch (_that) {
case _AudioBibleContextState() when $default != null:
return $default(_that.translation,_that.passage,_that.timings);case _:
  return null;

}
}

}

/// @nodoc


class _AudioBibleContextState extends AudioBibleContextState {
  const _AudioBibleContextState({required this.translation, required this.passage, required  Map<Reference, AudioBibleVerseTiming> timings}): _timings = timings,super._();
  

@override final  BibleTranslation translation;
@override final  VerseSelection passage;
 final  Map<Reference, AudioBibleVerseTiming> _timings;
@override Map<Reference, AudioBibleVerseTiming> get timings {
  if (_timings is EqualUnmodifiableMapView) return _timings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_timings);
}


/// Create a copy of AudioBibleContextState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AudioBibleContextStateCopyWith<_AudioBibleContextState> get copyWith => __$AudioBibleContextStateCopyWithImpl<_AudioBibleContextState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AudioBibleContextState&&(identical(other.translation, translation) || other.translation == translation)&&(identical(other.passage, passage) || other.passage == passage)&&const DeepCollectionEquality().equals(other._timings, _timings));
}


@override
int get hashCode => Object.hash(runtimeType,translation,passage,const DeepCollectionEquality().hash(_timings));

@override
String toString() {
  return 'AudioBibleContextState(translation: $translation, passage: $passage, timings: $timings)';
}


}

/// @nodoc
abstract mixin class _$AudioBibleContextStateCopyWith<$Res> implements $AudioBibleContextStateCopyWith<$Res> {
  factory _$AudioBibleContextStateCopyWith(_AudioBibleContextState value, $Res Function(_AudioBibleContextState) _then) = __$AudioBibleContextStateCopyWithImpl;
@override @useResult
$Res call({
 BibleTranslation translation, VerseSelection passage, Map<Reference, AudioBibleVerseTiming> timings
});




}
/// @nodoc
class __$AudioBibleContextStateCopyWithImpl<$Res>
    implements _$AudioBibleContextStateCopyWith<$Res> {
  __$AudioBibleContextStateCopyWithImpl(this._self, this._then);

  final _AudioBibleContextState _self;
  final $Res Function(_AudioBibleContextState) _then;

/// Create a copy of AudioBibleContextState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? translation = null,Object? passage = null,Object? timings = null,}) {
  return _then(_AudioBibleContextState(
translation: null == translation ? _self.translation : translation // ignore: cast_nullable_to_non_nullable
as BibleTranslation,passage: null == passage ? _self.passage : passage // ignore: cast_nullable_to_non_nullable
as VerseSelection,timings: null == timings ? _self._timings : timings // ignore: cast_nullable_to_non_nullable
as Map<Reference, AudioBibleVerseTiming>,
  ));
}


}

// dart format on
