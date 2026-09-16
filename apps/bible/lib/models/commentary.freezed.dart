// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'commentary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CommentaryBook {

@JsonKey(name: 'i') List<CommentaryContent> get introduction;@JsonKey(name: 'c') Map<int, List<CommentaryBlock>> get blocksByChapter;
/// Create a copy of CommentaryBook
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommentaryBookCopyWith<CommentaryBook> get copyWith => _$CommentaryBookCopyWithImpl<CommentaryBook>(this as CommentaryBook, _$identity);

  /// Serializes this CommentaryBook to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommentaryBook&&const DeepCollectionEquality().equals(other.introduction, introduction)&&const DeepCollectionEquality().equals(other.blocksByChapter, blocksByChapter));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(introduction),const DeepCollectionEquality().hash(blocksByChapter));

@override
String toString() {
  return 'CommentaryBook(introduction: $introduction, blocksByChapter: $blocksByChapter)';
}


}

/// @nodoc
abstract mixin class $CommentaryBookCopyWith<$Res>  {
  factory $CommentaryBookCopyWith(CommentaryBook value, $Res Function(CommentaryBook) _then) = _$CommentaryBookCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'i') List<CommentaryContent> introduction,@JsonKey(name: 'c') Map<int, List<CommentaryBlock>> blocksByChapter
});




}
/// @nodoc
class _$CommentaryBookCopyWithImpl<$Res>
    implements $CommentaryBookCopyWith<$Res> {
  _$CommentaryBookCopyWithImpl(this._self, this._then);

  final CommentaryBook _self;
  final $Res Function(CommentaryBook) _then;

/// Create a copy of CommentaryBook
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? introduction = null,Object? blocksByChapter = null,}) {
  return _then(CommentaryBook(
introduction: null == introduction ? _self.introduction : introduction // ignore: cast_nullable_to_non_nullable
as List<CommentaryContent>,blocksByChapter: null == blocksByChapter ? _self.blocksByChapter : blocksByChapter // ignore: cast_nullable_to_non_nullable
as Map<int, List<CommentaryBlock>>,
  ));
}

}


/// Adds pattern-matching-related methods to [CommentaryBook].
extension CommentaryBookPatterns on CommentaryBook {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommentaryBook value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommentaryBook() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommentaryBook value)  $default,){
final _that = this;
switch (_that) {
case _CommentaryBook():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommentaryBook value)?  $default,){
final _that = this;
switch (_that) {
case _CommentaryBook() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'i')  List<CommentaryContent> introduction, @JsonKey(name: 'c')  Map<int, List<CommentaryBlock>> blocksByChapter)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommentaryBook() when $default != null:
return $default(_that.introduction,_that.blocksByChapter);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'i')  List<CommentaryContent> introduction, @JsonKey(name: 'c')  Map<int, List<CommentaryBlock>> blocksByChapter)  $default,) {final _that = this;
switch (_that) {
case _CommentaryBook():
return $default(_that.introduction,_that.blocksByChapter);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'i')  List<CommentaryContent> introduction, @JsonKey(name: 'c')  Map<int, List<CommentaryBlock>> blocksByChapter)?  $default,) {final _that = this;
switch (_that) {
case _CommentaryBook() when $default != null:
return $default(_that.introduction,_that.blocksByChapter);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CommentaryBook extends CommentaryBook {
  const _CommentaryBook({@JsonKey(name: 'i')  List<CommentaryContent> introduction = const [], @JsonKey(name: 'c')  Map<int, List<CommentaryBlock>> blocksByChapter = const {}}): _introduction = introduction,_blocksByChapter = blocksByChapter,super._();
  factory _CommentaryBook.fromJson(Map<String, dynamic> json) => _$CommentaryBookFromJson(json);

 final  List<CommentaryContent> _introduction;
@override@JsonKey(name: 'i') List<CommentaryContent> get introduction {
  if (_introduction is EqualUnmodifiableListView) return _introduction;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_introduction);
}

 final  Map<int, List<CommentaryBlock>> _blocksByChapter;
@override@JsonKey(name: 'c') Map<int, List<CommentaryBlock>> get blocksByChapter {
  if (_blocksByChapter is EqualUnmodifiableMapView) return _blocksByChapter;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_blocksByChapter);
}


/// Create a copy of CommentaryBook
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommentaryBookCopyWith<_CommentaryBook> get copyWith => __$CommentaryBookCopyWithImpl<_CommentaryBook>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommentaryBookToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommentaryBook&&const DeepCollectionEquality().equals(other._introduction, _introduction)&&const DeepCollectionEquality().equals(other._blocksByChapter, _blocksByChapter));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_introduction),const DeepCollectionEquality().hash(_blocksByChapter));

