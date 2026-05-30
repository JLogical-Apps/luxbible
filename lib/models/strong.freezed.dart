// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'strong.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Strong {

@JsonKey(name: 'i') String get id;@JsonKey(name: 'l') String get languageText;@JsonKey(name: 'p') String get pronunciation;@JsonKey(name: 'x') String get transliteration;@JsonKey(name: 'd') String get definition;@JsonKey(name: 'g') List<String> get glossary;
/// Create a copy of Strong
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StrongCopyWith<Strong> get copyWith => _$StrongCopyWithImpl<Strong>(this as Strong, _$identity);

  /// Serializes this Strong to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Strong&&(identical(other.id, id) || other.id == id)&&(identical(other.languageText, languageText) || other.languageText == languageText)&&(identical(other.pronunciation, pronunciation) || other.pronunciation == pronunciation)&&(identical(other.transliteration, transliteration) || other.transliteration == transliteration)&&(identical(other.definition, definition) || other.definition == definition)&&const DeepCollectionEquality().equals(other.glossary, glossary));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,languageText,pronunciation,transliteration,definition,const DeepCollectionEquality().hash(glossary));

@override
String toString() {
  return 'Strong(id: $id, languageText: $languageText, pronunciation: $pronunciation, transliteration: $transliteration, definition: $definition, glossary: $glossary)';
}


}

/// @nodoc
abstract mixin class $StrongCopyWith<$Res>  {
  factory $StrongCopyWith(Strong value, $Res Function(Strong) _then) = _$StrongCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'i') String id,@JsonKey(name: 'l') String languageText,@JsonKey(name: 'p') String pronunciation,@JsonKey(name: 'x') String transliteration,@JsonKey(name: 'd') String definition,@JsonKey(name: 'g') List<String> glossary
});




}
/// @nodoc
class _$StrongCopyWithImpl<$Res>
    implements $StrongCopyWith<$Res> {
  _$StrongCopyWithImpl(this._self, this._then);

  final Strong _self;
  final $Res Function(Strong) _then;

/// Create a copy of Strong
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? languageText = null,Object? pronunciation = null,Object? transliteration = null,Object? definition = null,Object? glossary = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,languageText: null == languageText ? _self.languageText : languageText // ignore: cast_nullable_to_non_nullable
as String,pronunciation: null == pronunciation ? _self.pronunciation : pronunciation // ignore: cast_nullable_to_non_nullable
as String,transliteration: null == transliteration ? _self.transliteration : transliteration // ignore: cast_nullable_to_non_nullable
as String,definition: null == definition ? _self.definition : definition // ignore: cast_nullable_to_non_nullable
as String,glossary: null == glossary ? _self.glossary : glossary // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [Strong].
extension StrongPatterns on Strong {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Strong value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Strong() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Strong value)  $default,){
final _that = this;
switch (_that) {
case _Strong():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Strong value)?  $default,){
final _that = this;
switch (_that) {
case _Strong() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'i')  String id, @JsonKey(name: 'l')  String languageText, @JsonKey(name: 'p')  String pronunciation, @JsonKey(name: 'x')  String transliteration, @JsonKey(name: 'd')  String definition, @JsonKey(name: 'g')  List<String> glossary)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Strong() when $default != null:
return $default(_that.id,_that.languageText,_that.pronunciation,_that.transliteration,_that.definition,_that.glossary);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'i')  String id, @JsonKey(name: 'l')  String languageText, @JsonKey(name: 'p')  String pronunciation, @JsonKey(name: 'x')  String transliteration, @JsonKey(name: 'd')  String definition, @JsonKey(name: 'g')  List<String> glossary)  $default,) {final _that = this;
switch (_that) {
case _Strong():
return $default(_that.id,_that.languageText,_that.pronunciation,_that.transliteration,_that.definition,_that.glossary);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'i')  String id, @JsonKey(name: 'l')  String languageText, @JsonKey(name: 'p')  String pronunciation, @JsonKey(name: 'x')  String transliteration, @JsonKey(name: 'd')  String definition, @JsonKey(name: 'g')  List<String> glossary)?  $default,) {final _that = this;
switch (_that) {
case _Strong() when $default != null:
return $default(_that.id,_that.languageText,_that.pronunciation,_that.transliteration,_that.definition,_that.glossary);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Strong implements Strong {
  const _Strong({@JsonKey(name: 'i') required this.id, @JsonKey(name: 'l') required this.languageText, @JsonKey(name: 'p') required this.pronunciation, @JsonKey(name: 'x') required this.transliteration, @JsonKey(name: 'd') required this.definition, @JsonKey(name: 'g') required final  List<String> glossary}): _glossary = glossary;
  factory _Strong.fromJson(Map<String, dynamic> json) => _$StrongFromJson(json);

@override@JsonKey(name: 'i') final  String id;
@override@JsonKey(name: 'l') final  String languageText;
@override@JsonKey(name: 'p') final  String pronunciation;
@override@JsonKey(name: 'x') final  String transliteration;
@override@JsonKey(name: 'd') final  String definition;
 final  List<String> _glossary;
@override@JsonKey(name: 'g') List<String> get glossary {
  if (_glossary is EqualUnmodifiableListView) return _glossary;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_glossary);
}


/// Create a copy of Strong
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StrongCopyWith<_Strong> get copyWith => __$StrongCopyWithImpl<_Strong>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StrongToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Strong&&(identical(other.id, id) || other.id == id)&&(identical(other.languageText, languageText) || other.languageText == languageText)&&(identical(other.pronunciation, pronunciation) || other.pronunciation == pronunciation)&&(identical(other.transliteration, transliteration) || other.transliteration == transliteration)&&(identical(other.definition, definition) || other.definition == definition)&&const DeepCollectionEquality().equals(other._glossary, _glossary));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,languageText,pronunciation,transliteration,definition,const DeepCollectionEquality().hash(_glossary));

@override
String toString() {
  return 'Strong(id: $id, languageText: $languageText, pronunciation: $pronunciation, transliteration: $transliteration, definition: $definition, glossary: $glossary)';
}


}

/// @nodoc
abstract mixin class _$StrongCopyWith<$Res> implements $StrongCopyWith<$Res> {
  factory _$StrongCopyWith(_Strong value, $Res Function(_Strong) _then) = __$StrongCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'i') String id,@JsonKey(name: 'l') String languageText,@JsonKey(name: 'p') String pronunciation,@JsonKey(name: 'x') String transliteration,@JsonKey(name: 'd') String definition,@JsonKey(name: 'g') List<String> glossary
});




}
/// @nodoc
class __$StrongCopyWithImpl<$Res>
    implements _$StrongCopyWith<$Res> {
  __$StrongCopyWithImpl(this._self, this._then);

  final _Strong _self;
  final $Res Function(_Strong) _then;

/// Create a copy of Strong
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? languageText = null,Object? pronunciation = null,Object? transliteration = null,Object? definition = null,Object? glossary = null,}) {
  return _then(_Strong(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,languageText: null == languageText ? _self.languageText : languageText // ignore: cast_nullable_to_non_nullable
as String,pronunciation: null == pronunciation ? _self.pronunciation : pronunciation // ignore: cast_nullable_to_non_nullable
as String,transliteration: null == transliteration ? _self.transliteration : transliteration // ignore: cast_nullable_to_non_nullable
as String,definition: null == definition ? _self.definition : definition // ignore: cast_nullable_to_non_nullable
as String,glossary: null == glossary ? _self._glossary : glossary // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
