// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bible_plan_study_note.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BiblePlanStudyNote {

@JsonKey(name: 't') String get title;@JsonKey(name: 'b') List<RichContent> get body;
/// Create a copy of BiblePlanStudyNote
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BiblePlanStudyNoteCopyWith<BiblePlanStudyNote> get copyWith => _$BiblePlanStudyNoteCopyWithImpl<BiblePlanStudyNote>(this as BiblePlanStudyNote, _$identity);

  /// Serializes this BiblePlanStudyNote to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BiblePlanStudyNote&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.body, body));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,const DeepCollectionEquality().hash(body));

@override
String toString() {
  return 'BiblePlanStudyNote(title: $title, body: $body)';
}


}

/// @nodoc
abstract mixin class $BiblePlanStudyNoteCopyWith<$Res>  {
  factory $BiblePlanStudyNoteCopyWith(BiblePlanStudyNote value, $Res Function(BiblePlanStudyNote) _then) = _$BiblePlanStudyNoteCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 't') String title,@JsonKey(name: 'b') List<RichContent> body
});




}
/// @nodoc
class _$BiblePlanStudyNoteCopyWithImpl<$Res>
    implements $BiblePlanStudyNoteCopyWith<$Res> {
  _$BiblePlanStudyNoteCopyWithImpl(this._self, this._then);

  final BiblePlanStudyNote _self;
  final $Res Function(BiblePlanStudyNote) _then;

/// Create a copy of BiblePlanStudyNote
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? body = null,}) {
  return _then(BiblePlanStudyNote(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as List<RichContent>,
  ));
}

}


/// Adds pattern-matching-related methods to [BiblePlanStudyNote].
extension BiblePlanStudyNotePatterns on BiblePlanStudyNote {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BiblePlanStudyNote value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BiblePlanStudyNote() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BiblePlanStudyNote value)  $default,){
final _that = this;
switch (_that) {
case _BiblePlanStudyNote():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BiblePlanStudyNote value)?  $default,){
final _that = this;
switch (_that) {
case _BiblePlanStudyNote() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 't')  String title, @JsonKey(name: 'b')  List<RichContent> body)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BiblePlanStudyNote() when $default != null:
return $default(_that.title,_that.body);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 't')  String title, @JsonKey(name: 'b')  List<RichContent> body)  $default,) {final _that = this;
switch (_that) {
case _BiblePlanStudyNote():
return $default(_that.title,_that.body);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 't')  String title, @JsonKey(name: 'b')  List<RichContent> body)?  $default,) {final _that = this;
switch (_that) {
case _BiblePlanStudyNote() when $default != null:
return $default(_that.title,_that.body);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BiblePlanStudyNote implements BiblePlanStudyNote {
  const _BiblePlanStudyNote({@JsonKey(name: 't') required this.title, @JsonKey(name: 'b') required  List<RichContent> body}): _body = body;
  factory _BiblePlanStudyNote.fromJson(Map<String, dynamic> json) => _$BiblePlanStudyNoteFromJson(json);

@override@JsonKey(name: 't') final  String title;
 final  List<RichContent> _body;
@override@JsonKey(name: 'b') List<RichContent> get body {
  if (_body is EqualUnmodifiableListView) return _body;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_body);
}


/// Create a copy of BiblePlanStudyNote
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BiblePlanStudyNoteCopyWith<_BiblePlanStudyNote> get copyWith => __$BiblePlanStudyNoteCopyWithImpl<_BiblePlanStudyNote>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BiblePlanStudyNoteToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BiblePlanStudyNote&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other._body, _body));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,const DeepCollectionEquality().hash(_body));

@override
String toString() {
  return 'BiblePlanStudyNote(title: $title, body: $body)';
}


}

/// @nodoc
abstract mixin class _$BiblePlanStudyNoteCopyWith<$Res> implements $BiblePlanStudyNoteCopyWith<$Res> {
  factory _$BiblePlanStudyNoteCopyWith(_BiblePlanStudyNote value, $Res Function(_BiblePlanStudyNote) _then) = __$BiblePlanStudyNoteCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 't') String title,@JsonKey(name: 'b') List<RichContent> body
});




}
/// @nodoc
class __$BiblePlanStudyNoteCopyWithImpl<$Res>
    implements _$BiblePlanStudyNoteCopyWith<$Res> {
  __$BiblePlanStudyNoteCopyWithImpl(this._self, this._then);

  final _BiblePlanStudyNote _self;
  final $Res Function(_BiblePlanStudyNote) _then;

/// Create a copy of BiblePlanStudyNote
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? body = null,}) {
  return _then(_BiblePlanStudyNote(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self._body : body // ignore: cast_nullable_to_non_nullable
as List<RichContent>,
  ));
}


}

// dart format on