@override
String toString() {
  return 'CommentaryBook(introduction: $introduction, blocksByChapter: $blocksByChapter)';
}


}

/// @nodoc
abstract mixin class _$CommentaryBookCopyWith<$Res> implements $CommentaryBookCopyWith<$Res> {
  factory _$CommentaryBookCopyWith(_CommentaryBook value, $Res Function(_CommentaryBook) _then) = __$CommentaryBookCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'i') List<CommentaryContent> introduction,@JsonKey(name: 'c') Map<int, List<CommentaryBlock>> blocksByChapter
});




}
/// @nodoc
class __$CommentaryBookCopyWithImpl<$Res>
    implements _$CommentaryBookCopyWith<$Res> {
  __$CommentaryBookCopyWithImpl(this._self, this._then);

  final _CommentaryBook _self;
  final $Res Function(_CommentaryBook) _then;

/// Create a copy of CommentaryBook
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? introduction = null,Object? blocksByChapter = null,}) {
  return _then(_CommentaryBook(
introduction: null == introduction ? _self._introduction : introduction // ignore: cast_nullable_to_non_nullable
as List<CommentaryContent>,blocksByChapter: null == blocksByChapter ? _self._blocksByChapter : blocksByChapter // ignore: cast_nullable_to_non_nullable
as Map<int, List<CommentaryBlock>>,
  ));
}


}

CommentaryBlock _$CommentaryBlockFromJson(
  Map<String, dynamic> json
) {
        switch (json['r']) {
                  case 'o':
          return CommentaryOutline.fromJson(
            json
          );
                case 's':
          return CommentarySection.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'r',
  'CommentaryBlock',
  'Invalid union type "${json['r']}"!'
);
        }
      
}

/// @nodoc
mixin _$CommentaryBlock {



  /// Serializes this CommentaryBlock to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommentaryBlock);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CommentaryBlock()';
}


}

/// @nodoc
class $CommentaryBlockCopyWith<$Res>  {
$CommentaryBlockCopyWith(CommentaryBlock _, $Res Function(CommentaryBlock) __);
}


