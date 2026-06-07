// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'word.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Word {

@JsonKey(name: 't', includeIfNull: false) String? get text;@JsonKey(name: 'd', includeIfNull: false) InterlinearData? get data;@JsonKey(name: 'r', toJson: _onlyIfTrue, includeIfNull: false) bool get redLetters;@JsonKey(name: 'i', toJson: _onlyIfTrue, includeIfNull: false) bool get italic;
/// Create a copy of Word
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WordCopyWith<Word> get copyWith => _$WordCopyWithImpl<Word>(this as Word, _$identity);

  /// Serializes this Word to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Word&&(identical(other.text, text) || other.text == text)&&(identical(other.data, data) || other.data == data)&&(identical(other.redLetters, redLetters) || other.redLetters == redLetters)&&(identical(other.italic, italic) || other.italic == italic));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text,data,redLetters,italic);

@override
String toString() {
  return 'Word(text: $text, data: $data, redLetters: $redLetters, italic: $italic)';
}


}

/// @nodoc
abstract mixin class $WordCopyWith<$Res>  {
  factory $WordCopyWith(Word value, $Res Function(Word) _then) = _$WordCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 't', includeIfNull: false) String? text,@JsonKey(name: 'd', includeIfNull: false) InterlinearData? data,@JsonKey(name: 'r', toJson: _onlyIfTrue, includeIfNull: false) bool redLetters,@JsonKey(name: 'i', toJson: _onlyIfTrue, includeIfNull: false) bool italic
});


$InterlinearDataCopyWith<$Res>? get data;

}
/// @nodoc
class _$WordCopyWithImpl<$Res>
    implements $WordCopyWith<$Res> {
  _$WordCopyWithImpl(this._self, this._then);

  final Word _self;
  final $Res Function(Word) _then;

/// Create a copy of Word
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? text = freezed,Object? data = freezed,Object? redLetters = null,Object? italic = null,}) {
  return _then(_self.copyWith(
text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as InterlinearData?,redLetters: null == redLetters ? _self.redLetters : redLetters // ignore: cast_nullable_to_non_nullable
as bool,italic: null == italic ? _self.italic : italic // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of Word
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$InterlinearDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $InterlinearDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [Word].
extension WordPatterns on Word {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Word value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Word() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Word value)  $default,){
final _that = this;
switch (_that) {
case _Word():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Word value)?  $default,){
final _that = this;
switch (_that) {
case _Word() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 't', includeIfNull: false)  String? text, @JsonKey(name: 'd', includeIfNull: false)  InterlinearData? data, @JsonKey(name: 'r', toJson: _onlyIfTrue, includeIfNull: false)  bool redLetters, @JsonKey(name: 'i', toJson: _onlyIfTrue, includeIfNull: false)  bool italic)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Word() when $default != null:
return $default(_that.text,_that.data,_that.redLetters,_that.italic);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 't', includeIfNull: false)  String? text, @JsonKey(name: 'd', includeIfNull: false)  InterlinearData? data, @JsonKey(name: 'r', toJson: _onlyIfTrue, includeIfNull: false)  bool redLetters, @JsonKey(name: 'i', toJson: _onlyIfTrue, includeIfNull: false)  bool italic)  $default,) {final _that = this;
switch (_that) {
case _Word():
return $default(_that.text,_that.data,_that.redLetters,_that.italic);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 't', includeIfNull: false)  String? text, @JsonKey(name: 'd', includeIfNull: false)  InterlinearData? data, @JsonKey(name: 'r', toJson: _onlyIfTrue, includeIfNull: false)  bool redLetters, @JsonKey(name: 'i', toJson: _onlyIfTrue, includeIfNull: false)  bool italic)?  $default,) {final _that = this;
switch (_that) {
case _Word() when $default != null:
return $default(_that.text,_that.data,_that.redLetters,_that.italic);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Word implements Word {
  const _Word({@JsonKey(name: 't', includeIfNull: false) this.text, @JsonKey(name: 'd', includeIfNull: false) this.data, @JsonKey(name: 'r', toJson: _onlyIfTrue, includeIfNull: false) this.redLetters = false, @JsonKey(name: 'i', toJson: _onlyIfTrue, includeIfNull: false) this.italic = false});
  factory _Word.fromJson(Map<String, dynamic> json) => _$WordFromJson(json);

@override@JsonKey(name: 't', includeIfNull: false) final  String? text;
@override@JsonKey(name: 'd', includeIfNull: false) final  InterlinearData? data;
@override@JsonKey(name: 'r', toJson: _onlyIfTrue, includeIfNull: false) final  bool redLetters;
@override@JsonKey(name: 'i', toJson: _onlyIfTrue, includeIfNull: false) final  bool italic;

/// Create a copy of Word
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WordCopyWith<_Word> get copyWith => __$WordCopyWithImpl<_Word>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WordToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Word&&(identical(other.text, text) || other.text == text)&&(identical(other.data, data) || other.data == data)&&(identical(other.redLetters, redLetters) || other.redLetters == redLetters)&&(identical(other.italic, italic) || other.italic == italic));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text,data,redLetters,italic);

@override
String toString() {
  return 'Word(text: $text, data: $data, redLetters: $redLetters, italic: $italic)';
}


}

/// @nodoc
abstract mixin class _$WordCopyWith<$Res> implements $WordCopyWith<$Res> {
  factory _$WordCopyWith(_Word value, $Res Function(_Word) _then) = __$WordCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 't', includeIfNull: false) String? text,@JsonKey(name: 'd', includeIfNull: false) InterlinearData? data,@JsonKey(name: 'r', toJson: _onlyIfTrue, includeIfNull: false) bool redLetters,@JsonKey(name: 'i', toJson: _onlyIfTrue, includeIfNull: false) bool italic
});


@override $InterlinearDataCopyWith<$Res>? get data;

}
/// @nodoc
class __$WordCopyWithImpl<$Res>
    implements _$WordCopyWith<$Res> {
  __$WordCopyWithImpl(this._self, this._then);

  final _Word _self;
  final $Res Function(_Word) _then;

/// Create a copy of Word
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? text = freezed,Object? data = freezed,Object? redLetters = null,Object? italic = null,}) {
  return _then(_Word(
text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as InterlinearData?,redLetters: null == redLetters ? _self.redLetters : redLetters // ignore: cast_nullable_to_non_nullable
as bool,italic: null == italic ? _self.italic : italic // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of Word
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$InterlinearDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $InterlinearDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

// dart format on
