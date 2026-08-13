// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'paragraph.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
Paragraph _$ParagraphFromJson(
  Map<String, dynamic> json
) {
        switch (json['r']) {
                  case 'v':
          return VersesParagraph.fromJson(
            json
          );
                case 's':
          return SectionParagraph.fromJson(
            json
          );
                case 'b':
          return BreakParagraph.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'r',
  'Paragraph',
  'Invalid union type "${json['r']}"!'
);
        }
      
}

/// @nodoc
mixin _$Paragraph {



  /// Serializes this Paragraph to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Paragraph);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Paragraph()';
}


}

/// @nodoc
class $ParagraphCopyWith<$Res>  {
$ParagraphCopyWith(Paragraph _, $Res Function(Paragraph) __);
}


/// Adds pattern-matching-related methods to [Paragraph].
extension ParagraphPatterns on Paragraph {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( VersesParagraph value)?  verses,TResult Function( SectionParagraph value)?  section,TResult Function( BreakParagraph value)?  lineBreak,required TResult orElse(),}){
final _that = this;
switch (_that) {
case VersesParagraph() when verses != null:
return verses(_that);case SectionParagraph() when section != null:
return section(_that);case BreakParagraph() when lineBreak != null:
return lineBreak(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( VersesParagraph value)  verses,required TResult Function( SectionParagraph value)  section,required TResult Function( BreakParagraph value)  lineBreak,}){
final _that = this;
switch (_that) {
case VersesParagraph():
return verses(_that);case SectionParagraph():
return section(_that);case BreakParagraph():
return lineBreak(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( VersesParagraph value)?  verses,TResult? Function( SectionParagraph value)?  section,TResult? Function( BreakParagraph value)?  lineBreak,}){
final _that = this;
switch (_that) {
case VersesParagraph() when verses != null:
return verses(_that);case SectionParagraph() when section != null:
return section(_that);case BreakParagraph() when lineBreak != null:
return lineBreak(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function(@JsonKey(name: 'v')  List<Verse> verses, @JsonKey(name: 'o', toJson: _firstVerseOffsetToJson, includeIfNull: false)  int firstVerseOffset, @JsonKey(name: 't')  ParagraphType type, @jsonIgnore  bool preventIndent)?  verses,TResult Function(@JsonKey(name: 'x')  String text, @JsonKey(name: 't')  SectionType type)?  section,TResult Function()?  lineBreak,required TResult orElse(),}) {final _that = this;
switch (_that) {
case VersesParagraph() when verses != null:
return verses(_that.verses,_that.firstVerseOffset,_that.type,_that.preventIndent);case SectionParagraph() when section != null:
return section(_that.text,_that.type);case BreakParagraph() when lineBreak != null:
return lineBreak();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function(@JsonKey(name: 'v')  List<Verse> verses, @JsonKey(name: 'o', toJson: _firstVerseOffsetToJson, includeIfNull: false)  int firstVerseOffset, @JsonKey(name: 't')  ParagraphType type, @jsonIgnore  bool preventIndent)  verses,required TResult Function(@JsonKey(name: 'x')  String text, @JsonKey(name: 't')  SectionType type)  section,required TResult Function()  lineBreak,}) {final _that = this;
switch (_that) {
case VersesParagraph():
return verses(_that.verses,_that.firstVerseOffset,_that.type,_that.preventIndent);case SectionParagraph():
return section(_that.text,_that.type);case BreakParagraph():
return lineBreak();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function(@JsonKey(name: 'v')  List<Verse> verses, @JsonKey(name: 'o', toJson: _firstVerseOffsetToJson, includeIfNull: false)  int firstVerseOffset, @JsonKey(name: 't')  ParagraphType type, @jsonIgnore  bool preventIndent)?  verses,TResult? Function(@JsonKey(name: 'x')  String text, @JsonKey(name: 't')  SectionType type)?  section,TResult? Function()?  lineBreak,}) {final _that = this;
switch (_that) {
case VersesParagraph() when verses != null:
return verses(_that.verses,_that.firstVerseOffset,_that.type,_that.preventIndent);case SectionParagraph() when section != null:
return section(_that.text,_that.type);case BreakParagraph() when lineBreak != null:
return lineBreak();case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class VersesParagraph extends Paragraph {
  const VersesParagraph({@JsonKey(name: 'v') required  List<Verse> verses, @JsonKey(name: 'o', toJson: _firstVerseOffsetToJson, includeIfNull: false) this.firstVerseOffset = 0, @JsonKey(name: 't') required this.type, @jsonIgnore this.preventIndent = false,  String? $type}): _verses = verses,$type = $type ?? 'v',super._();
  factory VersesParagraph.fromJson(Map<String, dynamic> json) => _$VersesParagraphFromJson(json);

 final  List<Verse> _verses;
@JsonKey(name: 'v') List<Verse> get verses {
  if (_verses is EqualUnmodifiableListView) return _verses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_verses);
}

@JsonKey(name: 'o', toJson: _firstVerseOffsetToJson, includeIfNull: false) final  int firstVerseOffset;
@JsonKey(name: 't') final  ParagraphType type;
@jsonIgnore final  bool preventIndent;

@JsonKey(name: 'r')
final String $type;


/// Create a copy of Paragraph
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VersesParagraphCopyWith<VersesParagraph> get copyWith => _$VersesParagraphCopyWithImpl<VersesParagraph>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VersesParagraphToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VersesParagraph&&const DeepCollectionEquality().equals(other._verses, _verses)&&(identical(other.firstVerseOffset, firstVerseOffset) || other.firstVerseOffset == firstVerseOffset)&&(identical(other.type, type) || other.type == type)&&(identical(other.preventIndent, preventIndent) || other.preventIndent == preventIndent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_verses),firstVerseOffset,type,preventIndent);

@override
String toString() {
  return 'Paragraph.verses(verses: $verses, firstVerseOffset: $firstVerseOffset, type: $type, preventIndent: $preventIndent)';
}


}

/// @nodoc
abstract mixin class $VersesParagraphCopyWith<$Res> implements $ParagraphCopyWith<$Res> {
  factory $VersesParagraphCopyWith(VersesParagraph value, $Res Function(VersesParagraph) _then) = _$VersesParagraphCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'v') List<Verse> verses,@JsonKey(name: 'o', toJson: _firstVerseOffsetToJson, includeIfNull: false) int firstVerseOffset,@JsonKey(name: 't') ParagraphType type,@jsonIgnore bool preventIndent
});




}
/// @nodoc
class _$VersesParagraphCopyWithImpl<$Res>
    implements $VersesParagraphCopyWith<$Res> {
  _$VersesParagraphCopyWithImpl(this._self, this._then);

  final VersesParagraph _self;
  final $Res Function(VersesParagraph) _then;

/// Create a copy of Paragraph
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? verses = null,Object? firstVerseOffset = null,Object? type = null,Object? preventIndent = null,}) {
  return _then(VersesParagraph(
verses: null == verses ? _self._verses : verses // ignore: cast_nullable_to_non_nullable
as List<Verse>,firstVerseOffset: null == firstVerseOffset ? _self.firstVerseOffset : firstVerseOffset // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ParagraphType,preventIndent: null == preventIndent ? _self.preventIndent : preventIndent // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
@JsonSerializable()

class SectionParagraph extends Paragraph {
  const SectionParagraph({@JsonKey(name: 'x') required this.text, @JsonKey(name: 't') required this.type,  String? $type}): $type = $type ?? 's',super._();
  factory SectionParagraph.fromJson(Map<String, dynamic> json) => _$SectionParagraphFromJson(json);

@JsonKey(name: 'x') final  String text;
@JsonKey(name: 't') final  SectionType type;

@JsonKey(name: 'r')
final String $type;


/// Create a copy of Paragraph
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SectionParagraphCopyWith<SectionParagraph> get copyWith => _$SectionParagraphCopyWithImpl<SectionParagraph>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SectionParagraphToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SectionParagraph&&(identical(other.text, text) || other.text == text)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text,type);

@override
String toString() {
  return 'Paragraph.section(text: $text, type: $type)';
}


}

/// @nodoc
abstract mixin class $SectionParagraphCopyWith<$Res> implements $ParagraphCopyWith<$Res> {
  factory $SectionParagraphCopyWith(SectionParagraph value, $Res Function(SectionParagraph) _then) = _$SectionParagraphCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'x') String text,@JsonKey(name: 't') SectionType type
});




}
/// @nodoc
class _$SectionParagraphCopyWithImpl<$Res>
    implements $SectionParagraphCopyWith<$Res> {
  _$SectionParagraphCopyWithImpl(this._self, this._then);

  final SectionParagraph _self;
  final $Res Function(SectionParagraph) _then;

/// Create a copy of Paragraph
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? text = null,Object? type = null,}) {
  return _then(SectionParagraph(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SectionType,
  ));
}


}

/// @nodoc
@JsonSerializable()

class BreakParagraph extends Paragraph {
  const BreakParagraph({ String? $type}): $type = $type ?? 'b',super._();
  factory BreakParagraph.fromJson(Map<String, dynamic> json) => _$BreakParagraphFromJson(json);



@JsonKey(name: 'r')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$BreakParagraphToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BreakParagraph);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Paragraph.lineBreak()';
}


}




// dart format on