/// Adds pattern-matching-related methods to [CommentaryBlock].
extension CommentaryBlockPatterns on CommentaryBlock {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CommentaryOutline value)?  outline,TResult Function( CommentarySection value)?  section,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CommentaryOutline() when outline != null:
return outline(_that);case CommentarySection() when section != null:
return section(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CommentaryOutline value)  outline,required TResult Function( CommentarySection value)  section,}){
final _that = this;
switch (_that) {
case CommentaryOutline():
return outline(_that);case CommentarySection():
return section(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CommentaryOutline value)?  outline,TResult? Function( CommentarySection value)?  section,}){
final _that = this;
switch (_that) {
case CommentaryOutline() when outline != null:
return outline(_that);case CommentarySection() when section != null:
return section(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function(@JsonKey(name: 'i')  List<CommentaryOutlineItem> items)?  outline,TResult Function(@JsonKey(name: 'v')  VerseSelection selection, @JsonKey(name: 'b')  List<CommentaryContent> content)?  section,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CommentaryOutline() when outline != null:
return outline(_that.items);case CommentarySection() when section != null:
return section(_that.selection,_that.content);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function(@JsonKey(name: 'i')  List<CommentaryOutlineItem> items)  outline,required TResult Function(@JsonKey(name: 'v')  VerseSelection selection, @JsonKey(name: 'b')  List<CommentaryContent> content)  section,}) {final _that = this;
switch (_that) {
case CommentaryOutline():
return outline(_that.items);case CommentarySection():
return section(_that.selection,_that.content);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function(@JsonKey(name: 'i')  List<CommentaryOutlineItem> items)?  outline,TResult? Function(@JsonKey(name: 'v')  VerseSelection selection, @JsonKey(name: 'b')  List<CommentaryContent> content)?  section,}) {final _that = this;
switch (_that) {
case CommentaryOutline() when outline != null:
return outline(_that.items);case CommentarySection() when section != null:
return section(_that.selection,_that.content);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class CommentaryOutline extends CommentaryBlock {
  const CommentaryOutline({@JsonKey(name: 'i') required  List<CommentaryOutlineItem> items,  String? $type}): _items = items,$type = $type ?? 'o',super._();
  factory CommentaryOutline.fromJson(Map<String, dynamic> json) => _$CommentaryOutlineFromJson(json);

 final  List<CommentaryOutlineItem> _items;
@JsonKey(name: 'i') List<CommentaryOutlineItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


@JsonKey(name: 'r')
final String $type;


/// Create a copy of CommentaryBlock
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommentaryOutlineCopyWith<CommentaryOutline> get copyWith => _$CommentaryOutlineCopyWithImpl<CommentaryOutline>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommentaryOutlineToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommentaryOutline&&const DeepCollectionEquality().equals(other._items, _items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'CommentaryBlock.outline(items: $items)';
}


}

/// @nodoc
abstract mixin class $CommentaryOutlineCopyWith<$Res> implements $CommentaryBlockCopyWith<$Res> {
  factory $CommentaryOutlineCopyWith(CommentaryOutline value, $Res Function(CommentaryOutline) _then) = _$CommentaryOutlineCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'i') List<CommentaryOutlineItem> items
});




}
/// @nodoc
class _$CommentaryOutlineCopyWithImpl<$Res>
    implements $CommentaryOutlineCopyWith<$Res> {
  _$CommentaryOutlineCopyWithImpl(this._self, this._then);

  final CommentaryOutline _self;
  final $Res Function(CommentaryOutline) _then;

/// Create a copy of CommentaryBlock
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? items = null,}) {
  return _then(CommentaryOutline(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<CommentaryOutlineItem>,
  ));
}


}

/// @nodoc
@JsonSerializable()

class CommentarySection extends CommentaryBlock {
  const CommentarySection({@JsonKey(name: 'v') required this.selection, @JsonKey(name: 'b') required  List<CommentaryContent> content,  String? $type}): _content = content,$type = $type ?? 's',super._();
  factory CommentarySection.fromJson(Map<String, dynamic> json) => _$CommentarySectionFromJson(json);

@JsonKey(name: 'v') final  VerseSelection selection;
 final  List<CommentaryContent> _content;
@JsonKey(name: 'b') List<CommentaryContent> get content {
  if (_content is EqualUnmodifiableListView) return _content;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_content);
}


@JsonKey(name: 'r')
final String $type;


/// Create a copy of CommentaryBlock
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommentarySectionCopyWith<CommentarySection> get copyWith => _$CommentarySectionCopyWithImpl<CommentarySection>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommentarySectionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommentarySection&&(identical(other.selection, selection) || other.selection == selection)&&const DeepCollectionEquality().equals(other._content, _content));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,selection,const DeepCollectionEquality().hash(_content));

@override
String toString() {
  return 'CommentaryBlock.section(selection: $selection, content: $content)';
}


}

/// @nodoc
abstract mixin class $CommentarySectionCopyWith<$Res> implements $CommentaryBlockCopyWith<$Res> {
  factory $CommentarySectionCopyWith(CommentarySection value, $Res Function(CommentarySection) _then) = _$CommentarySectionCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'v') VerseSelection selection,@JsonKey(name: 'b') List<CommentaryContent> content
});




}
/// @nodoc
class _$CommentarySectionCopyWithImpl<$Res>
    implements $CommentarySectionCopyWith<$Res> {
  _$CommentarySectionCopyWithImpl(this._self, this._then);

  final CommentarySection _self;
  final $Res Function(CommentarySection) _then;

/// Create a copy of CommentaryBlock
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? selection = null,Object? content = null,}) {
  return _then(CommentarySection(
selection: null == selection ? _self.selection : selection // ignore: cast_nullable_to_non_nullable
as VerseSelection,content: null == content ? _self._content : content // ignore: cast_nullable_to_non_nullable
as List<CommentaryContent>,
  ));
}


}

