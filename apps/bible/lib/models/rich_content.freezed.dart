// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rich_content.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
RichContent _$RichContentFromJson(
  Map<String, dynamic> json
) {
        switch (json['r']) {
                  case 'p':
          return RichParagraph.fromJson(
            json
          );
                case 't':
          return RichTable.fromJson(
            json
          );
                case 'm':
          return RichBibleMap.fromJson(
            json
          );
                case 'b':
          return RichBox.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'r',
  'RichContent',
  'Invalid union type "${json['r']}"!'
);
        }
      
}

/// @nodoc
mixin _$RichContent {



  /// Serializes this RichContent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RichContent);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RichContent()';
}


}

/// @nodoc
class $RichContentCopyWith<$Res>  {
$RichContentCopyWith(RichContent _, $Res Function(RichContent) __);
}


/// Adds pattern-matching-related methods to [RichContent].
extension RichContentPatterns on RichContent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( RichParagraph value)?  paragraph,TResult Function( RichTable value)?  table,TResult Function( RichBibleMap value)?  bibleMap,TResult Function( RichBox value)?  box,required TResult orElse(),}){
final _that = this;
switch (_that) {
case RichParagraph() when paragraph != null:
return paragraph(_that);case RichTable() when table != null:
return table(_that);case RichBibleMap() when bibleMap != null:
return bibleMap(_that);case RichBox() when box != null:
return box(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( RichParagraph value)  paragraph,required TResult Function( RichTable value)  table,required TResult Function( RichBibleMap value)  bibleMap,required TResult Function( RichBox value)  box,}){
final _that = this;
switch (_that) {
case RichParagraph():
return paragraph(_that);case RichTable():
return table(_that);case RichBibleMap():
return bibleMap(_that);case RichBox():
return box(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( RichParagraph value)?  paragraph,TResult? Function( RichTable value)?  table,TResult? Function( RichBibleMap value)?  bibleMap,TResult? Function( RichBox value)?  box,}){
final _that = this;
switch (_that) {
case RichParagraph() when paragraph != null:
return paragraph(_that);case RichTable() when table != null:
return table(_that);case RichBibleMap() when bibleMap != null:
return bibleMap(_that);case RichBox() when box != null:
return box(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function(@JsonKey(name: 'x', toJson: Markdown.toJson, fromJson: Markdown.fromJson)  Markdown text, @JsonKey(name: 's')  RichParagraphStyle style)?  paragraph,TResult Function(@JsonKey(name: 'w', toJson: Markdown.toJsonTable, fromJson: Markdown.fromJsonTable)  List<List<Markdown>> rows)?  table,TResult Function(@JsonKey(name: 'i')  String id)?  bibleMap,TResult Function(@JsonKey(name: 'h')  String title, @JsonKey(name: 'c')  List<RichContent> content)?  box,required TResult orElse(),}) {final _that = this;
switch (_that) {
case RichParagraph() when paragraph != null:
return paragraph(_that.text,_that.style);case RichTable() when table != null:
return table(_that.rows);case RichBibleMap() when bibleMap != null:
return bibleMap(_that.id);case RichBox() when box != null:
return box(_that.title,_that.content);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function(@JsonKey(name: 'x', toJson: Markdown.toJson, fromJson: Markdown.fromJson)  Markdown text, @JsonKey(name: 's')  RichParagraphStyle style)  paragraph,required TResult Function(@JsonKey(name: 'w', toJson: Markdown.toJsonTable, fromJson: Markdown.fromJsonTable)  List<List<Markdown>> rows)  table,required TResult Function(@JsonKey(name: 'i')  String id)  bibleMap,required TResult Function(@JsonKey(name: 'h')  String title, @JsonKey(name: 'c')  List<RichContent> content)  box,}) {final _that = this;
switch (_that) {
case RichParagraph():
return paragraph(_that.text,_that.style);case RichTable():
return table(_that.rows);case RichBibleMap():
return bibleMap(_that.id);case RichBox():
return box(_that.title,_that.content);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function(@JsonKey(name: 'x', toJson: Markdown.toJson, fromJson: Markdown.fromJson)  Markdown text, @JsonKey(name: 's')  RichParagraphStyle style)?  paragraph,TResult? Function(@JsonKey(name: 'w', toJson: Markdown.toJsonTable, fromJson: Markdown.fromJsonTable)  List<List<Markdown>> rows)?  table,TResult? Function(@JsonKey(name: 'i')  String id)?  bibleMap,TResult? Function(@JsonKey(name: 'h')  String title, @JsonKey(name: 'c')  List<RichContent> content)?  box,}) {final _that = this;
switch (_that) {
case RichParagraph() when paragraph != null:
return paragraph(_that.text,_that.style);case RichTable() when table != null:
return table(_that.rows);case RichBibleMap() when bibleMap != null:
return bibleMap(_that.id);case RichBox() when box != null:
return box(_that.title,_that.content);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class RichParagraph implements RichContent {
  const RichParagraph({@JsonKey(name: 'x', toJson: Markdown.toJson, fromJson: Markdown.fromJson) required this.text, @JsonKey(name: 's') this.style = RichParagraphStyle.body,  String? $type}): $type = $type ?? 'p';
  factory RichParagraph.fromJson(Map<String, dynamic> json) => _$RichParagraphFromJson(json);

@JsonKey(name: 'x', toJson: Markdown.toJson, fromJson: Markdown.fromJson) final  Markdown text;
@JsonKey(name: 's') final  RichParagraphStyle style;

@JsonKey(name: 'r')
final String $type;


/// Create a copy of RichContent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RichParagraphCopyWith<RichParagraph> get copyWith => _$RichParagraphCopyWithImpl<RichParagraph>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RichParagraphToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RichParagraph&&(identical(other.text, text) || other.text == text)&&(identical(other.style, style) || other.style == style));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text,style);

@override
String toString() {
  return 'RichContent.paragraph(text: $text, style: $style)';
}


}

/// @nodoc
abstract mixin class $RichParagraphCopyWith<$Res> implements $RichContentCopyWith<$Res> {
  factory $RichParagraphCopyWith(RichParagraph value, $Res Function(RichParagraph) _then) = _$RichParagraphCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'x', toJson: Markdown.toJson, fromJson: Markdown.fromJson) Markdown text,@JsonKey(name: 's') RichParagraphStyle style
});




}
/// @nodoc
class _$RichParagraphCopyWithImpl<$Res>
    implements $RichParagraphCopyWith<$Res> {
  _$RichParagraphCopyWithImpl(this._self, this._then);

  final RichParagraph _self;
  final $Res Function(RichParagraph) _then;

/// Create a copy of RichContent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? text = null,Object? style = null,}) {
  return _then(RichParagraph(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as Markdown,style: null == style ? _self.style : style // ignore: cast_nullable_to_non_nullable
as RichParagraphStyle,
  ));
}


}

/// @nodoc
@JsonSerializable()

class RichTable implements RichContent {
  const RichTable({@JsonKey(name: 'w', toJson: Markdown.toJsonTable, fromJson: Markdown.fromJsonTable) required  List<List<Markdown>> rows,  String? $type}): _rows = rows,$type = $type ?? 't';
  factory RichTable.fromJson(Map<String, dynamic> json) => _$RichTableFromJson(json);

