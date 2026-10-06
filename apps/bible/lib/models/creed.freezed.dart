// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'creed.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Creed {

@JsonKey(name: 'i') String get id;@JsonKey(name: 't') String get title;@JsonKey(name: 'y') String get year;@IgnoreIfEmpty(name: 'a') List<String> get authors;@JsonKey(name: 'k') CreedType get type;@JsonKey(name: 'c') List<CreedChapter> get chapters;
/// Create a copy of Creed
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreedCopyWith<Creed> get copyWith => _$CreedCopyWithImpl<Creed>(this as Creed, _$identity);

  /// Serializes this Creed to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Creed&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.year, year) || other.year == year)&&const DeepCollectionEquality().equals(other.authors, authors)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other.chapters, chapters));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,year,const DeepCollectionEquality().hash(authors),type,const DeepCollectionEquality().hash(chapters));

@override
String toString() {
  return 'Creed(id: $id, title: $title, year: $year, authors: $authors, type: $type, chapters: $chapters)';
}


}

/// @nodoc
abstract mixin class $CreedCopyWith<$Res>  {
  factory $CreedCopyWith(Creed value, $Res Function(Creed) _then) = _$CreedCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'i') String id,@JsonKey(name: 't') String title,@JsonKey(name: 'y') String year,@IgnoreIfEmpty(name: 'a') List<String> authors,@JsonKey(name: 'k') CreedType type,@JsonKey(name: 'c') List<CreedChapter> chapters
});




}
/// @nodoc
class _$CreedCopyWithImpl<$Res>
    implements $CreedCopyWith<$Res> {
  _$CreedCopyWithImpl(this._self, this._then);

  final Creed _self;
  final $Res Function(Creed) _then;

/// Create a copy of Creed
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? year = null,Object? authors = null,Object? type = null,Object? chapters = null,}) {
  return _then(Creed(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as String,authors: null == authors ? _self.authors : authors // ignore: cast_nullable_to_non_nullable
as List<String>,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as CreedType,chapters: null == chapters ? _self.chapters : chapters // ignore: cast_nullable_to_non_nullable
as List<CreedChapter>,
  ));
}

}


/// Adds pattern-matching-related methods to [Creed].
extension CreedPatterns on Creed {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Creed value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Creed() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Creed value)  $default,){
final _that = this;
switch (_that) {
case _Creed():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Creed value)?  $default,){
final _that = this;
switch (_that) {
case _Creed() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'i')  String id, @JsonKey(name: 't')  String title, @JsonKey(name: 'y')  String year, @IgnoreIfEmpty(name: 'a')  List<String> authors, @JsonKey(name: 'k')  CreedType type, @JsonKey(name: 'c')  List<CreedChapter> chapters)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Creed() when $default != null:
return $default(_that.id,_that.title,_that.year,_that.authors,_that.type,_that.chapters);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'i')  String id, @JsonKey(name: 't')  String title, @JsonKey(name: 'y')  String year, @IgnoreIfEmpty(name: 'a')  List<String> authors, @JsonKey(name: 'k')  CreedType type, @JsonKey(name: 'c')  List<CreedChapter> chapters)  $default,) {final _that = this;
switch (_that) {
case _Creed():
return $default(_that.id,_that.title,_that.year,_that.authors,_that.type,_that.chapters);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'i')  String id, @JsonKey(name: 't')  String title, @JsonKey(name: 'y')  String year, @IgnoreIfEmpty(name: 'a')  List<String> authors, @JsonKey(name: 'k')  CreedType type, @JsonKey(name: 'c')  List<CreedChapter> chapters)?  $default,) {final _that = this;
switch (_that) {
case _Creed() when $default != null:
return $default(_that.id,_that.title,_that.year,_that.authors,_that.type,_that.chapters);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Creed extends Creed {
  const _Creed({@JsonKey(name: 'i') required this.id, @JsonKey(name: 't') required this.title, @JsonKey(name: 'y') required this.year, @IgnoreIfEmpty(name: 'a')  List<String> authors = const [], @JsonKey(name: 'k') required this.type, @JsonKey(name: 'c') required  List<CreedChapter> chapters}): _authors = authors,_chapters = chapters,super._();
  factory _Creed.fromJson(Map<String, dynamic> json) => _$CreedFromJson(json);

@override@JsonKey(name: 'i') final  String id;
@override@JsonKey(name: 't') final  String title;
@override@JsonKey(name: 'y') final  String year;
 final  List<String> _authors;
@override@IgnoreIfEmpty(name: 'a') List<String> get authors {
  if (_authors is EqualUnmodifiableListView) return _authors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_authors);
}

@override@JsonKey(name: 'k') final  CreedType type;
 final  List<CreedChapter> _chapters;
@override@JsonKey(name: 'c') List<CreedChapter> get chapters {
  if (_chapters is EqualUnmodifiableListView) return _chapters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_chapters);
}


/// Create a copy of Creed
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreedCopyWith<_Creed> get copyWith => __$CreedCopyWithImpl<_Creed>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Creed&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.year, year) || other.year == year)&&const DeepCollectionEquality().equals(other._authors, _authors)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other._chapters, _chapters));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,year,const DeepCollectionEquality().hash(_authors),type,const DeepCollectionEquality().hash(_chapters));

