// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'passage_note.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PassageNote {

 String get passageKey; String get note;
/// Create a copy of PassageNote
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PassageNoteCopyWith<PassageNote> get copyWith => _$PassageNoteCopyWithImpl<PassageNote>(this as PassageNote, _$identity);

  /// Serializes this PassageNote to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PassageNote&&(identical(other.passageKey, passageKey) || other.passageKey == passageKey)&&(identical(other.note, note) || other.note == note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,passageKey,note);

@override
String toString() {
  return 'PassageNote(passageKey: $passageKey, note: $note)';
}


}

/// @nodoc
abstract mixin class $PassageNoteCopyWith<$Res>  {
  factory $PassageNoteCopyWith(PassageNote value, $Res Function(PassageNote) _then) = _$PassageNoteCopyWithImpl;
@useResult
$Res call({
 String passageKey, String note
});




}
/// @nodoc
class _$PassageNoteCopyWithImpl<$Res>
    implements $PassageNoteCopyWith<$Res> {
  _$PassageNoteCopyWithImpl(this._self, this._then);

  final PassageNote _self;
  final $Res Function(PassageNote) _then;

/// Create a copy of PassageNote
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? passageKey = null,Object? note = null,}) {
  return _then(_self.copyWith(
passageKey: null == passageKey ? _self.passageKey : passageKey // ignore: cast_nullable_to_non_nullable
as String,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PassageNote].
extension PassageNotePatterns on PassageNote {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PassageNote value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PassageNote() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PassageNote value)  $default,){
final _that = this;
switch (_that) {
case _PassageNote():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PassageNote value)?  $default,){
final _that = this;
switch (_that) {
case _PassageNote() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String passageKey,  String note)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PassageNote() when $default != null:
return $default(_that.passageKey,_that.note);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String passageKey,  String note)  $default,) {final _that = this;
switch (_that) {
case _PassageNote():
return $default(_that.passageKey,_that.note);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String passageKey,  String note)?  $default,) {final _that = this;
switch (_that) {
case _PassageNote() when $default != null:
return $default(_that.passageKey,_that.note);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PassageNote extends PassageNote {
  const _PassageNote({required this.passageKey, required this.note}): super._();
  factory _PassageNote.fromJson(Map<String, dynamic> json) => _$PassageNoteFromJson(json);

@override final  String passageKey;
@override final  String note;

/// Create a copy of PassageNote
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PassageNoteCopyWith<_PassageNote> get copyWith => __$PassageNoteCopyWithImpl<_PassageNote>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PassageNoteToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PassageNote&&(identical(other.passageKey, passageKey) || other.passageKey == passageKey)&&(identical(other.note, note) || other.note == note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,passageKey,note);

@override
String toString() {
  return 'PassageNote(passageKey: $passageKey, note: $note)';
}


}

/// @nodoc
abstract mixin class _$PassageNoteCopyWith<$Res> implements $PassageNoteCopyWith<$Res> {
  factory _$PassageNoteCopyWith(_PassageNote value, $Res Function(_PassageNote) _then) = __$PassageNoteCopyWithImpl;
@override @useResult
$Res call({
 String passageKey, String note
});




}
/// @nodoc
class __$PassageNoteCopyWithImpl<$Res>
    implements _$PassageNoteCopyWith<$Res> {
  __$PassageNoteCopyWithImpl(this._self, this._then);

  final _PassageNote _self;
  final $Res Function(_PassageNote) _then;

/// Create a copy of PassageNote
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? passageKey = null,Object? note = null,}) {
  return _then(_PassageNote(
passageKey: null == passageKey ? _self.passageKey : passageKey // ignore: cast_nullable_to_non_nullable
as String,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
