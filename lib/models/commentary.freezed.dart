// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'commentary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Commentary {

@JsonKey(name: 'v', toJson: _notesToJson, fromJson: _notesFromJson) Map<VerseSelection, String> get notes;
/// Create a copy of Commentary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommentaryCopyWith<Commentary> get copyWith => _$CommentaryCopyWithImpl<Commentary>(this as Commentary, _$identity);

  /// Serializes this Commentary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Commentary&&const DeepCollectionEquality().equals(other.notes, notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(notes));

@override
String toString() {
  return 'Commentary(notes: $notes)';
}


}

/// @nodoc
abstract mixin class $CommentaryCopyWith<$Res>  {
  factory $CommentaryCopyWith(Commentary value, $Res Function(Commentary) _then) = _$CommentaryCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'v', toJson: _notesToJson, fromJson: _notesFromJson) Map<VerseSelection, String> notes
});




}
/// @nodoc
class _$CommentaryCopyWithImpl<$Res>
    implements $CommentaryCopyWith<$Res> {
  _$CommentaryCopyWithImpl(this._self, this._then);

  final Commentary _self;
  final $Res Function(Commentary) _then;

/// Create a copy of Commentary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? notes = null,}) {
  return _then(_self.copyWith(
notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as Map<VerseSelection, String>,
  ));
}

}


/// Adds pattern-matching-related methods to [Commentary].
extension CommentaryPatterns on Commentary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Commentary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Commentary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Commentary value)  $default,){
final _that = this;
switch (_that) {
case _Commentary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Commentary value)?  $default,){
final _that = this;
switch (_that) {
case _Commentary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'v', toJson: _notesToJson, fromJson: _notesFromJson)  Map<VerseSelection, String> notes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Commentary() when $default != null:
return $default(_that.notes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'v', toJson: _notesToJson, fromJson: _notesFromJson)  Map<VerseSelection, String> notes)  $default,) {final _that = this;
switch (_that) {
case _Commentary():
return $default(_that.notes);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'v', toJson: _notesToJson, fromJson: _notesFromJson)  Map<VerseSelection, String> notes)?  $default,) {final _that = this;
switch (_that) {
case _Commentary() when $default != null:
return $default(_that.notes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Commentary extends Commentary {
  const _Commentary({@JsonKey(name: 'v', toJson: _notesToJson, fromJson: _notesFromJson) required final  Map<VerseSelection, String> notes}): _notes = notes,super._();
  factory _Commentary.fromJson(Map<String, dynamic> json) => _$CommentaryFromJson(json);

 final  Map<VerseSelection, String> _notes;
@override@JsonKey(name: 'v', toJson: _notesToJson, fromJson: _notesFromJson) Map<VerseSelection, String> get notes {
  if (_notes is EqualUnmodifiableMapView) return _notes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_notes);
}


/// Create a copy of Commentary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommentaryCopyWith<_Commentary> get copyWith => __$CommentaryCopyWithImpl<_Commentary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommentaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Commentary&&const DeepCollectionEquality().equals(other._notes, _notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_notes));

@override
String toString() {
  return 'Commentary(notes: $notes)';
}


}

/// @nodoc
abstract mixin class _$CommentaryCopyWith<$Res> implements $CommentaryCopyWith<$Res> {
  factory _$CommentaryCopyWith(_Commentary value, $Res Function(_Commentary) _then) = __$CommentaryCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'v', toJson: _notesToJson, fromJson: _notesFromJson) Map<VerseSelection, String> notes
});




}
/// @nodoc
class __$CommentaryCopyWithImpl<$Res>
    implements _$CommentaryCopyWith<$Res> {
  __$CommentaryCopyWithImpl(this._self, this._then);

  final _Commentary _self;
  final $Res Function(_Commentary) _then;

/// Create a copy of Commentary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? notes = null,}) {
  return _then(_Commentary(
notes: null == notes ? _self._notes : notes // ignore: cast_nullable_to_non_nullable
as Map<VerseSelection, String>,
  ));
}


}

// dart format on