 final  List<List<Markdown>> _rows;
@JsonKey(name: 'w', toJson: Markdown.toJsonTable, fromJson: Markdown.fromJsonTable) List<List<Markdown>> get rows {
  if (_rows is EqualUnmodifiableListView) return _rows;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rows);
}


@JsonKey(name: 'r')
final String $type;


/// Create a copy of RichContent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RichTableCopyWith<RichTable> get copyWith => _$RichTableCopyWithImpl<RichTable>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RichTableToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RichTable&&const DeepCollectionEquality().equals(other._rows, _rows));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_rows));

@override
String toString() {
  return 'RichContent.table(rows: $rows)';
}


}

/// @nodoc
abstract mixin class $RichTableCopyWith<$Res> implements $RichContentCopyWith<$Res> {
  factory $RichTableCopyWith(RichTable value, $Res Function(RichTable) _then) = _$RichTableCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'w', toJson: Markdown.toJsonTable, fromJson: Markdown.fromJsonTable) List<List<Markdown>> rows
});




}
/// @nodoc
class _$RichTableCopyWithImpl<$Res>
    implements $RichTableCopyWith<$Res> {
  _$RichTableCopyWithImpl(this._self, this._then);

  final RichTable _self;
  final $Res Function(RichTable) _then;

/// Create a copy of RichContent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? rows = null,}) {
  return _then(RichTable(
rows: null == rows ? _self._rows : rows // ignore: cast_nullable_to_non_nullable
as List<List<Markdown>>,
  ));
}


}

