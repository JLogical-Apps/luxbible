// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bible_text_selection.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BibleTextSelection {

 BibleTextSelectionWordAnchor get start; BibleTextSelectionWordAnchor get end; BibleTranslation get translation;
/// Create a copy of BibleTextSelection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BibleTextSelectionCopyWith<BibleTextSelection> get copyWith => _$BibleTextSelectionCopyWithImpl<BibleTextSelection>(this as BibleTextSelection, _$identity);

  /// Serializes this BibleTextSelection to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BibleTextSelection&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end)&&(identical(other.translation, translation) || other.translation == translation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,start,end,translation);

@override
String toString() {
  return 'BibleTextSelection(start: $start, end: $end, translation: $translation)';
}


}

/// @nodoc
abstract mixin class $BibleTextSelectionCopyWith<$Res>  {
  factory $BibleTextSelectionCopyWith(BibleTextSelection value, $Res Function(BibleTextSelection) _then) = _$BibleTextSelectionCopyWithImpl;
@useResult
$Res call({
 BibleTextSelectionWordAnchor start, BibleTextSelectionWordAnchor end, BibleTranslation translation
});




}
/// @nodoc
class _$BibleTextSelectionCopyWithImpl<$Res>
    implements $BibleTextSelectionCopyWith<$Res> {
  _$BibleTextSelectionCopyWithImpl(this._self, this._then);

  final BibleTextSelection _self;
  final $Res Function(BibleTextSelection) _then;

/// Create a copy of BibleTextSelection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? start = null,Object? end = null,Object? translation = null,}) {
  return _then(_self.copyWith(
start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as BibleTextSelectionWordAnchor,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as BibleTextSelectionWordAnchor,translation: null == translation ? _self.translation : translation // ignore: cast_nullable_to_non_nullable
as BibleTranslation,
  ));
}

}


/// Adds pattern-matching-related methods to [BibleTextSelection].
extension BibleTextSelectionPatterns on BibleTextSelection {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BibleTextSelection value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BibleTextSelection() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BibleTextSelection value)  $default,){
final _that = this;
switch (_that) {
case _BibleTextSelection():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BibleTextSelection value)?  $default,){
final _that = this;
switch (_that) {
case _BibleTextSelection() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BibleTextSelectionWordAnchor start,  BibleTextSelectionWordAnchor end,  BibleTranslation translation)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BibleTextSelection() when $default != null:
return $default(_that.start,_that.end,_that.translation);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BibleTextSelectionWordAnchor start,  BibleTextSelectionWordAnchor end,  BibleTranslation translation)  $default,) {final _that = this;
switch (_that) {
case _BibleTextSelection():
return $default(_that.start,_that.end,_that.translation);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BibleTextSelectionWordAnchor start,  BibleTextSelectionWordAnchor end,  BibleTranslation translation)?  $default,) {final _that = this;
switch (_that) {
case _BibleTextSelection() when $default != null:
return $default(_that.start,_that.end,_that.translation);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BibleTextSelection extends BibleTextSelection {
  const _BibleTextSelection({required this.start, required this.end, required this.translation}): super._();
  factory _BibleTextSelection.fromJson(Map<String, dynamic> json) => _$BibleTextSelectionFromJson(json);

@override final  BibleTextSelectionWordAnchor start;
@override final  BibleTextSelectionWordAnchor end;
@override final  BibleTranslation translation;

/// Create a copy of BibleTextSelection
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BibleTextSelectionCopyWith<_BibleTextSelection> get copyWith => __$BibleTextSelectionCopyWithImpl<_BibleTextSelection>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BibleTextSelectionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BibleTextSelection&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end)&&(identical(other.translation, translation) || other.translation == translation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,start,end,translation);

@override
String toString() {
  return 'BibleTextSelection(start: $start, end: $end, translation: $translation)';
}


}

/// @nodoc
abstract mixin class _$BibleTextSelectionCopyWith<$Res> implements $BibleTextSelectionCopyWith<$Res> {
  factory _$BibleTextSelectionCopyWith(_BibleTextSelection value, $Res Function(_BibleTextSelection) _then) = __$BibleTextSelectionCopyWithImpl;
@override @useResult
$Res call({
 BibleTextSelectionWordAnchor start, BibleTextSelectionWordAnchor end, BibleTranslation translation
});




}
/// @nodoc
class __$BibleTextSelectionCopyWithImpl<$Res>
    implements _$BibleTextSelectionCopyWith<$Res> {
  __$BibleTextSelectionCopyWithImpl(this._self, this._then);

  final _BibleTextSelection _self;
  final $Res Function(_BibleTextSelection) _then;

/// Create a copy of BibleTextSelection
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? start = null,Object? end = null,Object? translation = null,}) {
  return _then(_BibleTextSelection(
start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as BibleTextSelectionWordAnchor,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as BibleTextSelectionWordAnchor,translation: null == translation ? _self.translation : translation // ignore: cast_nullable_to_non_nullable
as BibleTranslation,
  ));
}


}

// dart format on