@override
String toString() {
  return 'Creed(id: $id, title: $title, year: $year, authors: $authors, type: $type, chapters: $chapters)';
}


}

/// @nodoc
abstract mixin class _$CreedCopyWith<$Res> implements $CreedCopyWith<$Res> {
  factory _$CreedCopyWith(_Creed value, $Res Function(_Creed) _then) = __$CreedCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'i') String id,@JsonKey(name: 't') String title,@JsonKey(name: 'y') String year,@IgnoreIfEmpty(name: 'a') List<String> authors,@JsonKey(name: 'k') CreedType type,@JsonKey(name: 'c') List<CreedChapter> chapters
});




}
/// @nodoc
class __$CreedCopyWithImpl<$Res>
    implements _$CreedCopyWith<$Res> {
  __$CreedCopyWithImpl(this._self, this._then);

  final _Creed _self;
  final $Res Function(_Creed) _then;

/// Create a copy of Creed
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? year = null,Object? authors = null,Object? type = null,Object? chapters = null,}) {
  return _then(_Creed(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as String,authors: null == authors ? _self._authors : authors // ignore: cast_nullable_to_non_nullable
as List<String>,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as CreedType,chapters: null == chapters ? _self._chapters : chapters // ignore: cast_nullable_to_non_nullable
as List<CreedChapter>,
  ));
}


}


/// @nodoc
mixin _$CreedChapter {

@JsonKey(name: 'n', includeIfNull: false) String? get number;@JsonKey(name: 't', includeIfNull: false) String? get title;@JsonKey(name: 'i') List<CreedItem> get items;
/// Create a copy of CreedChapter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreedChapterCopyWith<CreedChapter> get copyWith => _$CreedChapterCopyWithImpl<CreedChapter>(this as CreedChapter, _$identity);

  /// Serializes this CreedChapter to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreedChapter&&(identical(other.number, number) || other.number == number)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.items, items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,number,title,const DeepCollectionEquality().hash(items));

@override
String toString() {
  return 'CreedChapter(number: $number, title: $title, items: $items)';
}


}

/// @nodoc
abstract mixin class $CreedChapterCopyWith<$Res>  {
  factory $CreedChapterCopyWith(CreedChapter value, $Res Function(CreedChapter) _then) = _$CreedChapterCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'n', includeIfNull: false) String? number,@JsonKey(name: 't', includeIfNull: false) String? title,@JsonKey(name: 'i') List<CreedItem> items
});




}
/// @nodoc
class _$CreedChapterCopyWithImpl<$Res>
    implements $CreedChapterCopyWith<$Res> {
  _$CreedChapterCopyWithImpl(this._self, this._then);

  final CreedChapter _self;
  final $Res Function(CreedChapter) _then;

/// Create a copy of CreedChapter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? number = freezed,Object? title = freezed,Object? items = null,}) {
  return _then(CreedChapter(
number: freezed == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<CreedItem>,
  ));
}

}


