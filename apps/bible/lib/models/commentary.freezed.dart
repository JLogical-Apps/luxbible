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

@IgnoreIfEmpty(name: 's') List<RichContent> get summary;@IgnoreIfEmpty(name: 'i') List<RichContent> get introduction;@JsonKey(name: 'c') Map<int, List<CommentaryBlock>> get blocksByChapter;
/// Create a copy of CommentaryBook
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommentaryBookCopyWith<CommentaryBook> get copyWith => _$CommentaryBookCopyWithImpl<CommentaryBook>(this as CommentaryBook, _$identity);

  /// Serializes this CommentaryBook to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommentaryBook&&const DeepCollectionEquality().equals(other.summary, summary)&&const DeepCollectionEquality().equals(other.introduction, introduction)&&const DeepCollectionEquality().equals(other.blocksByChapter, blocksByChapter));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(summary),const DeepCollectionEquality().hash(introduction),const DeepCollectionEquality().hash(blocksByChapter));

@override
String toString() {
  return 'CommentaryBook(summary: $summary, introduction: $introduction, blocksByChapter: $blocksByChapter)';
}


}

/// @nodoc
abstract mixin class $CommentaryBookCopyWith<$Res>  {
  factory $CommentaryBookCopyWith(CommentaryBook value, $Res Function(CommentaryBook) _then) = _$CommentaryBookCopyWithImpl;
@useResult
$Res call({
@IgnoreIfEmpty(name: 's') List<RichContent> summary,@IgnoreIfEmpty(name: 'i') List<RichContent> introduction,@JsonKey(name: 'c') Map<int, List<CommentaryBlock>> blocksByChapter
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
@pragma('vm:prefer-inline') @override $Res call({Object? summary = null,Object? introduction = null,Object? blocksByChapter = null,}) {
  return _then(CommentaryBook(
summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as List<RichContent>,introduction: null == introduction ? _self.introduction : introduction // ignore: cast_nullable_to_non_nullable
as List<RichContent>,blocksByChapter: null == blocksByChapter ? _self.blocksByChapter : blocksByChapter // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@IgnoreIfEmpty(name: 's')  List<RichContent> summary, @IgnoreIfEmpty(name: 'i')  List<RichContent> introduction, @JsonKey(name: 'c')  Map<int, List<CommentaryBlock>> blocksByChapter)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommentaryBook() when $default != null:
return $default(_that.summary,_that.introduction,_that.blocksByChapter);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@IgnoreIfEmpty(name: 's')  List<RichContent> summary, @IgnoreIfEmpty(name: 'i')  List<RichContent> introduction, @JsonKey(name: 'c')  Map<int, List<CommentaryBlock>> blocksByChapter)  $default,) {final _that = this;
switch (_that) {
case _CommentaryBook():
return $default(_that.summary,_that.introduction,_that.blocksByChapter);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@IgnoreIfEmpty(name: 's')  List<RichContent> summary, @IgnoreIfEmpty(name: 'i')  List<RichContent> introduction, @JsonKey(name: 'c')  Map<int, List<CommentaryBlock>> blocksByChapter)?  $default,) {final _that = this;
switch (_that) {
case _CommentaryBook() when $default != null:
return $default(_that.summary,_that.introduction,_that.blocksByChapter);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CommentaryBook extends CommentaryBook {
  const _CommentaryBook({@IgnoreIfEmpty(name: 's')  List<RichContent> summary = const [], @IgnoreIfEmpty(name: 'i')  List<RichContent> introduction = const [], @JsonKey(name: 'c')  Map<int, List<CommentaryBlock>> blocksByChapter = const {}}): _summary = summary,_introduction = introduction,_blocksByChapter = blocksByChapter,super._();
  factory _CommentaryBook.fromJson(Map<String, dynamic> json) => _$CommentaryBookFromJson(json);

 final  List<RichContent> _summary;
@override@IgnoreIfEmpty(name: 's') List<RichContent> get summary {
  if (_summary is EqualUnmodifiableListView) return _summary;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_summary);
}

 final  List<RichContent> _introduction;
@override@IgnoreIfEmpty(name: 'i') List<RichContent> get introduction {
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommentaryBook&&const DeepCollectionEquality().equals(other._summary, _summary)&&const DeepCollectionEquality().equals(other._introduction, _introduction)&&const DeepCollectionEquality().equals(other._blocksByChapter, _blocksByChapter));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_summary),const DeepCollectionEquality().hash(_introduction),const DeepCollectionEquality().hash(_blocksByChapter));

@override
String toString() {
  return 'CommentaryBook(summary: $summary, introduction: $introduction, blocksByChapter: $blocksByChapter)';
}


}

/// @nodoc
abstract mixin class _$CommentaryBookCopyWith<$Res> implements $CommentaryBookCopyWith<$Res> {
  factory _$CommentaryBookCopyWith(_CommentaryBook value, $Res Function(_CommentaryBook) _then) = __$CommentaryBookCopyWithImpl;
@override @useResult
$Res call({
@IgnoreIfEmpty(name: 's') List<RichContent> summary,@IgnoreIfEmpty(name: 'i') List<RichContent> introduction,@JsonKey(name: 'c') Map<int, List<CommentaryBlock>> blocksByChapter
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
@override @pragma('vm:prefer-inline') $Res call({Object? summary = null,Object? introduction = null,Object? blocksByChapter = null,}) {
  return _then(_CommentaryBook(
summary: null == summary ? _self._summary : summary // ignore: cast_nullable_to_non_nullable
as List<RichContent>,introduction: null == introduction ? _self._introduction : introduction // ignore: cast_nullable_to_non_nullable
as List<RichContent>,blocksByChapter: null == blocksByChapter ? _self._blocksByChapter : blocksByChapter // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function(@JsonKey(name: 'i')  List<CommentaryOutlineItem> items)?  outline,TResult Function(@JsonKey(name: 'v')  VerseSelection selection, @JsonKey(name: 'b')  List<RichContent> content)?  section,required TResult orElse(),}) {final _that = this;
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function(@JsonKey(name: 'i')  List<CommentaryOutlineItem> items)  outline,required TResult Function(@JsonKey(name: 'v')  VerseSelection selection, @JsonKey(name: 'b')  List<RichContent> content)  section,}) {final _that = this;
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function(@JsonKey(name: 'i')  List<CommentaryOutlineItem> items)?  outline,TResult? Function(@JsonKey(name: 'v')  VerseSelection selection, @JsonKey(name: 'b')  List<RichContent> content)?  section,}) {final _that = this;
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
  const CommentarySection({@JsonKey(name: 'v') required this.selection, @JsonKey(name: 'b') required  List<RichContent> content,  String? $type}): _content = content,$type = $type ?? 's',super._();
  factory CommentarySection.fromJson(Map<String, dynamic> json) => _$CommentarySectionFromJson(json);

@JsonKey(name: 'v') final  VerseSelection selection;
 final  List<RichContent> _content;
@JsonKey(name: 'b') List<RichContent> get content {
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
@JsonKey(name: 'v') VerseSelection selection,@JsonKey(name: 'b') List<RichContent> content
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
as List<RichContent>,
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
