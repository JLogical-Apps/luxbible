// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'article.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Article {

@JsonKey(name: 'i') String get id;@JsonKey(name: 't') String get title;@JsonKey(name: 'b') List<CommentaryContent> get body;@JsonKey(name: 'p') List<VerseSelection> get passages;
/// Create a copy of Article
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ArticleCopyWith<Article> get copyWith => _$ArticleCopyWithImpl<Article>(this as Article, _$identity);

  /// Serializes this Article to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Article&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.body, body)&&const DeepCollectionEquality().equals(other.passages, passages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,const DeepCollectionEquality().hash(body),const DeepCollectionEquality().hash(passages));

@override
String toString() {
  return 'Article(id: $id, title: $title, body: $body, passages: $passages)';
}


}

/// @nodoc
abstract mixin class $ArticleCopyWith<$Res>  {
  factory $ArticleCopyWith(Article value, $Res Function(Article) _then) = _$ArticleCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'i') String id,@JsonKey(name: 't') String title,@JsonKey(name: 'b') List<CommentaryContent> body,@JsonKey(name: 'p') List<VerseSelection> passages
});




}
/// @nodoc
class _$ArticleCopyWithImpl<$Res>
    implements $ArticleCopyWith<$Res> {
  _$ArticleCopyWithImpl(this._self, this._then);

  final Article _self;
  final $Res Function(Article) _then;

/// Create a copy of Article
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? body = null,Object? passages = null,}) {
  return _then(Article(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as List<CommentaryContent>,passages: null == passages ? _self.passages : passages // ignore: cast_nullable_to_non_nullable
as List<VerseSelection>,
  ));
}

}


/// Adds pattern-matching-related methods to [Article].
extension ArticlePatterns on Article {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Article value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Article() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Article value)  $default,){
final _that = this;
switch (_that) {
case _Article():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Article value)?  $default,){
final _that = this;
switch (_that) {
case _Article() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'i')  String id, @JsonKey(name: 't')  String title, @JsonKey(name: 'b')  List<CommentaryContent> body, @JsonKey(name: 'p')  List<VerseSelection> passages)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Article() when $default != null:
return $default(_that.id,_that.title,_that.body,_that.passages);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'i')  String id, @JsonKey(name: 't')  String title, @JsonKey(name: 'b')  List<CommentaryContent> body, @JsonKey(name: 'p')  List<VerseSelection> passages)  $default,) {final _that = this;
switch (_that) {
case _Article():
return $default(_that.id,_that.title,_that.body,_that.passages);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'i')  String id, @JsonKey(name: 't')  String title, @JsonKey(name: 'b')  List<CommentaryContent> body, @JsonKey(name: 'p')  List<VerseSelection> passages)?  $default,) {final _that = this;
switch (_that) {
case _Article() when $default != null:
return $default(_that.id,_that.title,_that.body,_that.passages);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Article extends Article {
  const _Article({@JsonKey(name: 'i') required this.id, @JsonKey(name: 't') required this.title, @JsonKey(name: 'b') required  List<CommentaryContent> body, @JsonKey(name: 'p') required  List<VerseSelection> passages}): _body = body,_passages = passages,super._();
  factory _Article.fromJson(Map<String, dynamic> json) => _$ArticleFromJson(json);

@override@JsonKey(name: 'i') final  String id;
@override@JsonKey(name: 't') final  String title;
 final  List<CommentaryContent> _body;
@override@JsonKey(name: 'b') List<CommentaryContent> get body {
  if (_body is EqualUnmodifiableListView) return _body;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_body);
}

 final  List<VerseSelection> _passages;
@override@JsonKey(name: 'p') List<VerseSelection> get passages {
  if (_passages is EqualUnmodifiableListView) return _passages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_passages);
}


/// Create a copy of Article
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ArticleCopyWith<_Article> get copyWith => __$ArticleCopyWithImpl<_Article>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ArticleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Article&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other._body, _body)&&const DeepCollectionEquality().equals(other._passages, _passages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,const DeepCollectionEquality().hash(_body),const DeepCollectionEquality().hash(_passages));

@override
String toString() {
  return 'Article(id: $id, title: $title, body: $body, passages: $passages)';
}


}

/// @nodoc
abstract mixin class _$ArticleCopyWith<$Res> implements $ArticleCopyWith<$Res> {
  factory _$ArticleCopyWith(_Article value, $Res Function(_Article) _then) = __$ArticleCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'i') String id,@JsonKey(name: 't') String title,@JsonKey(name: 'b') List<CommentaryContent> body,@JsonKey(name: 'p') List<VerseSelection> passages
});




}
/// @nodoc
class __$ArticleCopyWithImpl<$Res>
    implements _$ArticleCopyWith<$Res> {
  __$ArticleCopyWithImpl(this._self, this._then);

  final _Article _self;
  final $Res Function(_Article) _then;

/// Create a copy of Article
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? body = null,Object? passages = null,}) {
  return _then(_Article(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self._body : body // ignore: cast_nullable_to_non_nullable
as List<CommentaryContent>,passages: null == passages ? _self._passages : passages // ignore: cast_nullable_to_non_nullable
as List<VerseSelection>,
  ));
}


}

// dart format on