CommentaryContent _$CommentaryContentFromJson(
  Map<String, dynamic> json
) {
        switch (json['r']) {
                  case 'p':
          return CommentaryParagraph.fromJson(
            json
          );
                case 't':
          return CommentaryTable.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'r',
  'CommentaryContent',
  'Invalid union type "${json['r']}"!'
);
        }
      
}

/// @nodoc
mixin _$CommentaryContent {



  /// Serializes this CommentaryContent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommentaryContent);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CommentaryContent()';
}


}

/// @nodoc
class $CommentaryContentCopyWith<$Res>  {
$CommentaryContentCopyWith(CommentaryContent _, $Res Function(CommentaryContent) __);
}


/// Adds pattern-matching-related methods to [CommentaryContent].
extension CommentaryContentPatterns on CommentaryContent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CommentaryParagraph value)?  paragraph,TResult Function( CommentaryTable value)?  table,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CommentaryParagraph() when paragraph != null:
return paragraph(_that);case CommentaryTable() when table != null:
return table(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CommentaryParagraph value)  paragraph,required TResult Function( CommentaryTable value)  table,}){
final _that = this;
switch (_that) {
case CommentaryParagraph():
return paragraph(_that);case CommentaryTable():
return table(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CommentaryParagraph value)?  paragraph,TResult? Function( CommentaryTable value)?  table,}){
final _that = this;
switch (_that) {
case CommentaryParagraph() when paragraph != null:
return paragraph(_that);case CommentaryTable() when table != null:
return table(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function(@JsonKey(name: 'x', toJson: Markdown.toJson, fromJson: Markdown.fromJson)  Markdown text, @JsonKey(name: 's')  CommentaryParagraphStyle style)?  paragraph,TResult Function(@JsonKey(name: 'w', toJson: Markdown.toJsonTable, fromJson: Markdown.fromJsonTable)  List<List<Markdown>> rows)?  table,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CommentaryParagraph() when paragraph != null:
return paragraph(_that.text,_that.style);case CommentaryTable() when table != null:
return table(_that.rows);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function(@JsonKey(name: 'x', toJson: Markdown.toJson, fromJson: Markdown.fromJson)  Markdown text, @JsonKey(name: 's')  CommentaryParagraphStyle style)  paragraph,required TResult Function(@JsonKey(name: 'w', toJson: Markdown.toJsonTable, fromJson: Markdown.fromJsonTable)  List<List<Markdown>> rows)  table,}) {final _that = this;
switch (_that) {
case CommentaryParagraph():
return paragraph(_that.text,_that.style);case CommentaryTable():
return table(_that.rows);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function(@JsonKey(name: 'x', toJson: Markdown.toJson, fromJson: Markdown.fromJson)  Markdown text, @JsonKey(name: 's')  CommentaryParagraphStyle style)?  paragraph,TResult? Function(@JsonKey(name: 'w', toJson: Markdown.toJsonTable, fromJson: Markdown.fromJsonTable)  List<List<Markdown>> rows)?  table,}) {final _that = this;
switch (_that) {
case CommentaryParagraph() when paragraph != null:
return paragraph(_that.text,_that.style);case CommentaryTable() when table != null:
return table(_that.rows);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class CommentaryParagraph implements CommentaryContent {
  const CommentaryParagraph({@JsonKey(name: 'x', toJson: Markdown.toJson, fromJson: Markdown.fromJson) required this.text, @JsonKey(name: 's') this.style = CommentaryParagraphStyle.body,  String? $type}): $type = $type ?? 'p';
  factory CommentaryParagraph.fromJson(Map<String, dynamic> json) => _$CommentaryParagraphFromJson(json);

@JsonKey(name: 'x', toJson: Markdown.toJson, fromJson: Markdown.fromJson) final  Markdown text;
@JsonKey(name: 's') final  CommentaryParagraphStyle style;

@JsonKey(name: 'r')
final String $type;


/// Create a copy of CommentaryContent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommentaryParagraphCopyWith<CommentaryParagraph> get copyWith => _$CommentaryParagraphCopyWithImpl<CommentaryParagraph>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommentaryParagraphToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommentaryParagraph&&(identical(other.text, text) || other.text == text)&&(identical(other.style, style) || other.style == style));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text,style);

@override
String toString() {
  return 'CommentaryContent.paragraph(text: $text, style: $style)';
}


}

/// @nodoc
abstract mixin class $CommentaryParagraphCopyWith<$Res> implements $CommentaryContentCopyWith<$Res> {
  factory $CommentaryParagraphCopyWith(CommentaryParagraph value, $Res Function(CommentaryParagraph) _then) = _$CommentaryParagraphCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'x', toJson: Markdown.toJson, fromJson: Markdown.fromJson) Markdown text,@JsonKey(name: 's') CommentaryParagraphStyle style
});




}
/// @nodoc
class _$CommentaryParagraphCopyWithImpl<$Res>
    implements $CommentaryParagraphCopyWith<$Res> {
  _$CommentaryParagraphCopyWithImpl(this._self, this._then);

  final CommentaryParagraph _self;
  final $Res Function(CommentaryParagraph) _then;

/// Create a copy of CommentaryContent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? text = null,Object? style = null,}) {
  return _then(CommentaryParagraph(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as Markdown,style: null == style ? _self.style : style // ignore: cast_nullable_to_non_nullable
as CommentaryParagraphStyle,
  ));
}


}

