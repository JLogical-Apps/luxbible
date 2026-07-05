// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notebook.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Notebook {

 String get id; String get name; ColorEnum get color; bool get isVisible;
/// Create a copy of Notebook
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotebookCopyWith<Notebook> get copyWith => _$NotebookCopyWithImpl<Notebook>(this as Notebook, _$identity);

  /// Serializes this Notebook to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Notebook&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.color, color) || other.color == color)&&(identical(other.isVisible, isVisible) || other.isVisible == isVisible));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,color,isVisible);

@override
String toString() {
  return 'Notebook(id: $id, name: $name, color: $color, isVisible: $isVisible)';
}


}

/// @nodoc
abstract mixin class $NotebookCopyWith<$Res>  {
  factory $NotebookCopyWith(Notebook value, $Res Function(Notebook) _then) = _$NotebookCopyWithImpl;
@useResult
$Res call({
 String id, String name, ColorEnum color, bool isVisible
});




}
/// @nodoc
class _$NotebookCopyWithImpl<$Res>
    implements $NotebookCopyWith<$Res> {
  _$NotebookCopyWithImpl(this._self, this._then);

  final Notebook _self;
  final $Res Function(Notebook) _then;

/// Create a copy of Notebook
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? color = null,Object? isVisible = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as ColorEnum,isVisible: null == isVisible ? _self.isVisible : isVisible // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Notebook].
extension NotebookPatterns on Notebook {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Notebook value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Notebook() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Notebook value)  $default,){
final _that = this;
switch (_that) {
case _Notebook():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Notebook value)?  $default,){
final _that = this;
switch (_that) {
case _Notebook() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  ColorEnum color,  bool isVisible)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Notebook() when $default != null:
return $default(_that.id,_that.name,_that.color,_that.isVisible);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  ColorEnum color,  bool isVisible)  $default,) {final _that = this;
switch (_that) {
case _Notebook():
return $default(_that.id,_that.name,_that.color,_that.isVisible);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  ColorEnum color,  bool isVisible)?  $default,) {final _that = this;
switch (_that) {
case _Notebook() when $default != null:
return $default(_that.id,_that.name,_that.color,_that.isVisible);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Notebook extends Notebook {
  const _Notebook({required this.id, required this.name, this.color = ColorEnum.stone, this.isVisible = true}): super._();
  factory _Notebook.fromJson(Map<String, dynamic> json) => _$NotebookFromJson(json);

@override final  String id;
@override final  String name;
@override@JsonKey() final  ColorEnum color;
@override@JsonKey() final  bool isVisible;

/// Create a copy of Notebook
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotebookCopyWith<_Notebook> get copyWith => __$NotebookCopyWithImpl<_Notebook>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotebookToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Notebook&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.color, color) || other.color == color)&&(identical(other.isVisible, isVisible) || other.isVisible == isVisible));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,color,isVisible);

@override
String toString() {
  return 'Notebook(id: $id, name: $name, color: $color, isVisible: $isVisible)';
}


}

/// @nodoc
abstract mixin class _$NotebookCopyWith<$Res> implements $NotebookCopyWith<$Res> {
  factory _$NotebookCopyWith(_Notebook value, $Res Function(_Notebook) _then) = __$NotebookCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, ColorEnum color, bool isVisible
});




}
/// @nodoc
class __$NotebookCopyWithImpl<$Res>
    implements _$NotebookCopyWith<$Res> {
  __$NotebookCopyWithImpl(this._self, this._then);

  final _Notebook _self;
  final $Res Function(_Notebook) _then;

/// Create a copy of Notebook
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? color = null,Object? isVisible = null,}) {
  return _then(_Notebook(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as ColorEnum,isVisible: null == isVisible ? _self.isVisible : isVisible // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
