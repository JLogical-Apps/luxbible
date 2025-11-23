// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'selection.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
Selection _$SelectionFromJson(
  Map<String, dynamic> json
) {
        switch (json['runtimeType']) {
                  case 'passage':
          return PassageSelection.fromJson(
            json
          );
                case 'words':
          return WordsSelection.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'runtimeType',
  'Selection',
  'Invalid union type "${json['runtimeType']}"!'
);
        }
      
}

/// @nodoc
mixin _$Selection {



  /// Serializes this Selection to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Selection);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Selection()';
}


}

/// @nodoc
class $SelectionCopyWith<$Res>  {
$SelectionCopyWith(Selection _, $Res Function(Selection) __);
}


/// Adds pattern-matching-related methods to [Selection].
extension SelectionPatterns on Selection {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( PassageSelection value)?  passage,TResult Function( WordsSelection value)?  words,required TResult orElse(),}){
final _that = this;
switch (_that) {
case PassageSelection() when passage != null:
return passage(_that);case WordsSelection() when words != null:
return words(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( PassageSelection value)  passage,required TResult Function( WordsSelection value)  words,}){
final _that = this;
switch (_that) {
case PassageSelection():
return passage(_that);case WordsSelection():
return words(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( PassageSelection value)?  passage,TResult? Function( WordsSelection value)?  words,}){
final _that = this;
switch (_that) {
case PassageSelection() when passage != null:
return passage(_that);case WordsSelection() when words != null:
return words(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( Passage passage)?  passage,TResult Function( SelectionWordAnchor start,  SelectionWordAnchor end,  BibleTranslation translation)?  words,required TResult orElse(),}) {final _that = this;
switch (_that) {
case PassageSelection() when passage != null:
return passage(_that.passage);case WordsSelection() when words != null:
return words(_that.start,_that.end,_that.translation);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( Passage passage)  passage,required TResult Function( SelectionWordAnchor start,  SelectionWordAnchor end,  BibleTranslation translation)  words,}) {final _that = this;
switch (_that) {
case PassageSelection():
return passage(_that.passage);case WordsSelection():
return words(_that.start,_that.end,_that.translation);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( Passage passage)?  passage,TResult? Function( SelectionWordAnchor start,  SelectionWordAnchor end,  BibleTranslation translation)?  words,}) {final _that = this;
switch (_that) {
case PassageSelection() when passage != null:
return passage(_that.passage);case WordsSelection() when words != null:
return words(_that.start,_that.end,_that.translation);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class PassageSelection extends Selection {
  const PassageSelection({required this.passage, final  String? $type}): $type = $type ?? 'passage',super._();
  factory PassageSelection.fromJson(Map<String, dynamic> json) => _$PassageSelectionFromJson(json);

 final  Passage passage;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of Selection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PassageSelectionCopyWith<PassageSelection> get copyWith => _$PassageSelectionCopyWithImpl<PassageSelection>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PassageSelectionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PassageSelection&&(identical(other.passage, passage) || other.passage == passage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,passage);

@override
String toString() {
  return 'Selection.passage(passage: $passage)';
}


}

/// @nodoc
abstract mixin class $PassageSelectionCopyWith<$Res> implements $SelectionCopyWith<$Res> {
  factory $PassageSelectionCopyWith(PassageSelection value, $Res Function(PassageSelection) _then) = _$PassageSelectionCopyWithImpl;
@useResult
$Res call({
 Passage passage
});




}
/// @nodoc
class _$PassageSelectionCopyWithImpl<$Res>
    implements $PassageSelectionCopyWith<$Res> {
  _$PassageSelectionCopyWithImpl(this._self, this._then);

  final PassageSelection _self;
  final $Res Function(PassageSelection) _then;

/// Create a copy of Selection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? passage = null,}) {
  return _then(PassageSelection(
passage: null == passage ? _self.passage : passage // ignore: cast_nullable_to_non_nullable
as Passage,
  ));
}


}

/// @nodoc
@JsonSerializable()

class WordsSelection extends Selection {
  const WordsSelection({required this.start, required this.end, required this.translation, final  String? $type}): $type = $type ?? 'words',super._();
  factory WordsSelection.fromJson(Map<String, dynamic> json) => _$WordsSelectionFromJson(json);

 final  SelectionWordAnchor start;
 final  SelectionWordAnchor end;
 final  BibleTranslation translation;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of Selection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WordsSelectionCopyWith<WordsSelection> get copyWith => _$WordsSelectionCopyWithImpl<WordsSelection>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WordsSelectionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WordsSelection&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end)&&(identical(other.translation, translation) || other.translation == translation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,start,end,translation);

@override
String toString() {
  return 'Selection.words(start: $start, end: $end, translation: $translation)';
}


}

/// @nodoc
abstract mixin class $WordsSelectionCopyWith<$Res> implements $SelectionCopyWith<$Res> {
  factory $WordsSelectionCopyWith(WordsSelection value, $Res Function(WordsSelection) _then) = _$WordsSelectionCopyWithImpl;
@useResult
$Res call({
 SelectionWordAnchor start, SelectionWordAnchor end, BibleTranslation translation
});




}
/// @nodoc
class _$WordsSelectionCopyWithImpl<$Res>
    implements $WordsSelectionCopyWith<$Res> {
  _$WordsSelectionCopyWithImpl(this._self, this._then);

  final WordsSelection _self;
  final $Res Function(WordsSelection) _then;

/// Create a copy of Selection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? start = null,Object? end = null,Object? translation = null,}) {
  return _then(WordsSelection(
start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as SelectionWordAnchor,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as SelectionWordAnchor,translation: null == translation ? _self.translation : translation // ignore: cast_nullable_to_non_nullable
as BibleTranslation,
  ));
}


}

// dart format on