/// Adds pattern-matching-related methods to [CreedChapter].
extension CreedChapterPatterns on CreedChapter {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreedChapter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreedChapter() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreedChapter value)  $default,){
final _that = this;
switch (_that) {
case _CreedChapter():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreedChapter value)?  $default,){
final _that = this;
switch (_that) {
case _CreedChapter() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'n', includeIfNull: false)  String? number, @JsonKey(name: 't', includeIfNull: false)  String? title, @JsonKey(name: 'i')  List<CreedItem> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreedChapter() when $default != null:
return $default(_that.number,_that.title,_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'n', includeIfNull: false)  String? number, @JsonKey(name: 't', includeIfNull: false)  String? title, @JsonKey(name: 'i')  List<CreedItem> items)  $default,) {final _that = this;
switch (_that) {
case _CreedChapter():
return $default(_that.number,_that.title,_that.items);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'n', includeIfNull: false)  String? number, @JsonKey(name: 't', includeIfNull: false)  String? title, @JsonKey(name: 'i')  List<CreedItem> items)?  $default,) {final _that = this;
switch (_that) {
case _CreedChapter() when $default != null:
return $default(_that.number,_that.title,_that.items);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreedChapter extends CreedChapter {
  const _CreedChapter({@JsonKey(name: 'n', includeIfNull: false) this.number, @JsonKey(name: 't', includeIfNull: false) this.title, @JsonKey(name: 'i') required  List<CreedItem> items}): _items = items,super._();
  factory _CreedChapter.fromJson(Map<String, dynamic> json) => _$CreedChapterFromJson(json);

@override@JsonKey(name: 'n', includeIfNull: false) final  String? number;
@override@JsonKey(name: 't', includeIfNull: false) final  String? title;
 final  List<CreedItem> _items;
@override@JsonKey(name: 'i') List<CreedItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of CreedChapter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreedChapterCopyWith<_CreedChapter> get copyWith => __$CreedChapterCopyWithImpl<_CreedChapter>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreedChapterToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreedChapter&&(identical(other.number, number) || other.number == number)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other._items, _items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,number,title,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'CreedChapter(number: $number, title: $title, items: $items)';
}


}

/// @nodoc
abstract mixin class _$CreedChapterCopyWith<$Res> implements $CreedChapterCopyWith<$Res> {
  factory _$CreedChapterCopyWith(_CreedChapter value, $Res Function(_CreedChapter) _then) = __$CreedChapterCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'n', includeIfNull: false) String? number,@JsonKey(name: 't', includeIfNull: false) String? title,@JsonKey(name: 'i') List<CreedItem> items
});




}
/// @nodoc
class __$CreedChapterCopyWithImpl<$Res>
    implements _$CreedChapterCopyWith<$Res> {
  __$CreedChapterCopyWithImpl(this._self, this._then);

  final _CreedChapter _self;
  final $Res Function(_CreedChapter) _then;

/// Create a copy of CreedChapter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? number = freezed,Object? title = freezed,Object? items = null,}) {
  return _then(_CreedChapter(
number: freezed == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<CreedItem>,
  ));
}


}


/// @nodoc
mixin _$CreedItem {

@JsonKey(name: 'n', includeIfNull: false) String? get number;@JsonKey(name: 't', includeIfNull: false) String? get title;@JsonKey(name: 'b') List<RichContent> get body;@IgnoreIfEmpty(name: 'p') List<VerseSelection> get passages;
/// Create a copy of CreedItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreedItemCopyWith<CreedItem> get copyWith => _$CreedItemCopyWithImpl<CreedItem>(this as CreedItem, _$identity);

  /// Serializes this CreedItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreedItem&&(identical(other.number, number) || other.number == number)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.body, body)&&const DeepCollectionEquality().equals(other.passages, passages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,number,title,const DeepCollectionEquality().hash(body),const DeepCollectionEquality().hash(passages));

@override
String toString() {
  return 'CreedItem(number: $number, title: $title, body: $body, passages: $passages)';
}


}

/// @nodoc
abstract mixin class $CreedItemCopyWith<$Res>  {
  factory $CreedItemCopyWith(CreedItem value, $Res Function(CreedItem) _then) = _$CreedItemCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'n', includeIfNull: false) String? number,@JsonKey(name: 't', includeIfNull: false) String? title,@JsonKey(name: 'b') List<RichContent> body,@IgnoreIfEmpty(name: 'p') List<VerseSelection> passages
});




}
/// @nodoc
class _$CreedItemCopyWithImpl<$Res>
    implements $CreedItemCopyWith<$Res> {
  _$CreedItemCopyWithImpl(this._self, this._then);

  final CreedItem _self;
  final $Res Function(CreedItem) _then;

/// Create a copy of CreedItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? number = freezed,Object? title = freezed,Object? body = null,Object? passages = null,}) {
  return _then(CreedItem(
number: freezed == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as List<RichContent>,passages: null == passages ? _self.passages : passages // ignore: cast_nullable_to_non_nullable
as List<VerseSelection>,
  ));
}

}