/// @nodoc
@JsonSerializable()

class CommentaryTable implements CommentaryContent {
  const CommentaryTable({@JsonKey(name: 'w', toJson: Markdown.toJsonTable, fromJson: Markdown.fromJsonTable) required  List<List<Markdown>> rows,  String? $type}): _rows = rows,$type = $type ?? 't';
  factory CommentaryTable.fromJson(Map<String, dynamic> json) => _$CommentaryTableFromJson(json);

 final  List<List<Markdown>> _rows;
@JsonKey(name: 'w', toJson: Markdown.toJsonTable, fromJson: Markdown.fromJsonTable) List<List<Markdown>> get rows {
  if (_rows is EqualUnmodifiableListView) return _rows;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rows);
}


@JsonKey(name: 'r')
final String $type;


/// Create a copy of CommentaryContent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommentaryTableCopyWith<CommentaryTable> get copyWith => _$CommentaryTableCopyWithImpl<CommentaryTable>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommentaryTableToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommentaryTable&&const DeepCollectionEquality().equals(other._rows, _rows));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_rows));

@override
String toString() {
  return 'CommentaryContent.table(rows: $rows)';
}


}

/// @nodoc
abstract mixin class $CommentaryTableCopyWith<$Res> implements $CommentaryContentCopyWith<$Res> {
  factory $CommentaryTableCopyWith(CommentaryTable value, $Res Function(CommentaryTable) _then) = _$CommentaryTableCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'w', toJson: Markdown.toJsonTable, fromJson: Markdown.fromJsonTable) List<List<Markdown>> rows
});




}
/// @nodoc
class _$CommentaryTableCopyWithImpl<$Res>
    implements $CommentaryTableCopyWith<$Res> {
  _$CommentaryTableCopyWithImpl(this._self, this._then);

  final CommentaryTable _self;
  final $Res Function(CommentaryTable) _then;

/// Create a copy of CommentaryContent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? rows = null,}) {
  return _then(CommentaryTable(
rows: null == rows ? _self._rows : rows // ignore: cast_nullable_to_non_nullable
as List<List<Markdown>>,
  ));
}


}


/// @nodoc
mixin _$CommentaryOutlineItem {

@JsonKey(name: 'v') VerseSelection get selection;@JsonKey(name: 'x', toJson: Markdown.toJson, fromJson: Markdown.fromJson) Markdown get text;
/// Create a copy of CommentaryOutlineItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommentaryOutlineItemCopyWith<CommentaryOutlineItem> get copyWith => _$CommentaryOutlineItemCopyWithImpl<CommentaryOutlineItem>(this as CommentaryOutlineItem, _$identity);

  /// Serializes this CommentaryOutlineItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommentaryOutlineItem&&(identical(other.selection, selection) || other.selection == selection)&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,selection,text);

@override
String toString() {
  return 'CommentaryOutlineItem(selection: $selection, text: $text)';
}


}

