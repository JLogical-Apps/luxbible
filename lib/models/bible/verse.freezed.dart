// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'verse.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Verse {

@JsonKey(name: 'n') int get verseNum;@JsonKey(name: 'w') List<Word> get words;@JsonKey(name: 'o', includeIfNull: false) Reference? get originalVerse;@JsonKey(name: 'f', includeIfNull: false) List<Footnote>? get footnotes;
/// Create a copy of Verse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VerseCopyWith<Verse> get copyWith => _$VerseCopyWithImpl<Verse>(this as Verse, _$identity);

  /// Serializes this Verse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Verse&&(identical(other.verseNum, verseNum) || other.verseNum == verseNum)&&const DeepCollectionEquality().equals(other.words, words)&&(identical(other.originalVerse, originalVerse) || other.originalVerse == originalVerse)&&const DeepCollectionEquality().equals(other.footnotes, footnotes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,verseNum,const DeepCollectionEquality().hash(words),originalVerse,const DeepCollectionEquality().hash(footnotes));

@override
String toString() {
  return 'Verse(verseNum: $verseNum, words: $words, originalVerse: $originalVerse, footnotes: $footnotes)';
}


}

/// @nodoc
abstract mixin class $VerseCopyWith<$Res>  {
  factory $VerseCopyWith(Verse value, $Res Function(Verse) _then) = _$VerseCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'n') int verseNum,@JsonKey(name: 'w') List<Word> words,@JsonKey(name: 'o', includeIfNull: false) Reference? originalVerse,@JsonKey(name: 'f', includeIfNull: false) List<Footnote>? footnotes
});




}
/// @nodoc
class _$VerseCopyWithImpl<$Res>
    implements $VerseCopyWith<$Res> {
  _$VerseCopyWithImpl(this._self, this._then);

  final Verse _self;
  final $Res Function(Verse) _then;

/// Create a copy of Verse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? verseNum = null,Object? words = null,Object? originalVerse = freezed,Object? footnotes = freezed,}) {
  return _then(_self.copyWith(
verseNum: null == verseNum ? _self.verseNum : verseNum // ignore: cast_nullable_to_non_nullable
as int,words: null == words ? _self.words : words // ignore: cast_nullable_to_non_nullable
as List<Word>,originalVerse: freezed == originalVerse ? _self.originalVerse : originalVerse // ignore: cast_nullable_to_non_nullable
as Reference?,footnotes: freezed == footnotes ? _self.footnotes : footnotes // ignore: cast_nullable_to_non_nullable
as List<Footnote>?,
  ));
}

}


/// Adds pattern-matching-related methods to [Verse].
extension VersePatterns on Verse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Verse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Verse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Verse value)  $default,){
final _that = this;
switch (_that) {
case _Verse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Verse value)?  $default,){
final _that = this;
switch (_that) {
case _Verse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'n')  int verseNum, @JsonKey(name: 'w')  List<Word> words, @JsonKey(name: 'o', includeIfNull: false)  Reference? originalVerse, @JsonKey(name: 'f', includeIfNull: false)  List<Footnote>? footnotes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Verse() when $default != null:
return $default(_that.verseNum,_that.words,_that.originalVerse,_that.footnotes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'n')  int verseNum, @JsonKey(name: 'w')  List<Word> words, @JsonKey(name: 'o', includeIfNull: false)  Reference? originalVerse, @JsonKey(name: 'f', includeIfNull: false)  List<Footnote>? footnotes)  $default,) {final _that = this;
switch (_that) {
case _Verse():
return $default(_that.verseNum,_that.words,_that.originalVerse,_that.footnotes);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'n')  int verseNum, @JsonKey(name: 'w')  List<Word> words, @JsonKey(name: 'o', includeIfNull: false)  Reference? originalVerse, @JsonKey(name: 'f', includeIfNull: false)  List<Footnote>? footnotes)?  $default,) {final _that = this;
switch (_that) {
case _Verse() when $default != null:
return $default(_that.verseNum,_that.words,_that.originalVerse,_that.footnotes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Verse extends Verse {
  const _Verse({@JsonKey(name: 'n') required this.verseNum, @JsonKey(name: 'w') required final  List<Word> words, @JsonKey(name: 'o', includeIfNull: false) this.originalVerse, @JsonKey(name: 'f', includeIfNull: false) final  List<Footnote>? footnotes}): _words = words,_footnotes = footnotes,super._();
  factory _Verse.fromJson(Map<String, dynamic> json) => _$VerseFromJson(json);

@override@JsonKey(name: 'n') final  int verseNum;
 final  List<Word> _words;
@override@JsonKey(name: 'w') List<Word> get words {
  if (_words is EqualUnmodifiableListView) return _words;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_words);
}

@override@JsonKey(name: 'o', includeIfNull: false) final  Reference? originalVerse;
 final  List<Footnote>? _footnotes;
@override@JsonKey(name: 'f', includeIfNull: false) List<Footnote>? get footnotes {
  final value = _footnotes;
  if (value == null) return null;
  if (_footnotes is EqualUnmodifiableListView) return _footnotes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of Verse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VerseCopyWith<_Verse> get copyWith => __$VerseCopyWithImpl<_Verse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VerseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Verse&&(identical(other.verseNum, verseNum) || other.verseNum == verseNum)&&const DeepCollectionEquality().equals(other._words, _words)&&(identical(other.originalVerse, originalVerse) || other.originalVerse == originalVerse)&&const DeepCollectionEquality().equals(other._footnotes, _footnotes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,verseNum,const DeepCollectionEquality().hash(_words),originalVerse,const DeepCollectionEquality().hash(_footnotes));

@override
String toString() {
  return 'Verse(verseNum: $verseNum, words: $words, originalVerse: $originalVerse, footnotes: $footnotes)';
}


}

/// @nodoc
abstract mixin class _$VerseCopyWith<$Res> implements $VerseCopyWith<$Res> {
  factory _$VerseCopyWith(_Verse value, $Res Function(_Verse) _then) = __$VerseCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'n') int verseNum,@JsonKey(name: 'w') List<Word> words,@JsonKey(name: 'o', includeIfNull: false) Reference? originalVerse,@JsonKey(name: 'f', includeIfNull: false) List<Footnote>? footnotes
});




}
/// @nodoc
class __$VerseCopyWithImpl<$Res>
    implements _$VerseCopyWith<$Res> {
  __$VerseCopyWithImpl(this._self, this._then);

  final _Verse _self;
  final $Res Function(_Verse) _then;

/// Create a copy of Verse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? verseNum = null,Object? words = null,Object? originalVerse = freezed,Object? footnotes = freezed,}) {
  return _then(_Verse(
verseNum: null == verseNum ? _self.verseNum : verseNum // ignore: cast_nullable_to_non_nullable
as int,words: null == words ? _self._words : words // ignore: cast_nullable_to_non_nullable
as List<Word>,originalVerse: freezed == originalVerse ? _self.originalVerse : originalVerse // ignore: cast_nullable_to_non_nullable
as Reference?,footnotes: freezed == footnotes ? _self._footnotes : footnotes // ignore: cast_nullable_to_non_nullable
as List<Footnote>?,
  ));
}


}

// dart format on