/// Adds pattern-matching-related methods to [CreedItem].
extension CreedItemPatterns on CreedItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreedItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreedItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreedItem value)  $default,){
final _that = this;
switch (_that) {
case _CreedItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreedItem value)?  $default,){
final _that = this;
switch (_that) {
case _CreedItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'n', includeIfNull: false)  String? number, @JsonKey(name: 't', includeIfNull: false)  String? title, @JsonKey(name: 'b')  List<RichContent> body, @IgnoreIfEmpty(name: 'p')  List<VerseSelection> passages)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreedItem() when $default != null:
return $default(_that.number,_that.title,_that.body,_that.passages);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'n', includeIfNull: false)  String? number, @JsonKey(name: 't', includeIfNull: false)  String? title, @JsonKey(name: 'b')  List<RichContent> body, @IgnoreIfEmpty(name: 'p')  List<VerseSelection> passages)  $default,) {final _that = this;
switch (_that) {
case _CreedItem():
return $default(_that.number,_that.title,_that.body,_that.passages);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'n', includeIfNull: false)  String? number, @JsonKey(name: 't', includeIfNull: false)  String? title, @JsonKey(name: 'b')  List<RichContent> body, @IgnoreIfEmpty(name: 'p')  List<VerseSelection> passages)?  $default,) {final _that = this;
switch (_that) {
case _CreedItem() when $default != null:
return $default(_that.number,_that.title,_that.body,_that.passages);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreedItem extends CreedItem {
  const _CreedItem({@JsonKey(name: 'n', includeIfNull: false) this.number, @JsonKey(name: 't', includeIfNull: false) this.title, @JsonKey(name: 'b') required  List<RichContent> body, @IgnoreIfEmpty(name: 'p')  List<VerseSelection> passages = const []}): _body = body,_passages = passages,super._();
  factory _CreedItem.fromJson(Map<String, dynamic> json) => _$CreedItemFromJson(json);

@override@JsonKey(name: 'n', includeIfNull: false) final  String? number;
@override@JsonKey(name: 't', includeIfNull: false) final  String? title;
 final  List<RichContent> _body;
@override@JsonKey(name: 'b') List<RichContent> get body {
  if (_body is EqualUnmodifiableListView) return _body;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_body);
}

 final  List<VerseSelection> _passages;
@override@IgnoreIfEmpty(name: 'p') List<VerseSelection> get passages {
  if (_passages is EqualUnmodifiableListView) return _passages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_passages);
}


/// Create a copy of CreedItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreedItemCopyWith<_CreedItem> get copyWith => __$CreedItemCopyWithImpl<_CreedItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreedItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreedItem&&(identical(other.number, number) || other.number == number)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other._body, _body)&&const DeepCollectionEquality().equals(other._passages, _passages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,number,title,const DeepCollectionEquality().hash(_body),const DeepCollectionEquality().hash(_passages));

@override
String toString() {
  return 'CreedItem(number: $number, title: $title, body: $body, passages: $passages)';
}


}

/// @nodoc
abstract mixin class _$CreedItemCopyWith<$Res> implements $CreedItemCopyWith<$Res> {
  factory _$CreedItemCopyWith(_CreedItem value, $Res Function(_CreedItem) _then) = __$CreedItemCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'n', includeIfNull: false) String? number,@JsonKey(name: 't', includeIfNull: false) String? title,@JsonKey(name: 'b') List<RichContent> body,@IgnoreIfEmpty(name: 'p') List<VerseSelection> passages
});




}
/// @nodoc
class __$CreedItemCopyWithImpl<$Res>
    implements _$CreedItemCopyWith<$Res> {
  __$CreedItemCopyWithImpl(this._self, this._then);

  final _CreedItem _self;
  final $Res Function(_CreedItem) _then;

/// Create a copy of CreedItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? number = freezed,Object? title = freezed,Object? body = null,Object? passages = null,}) {
  return _then(_CreedItem(
number: freezed == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,body: null == body ? _self._body : body // ignore: cast_nullable_to_non_nullable
as List<RichContent>,passages: null == passages ? _self._passages : passages // ignore: cast_nullable_to_non_nullable
as List<VerseSelection>,
  ));
}


}

// dart format on