/// @nodoc
@JsonSerializable()

class RichBibleMap implements RichContent {
  const RichBibleMap({@JsonKey(name: 'i') required this.id,  String? $type}): $type = $type ?? 'm';
  factory RichBibleMap.fromJson(Map<String, dynamic> json) => _$RichBibleMapFromJson(json);

@JsonKey(name: 'i') final  String id;

@JsonKey(name: 'r')
final String $type;


/// Create a copy of RichContent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RichBibleMapCopyWith<RichBibleMap> get copyWith => _$RichBibleMapCopyWithImpl<RichBibleMap>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RichBibleMapToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RichBibleMap&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'RichContent.bibleMap(id: $id)';
}


}

/// @nodoc
abstract mixin class $RichBibleMapCopyWith<$Res> implements $RichContentCopyWith<$Res> {
  factory $RichBibleMapCopyWith(RichBibleMap value, $Res Function(RichBibleMap) _then) = _$RichBibleMapCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'i') String id
});




}
/// @nodoc
class _$RichBibleMapCopyWithImpl<$Res>
    implements $RichBibleMapCopyWith<$Res> {
  _$RichBibleMapCopyWithImpl(this._self, this._then);

  final RichBibleMap _self;
  final $Res Function(RichBibleMap) _then;

/// Create a copy of RichContent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(RichBibleMap(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class RichBox implements RichContent {
  const RichBox({@JsonKey(name: 'h') required this.title, @JsonKey(name: 'c') required  List<RichContent> content,  String? $type}): _content = content,$type = $type ?? 'b';
  factory RichBox.fromJson(Map<String, dynamic> json) => _$RichBoxFromJson(json);

@JsonKey(name: 'h') final  String title;
 final  List<RichContent> _content;
@JsonKey(name: 'c') List<RichContent> get content {
  if (_content is EqualUnmodifiableListView) return _content;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_content);
}


@JsonKey(name: 'r')
final String $type;


/// Create a copy of RichContent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RichBoxCopyWith<RichBox> get copyWith => _$RichBoxCopyWithImpl<RichBox>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RichBoxToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RichBox&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other._content, _content));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,const DeepCollectionEquality().hash(_content));

@override
String toString() {
  return 'RichContent.box(title: $title, content: $content)';
}


}

/// @nodoc
abstract mixin class $RichBoxCopyWith<$Res> implements $RichContentCopyWith<$Res> {
  factory $RichBoxCopyWith(RichBox value, $Res Function(RichBox) _then) = _$RichBoxCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'h') String title,@JsonKey(name: 'c') List<RichContent> content
});




}
/// @nodoc
class _$RichBoxCopyWithImpl<$Res>
    implements $RichBoxCopyWith<$Res> {
  _$RichBoxCopyWithImpl(this._self, this._then);

  final RichBox _self;
  final $Res Function(RichBox) _then;

/// Create a copy of RichContent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? title = null,Object? content = null,}) {
  return _then(RichBox(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self._content : content // ignore: cast_nullable_to_non_nullable
as List<RichContent>,
  ));
}


}

// dart format on