/// @nodoc
abstract mixin class $CommentaryOutlineItemCopyWith<$Res>  {
  factory $CommentaryOutlineItemCopyWith(CommentaryOutlineItem value, $Res Function(CommentaryOutlineItem) _then) = _$CommentaryOutlineItemCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'v') VerseSelection selection,@JsonKey(name: 'x', toJson: Markdown.toJson, fromJson: Markdown.fromJson) Markdown text
});




}
/// @nodoc
class _$CommentaryOutlineItemCopyWithImpl<$Res>
    implements $CommentaryOutlineItemCopyWith<$Res> {
  _$CommentaryOutlineItemCopyWithImpl(this._self, this._then);

  final CommentaryOutlineItem _self;
  final $Res Function(CommentaryOutlineItem) _then;

/// Create a copy of CommentaryOutlineItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? selection = null,Object? text = null,}) {
  return _then(CommentaryOutlineItem(
selection: null == selection ? _self.selection : selection // ignore: cast_nullable_to_non_nullable
as VerseSelection,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as Markdown,
  ));
}

}


/// Adds pattern-matching-related methods to [CommentaryOutlineItem].
extension CommentaryOutlineItemPatterns on CommentaryOutlineItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommentaryOutlineItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommentaryOutlineItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommentaryOutlineItem value)  $default,){
final _that = this;
switch (_that) {
case _CommentaryOutlineItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommentaryOutlineItem value)?  $default,){
final _that = this;
switch (_that) {
case _CommentaryOutlineItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'v')  VerseSelection selection, @JsonKey(name: 'x', toJson: Markdown.toJson, fromJson: Markdown.fromJson)  Markdown text)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommentaryOutlineItem() when $default != null:
return $default(_that.selection,_that.text);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'v')  VerseSelection selection, @JsonKey(name: 'x', toJson: Markdown.toJson, fromJson: Markdown.fromJson)  Markdown text)  $default,) {final _that = this;
switch (_that) {
case _CommentaryOutlineItem():
return $default(_that.selection,_that.text);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'v')  VerseSelection selection, @JsonKey(name: 'x', toJson: Markdown.toJson, fromJson: Markdown.fromJson)  Markdown text)?  $default,) {final _that = this;
switch (_that) {
case _CommentaryOutlineItem() when $default != null:
return $default(_that.selection,_that.text);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CommentaryOutlineItem implements CommentaryOutlineItem {
  const _CommentaryOutlineItem({@JsonKey(name: 'v') required this.selection, @JsonKey(name: 'x', toJson: Markdown.toJson, fromJson: Markdown.fromJson) required this.text});
  factory _CommentaryOutlineItem.fromJson(Map<String, dynamic> json) => _$CommentaryOutlineItemFromJson(json);

@override@JsonKey(name: 'v') final  VerseSelection selection;
@override@JsonKey(name: 'x', toJson: Markdown.toJson, fromJson: Markdown.fromJson) final  Markdown text;

/// Create a copy of CommentaryOutlineItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommentaryOutlineItemCopyWith<_CommentaryOutlineItem> get copyWith => __$CommentaryOutlineItemCopyWithImpl<_CommentaryOutlineItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommentaryOutlineItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommentaryOutlineItem&&(identical(other.selection, selection) || other.selection == selection)&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,selection,text);

@override
String toString() {
  return 'CommentaryOutlineItem(selection: $selection, text: $text)';
}


}

/// @nodoc
abstract mixin class _$CommentaryOutlineItemCopyWith<$Res> implements $CommentaryOutlineItemCopyWith<$Res> {
  factory _$CommentaryOutlineItemCopyWith(_CommentaryOutlineItem value, $Res Function(_CommentaryOutlineItem) _then) = __$CommentaryOutlineItemCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'v') VerseSelection selection,@JsonKey(name: 'x', toJson: Markdown.toJson, fromJson: Markdown.fromJson) Markdown text
});




}
/// @nodoc
class __$CommentaryOutlineItemCopyWithImpl<$Res>
    implements _$CommentaryOutlineItemCopyWith<$Res> {
  __$CommentaryOutlineItemCopyWithImpl(this._self, this._then);

  final _CommentaryOutlineItem _self;
  final $Res Function(_CommentaryOutlineItem) _then;

/// Create a copy of CommentaryOutlineItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? selection = null,Object? text = null,}) {
  return _then(_CommentaryOutlineItem(
selection: null == selection ? _self.selection : selection // ignore: cast_nullable_to_non_nullable
as VerseSelection,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as Markdown,
  ));
}


}

// dart format on
