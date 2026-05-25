// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'annotation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Annotation {

@JsonKey(readValue: _annotationSelectionFromAnnotation) AnnotationSelection get selection; ColorEnum get color; String get note;
/// Create a copy of Annotation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnnotationCopyWith<Annotation> get copyWith => _$AnnotationCopyWithImpl<Annotation>(this as Annotation, _$identity);

  /// Serializes this Annotation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Annotation&&(identical(other.selection, selection) || other.selection == selection)&&(identical(other.color, color) || other.color == color)&&(identical(other.note, note) || other.note == note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,selection,color,note);

@override
String toString() {
  return 'Annotation(selection: $selection, color: $color, note: $note)';
}


}

/// @nodoc
abstract mixin class $AnnotationCopyWith<$Res>  {
  factory $AnnotationCopyWith(Annotation value, $Res Function(Annotation) _then) = _$AnnotationCopyWithImpl;
@useResult
$Res call({
@JsonKey(readValue: _annotationSelectionFromAnnotation) AnnotationSelection selection, ColorEnum color, String note
});


$AnnotationSelectionCopyWith<$Res> get selection;

}
/// @nodoc
class _$AnnotationCopyWithImpl<$Res>
    implements $AnnotationCopyWith<$Res> {
  _$AnnotationCopyWithImpl(this._self, this._then);

  final Annotation _self;
  final $Res Function(Annotation) _then;

/// Create a copy of Annotation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? selection = null,Object? color = null,Object? note = null,}) {
  return _then(_self.copyWith(
selection: null == selection ? _self.selection : selection // ignore: cast_nullable_to_non_nullable
as AnnotationSelection,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as ColorEnum,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of Annotation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AnnotationSelectionCopyWith<$Res> get selection {
  
  return $AnnotationSelectionCopyWith<$Res>(_self.selection, (value) {
    return _then(_self.copyWith(selection: value));
  });
}
}


/// Adds pattern-matching-related methods to [Annotation].
extension AnnotationPatterns on Annotation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Annotation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Annotation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Annotation value)  $default,){
final _that = this;
switch (_that) {
case _Annotation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Annotation value)?  $default,){
final _that = this;
switch (_that) {
case _Annotation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(readValue: _annotationSelectionFromAnnotation)  AnnotationSelection selection,  ColorEnum color,  String note)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Annotation() when $default != null:
return $default(_that.selection,_that.color,_that.note);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(readValue: _annotationSelectionFromAnnotation)  AnnotationSelection selection,  ColorEnum color,  String note)  $default,) {final _that = this;
switch (_that) {
case _Annotation():
return $default(_that.selection,_that.color,_that.note);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(readValue: _annotationSelectionFromAnnotation)  AnnotationSelection selection,  ColorEnum color,  String note)?  $default,) {final _that = this;
switch (_that) {
case _Annotation() when $default != null:
return $default(_that.selection,_that.color,_that.note);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Annotation extends Annotation {
  const _Annotation({@JsonKey(readValue: _annotationSelectionFromAnnotation) required this.selection, this.color = ColorEnum.stone, this.note = ''}): super._();
  factory _Annotation.fromJson(Map<String, dynamic> json) => _$AnnotationFromJson(json);

@override@JsonKey(readValue: _annotationSelectionFromAnnotation) final  AnnotationSelection selection;
@override@JsonKey() final  ColorEnum color;
@override@JsonKey() final  String note;

/// Create a copy of Annotation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AnnotationCopyWith<_Annotation> get copyWith => __$AnnotationCopyWithImpl<_Annotation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AnnotationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Annotation&&(identical(other.selection, selection) || other.selection == selection)&&(identical(other.color, color) || other.color == color)&&(identical(other.note, note) || other.note == note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,selection,color,note);

@override
String toString() {
  return 'Annotation(selection: $selection, color: $color, note: $note)';
}


}

/// @nodoc
abstract mixin class _$AnnotationCopyWith<$Res> implements $AnnotationCopyWith<$Res> {
  factory _$AnnotationCopyWith(_Annotation value, $Res Function(_Annotation) _then) = __$AnnotationCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(readValue: _annotationSelectionFromAnnotation) AnnotationSelection selection, ColorEnum color, String note
});


@override $AnnotationSelectionCopyWith<$Res> get selection;

}
/// @nodoc
class __$AnnotationCopyWithImpl<$Res>
    implements _$AnnotationCopyWith<$Res> {
  __$AnnotationCopyWithImpl(this._self, this._then);

  final _Annotation _self;
  final $Res Function(_Annotation) _then;

/// Create a copy of Annotation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? selection = null,Object? color = null,Object? note = null,}) {
  return _then(_Annotation(
selection: null == selection ? _self.selection : selection // ignore: cast_nullable_to_non_nullable
as AnnotationSelection,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as ColorEnum,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of Annotation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AnnotationSelectionCopyWith<$Res> get selection {
  
  return $AnnotationSelectionCopyWith<$Res>(_self.selection, (value) {
    return _then(_self.copyWith(selection: value));
  });
}
}

AnnotationSelection _$AnnotationSelectionFromJson(
  Map<String, dynamic> json
) {
        switch (json['runtimeType']) {
                  case 'verses':
          return VersesAnnotationSelection.fromJson(
            json
          );
                case 'text':
          return TextAnnotationSelection.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'runtimeType',
  'AnnotationSelection',
  'Invalid union type "${json['runtimeType']}"!'
);
        }
      
}

/// @nodoc
mixin _$AnnotationSelection {



  /// Serializes this AnnotationSelection to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnnotationSelection);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AnnotationSelection()';
}


}

/// @nodoc
class $AnnotationSelectionCopyWith<$Res>  {
$AnnotationSelectionCopyWith(AnnotationSelection _, $Res Function(AnnotationSelection) __);
}


/// Adds pattern-matching-related methods to [AnnotationSelection].
extension AnnotationSelectionPatterns on AnnotationSelection {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( VersesAnnotationSelection value)?  verses,TResult Function( TextAnnotationSelection value)?  text,required TResult orElse(),}){
final _that = this;
switch (_that) {
case VersesAnnotationSelection() when verses != null:
return verses(_that);case TextAnnotationSelection() when text != null:
return text(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( VersesAnnotationSelection value)  verses,required TResult Function( TextAnnotationSelection value)  text,}){
final _that = this;
switch (_that) {
case VersesAnnotationSelection():
return verses(_that);case TextAnnotationSelection():
return text(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( VersesAnnotationSelection value)?  verses,TResult? Function( TextAnnotationSelection value)?  text,}){
final _that = this;
switch (_that) {
case VersesAnnotationSelection() when verses != null:
return verses(_that);case TextAnnotationSelection() when text != null:
return text(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( VerseSelection verseSelection)?  verses,TResult Function( BibleTextSelection textSelection)?  text,required TResult orElse(),}) {final _that = this;
switch (_that) {
case VersesAnnotationSelection() when verses != null:
return verses(_that.verseSelection);case TextAnnotationSelection() when text != null:
return text(_that.textSelection);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( VerseSelection verseSelection)  verses,required TResult Function( BibleTextSelection textSelection)  text,}) {final _that = this;
switch (_that) {
case VersesAnnotationSelection():
return verses(_that.verseSelection);case TextAnnotationSelection():
return text(_that.textSelection);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( VerseSelection verseSelection)?  verses,TResult? Function( BibleTextSelection textSelection)?  text,}) {final _that = this;
switch (_that) {
case VersesAnnotationSelection() when verses != null:
return verses(_that.verseSelection);case TextAnnotationSelection() when text != null:
return text(_that.textSelection);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class VersesAnnotationSelection extends AnnotationSelection {
  const VersesAnnotationSelection({required this.verseSelection, final  String? $type}): $type = $type ?? 'verses',super._();
  factory VersesAnnotationSelection.fromJson(Map<String, dynamic> json) => _$VersesAnnotationSelectionFromJson(json);

 final  VerseSelection verseSelection;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of AnnotationSelection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VersesAnnotationSelectionCopyWith<VersesAnnotationSelection> get copyWith => _$VersesAnnotationSelectionCopyWithImpl<VersesAnnotationSelection>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VersesAnnotationSelectionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VersesAnnotationSelection&&(identical(other.verseSelection, verseSelection) || other.verseSelection == verseSelection));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,verseSelection);

@override
String toString() {
  return 'AnnotationSelection.verses(verseSelection: $verseSelection)';
}


}

/// @nodoc
abstract mixin class $VersesAnnotationSelectionCopyWith<$Res> implements $AnnotationSelectionCopyWith<$Res> {
  factory $VersesAnnotationSelectionCopyWith(VersesAnnotationSelection value, $Res Function(VersesAnnotationSelection) _then) = _$VersesAnnotationSelectionCopyWithImpl;
@useResult
$Res call({
 VerseSelection verseSelection
});




}
/// @nodoc
class _$VersesAnnotationSelectionCopyWithImpl<$Res>
    implements $VersesAnnotationSelectionCopyWith<$Res> {
  _$VersesAnnotationSelectionCopyWithImpl(this._self, this._then);

  final VersesAnnotationSelection _self;
  final $Res Function(VersesAnnotationSelection) _then;

/// Create a copy of AnnotationSelection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? verseSelection = null,}) {
  return _then(VersesAnnotationSelection(
verseSelection: null == verseSelection ? _self.verseSelection : verseSelection // ignore: cast_nullable_to_non_nullable
as VerseSelection,
  ));
}


}

/// @nodoc
@JsonSerializable()

class TextAnnotationSelection extends AnnotationSelection {
  const TextAnnotationSelection({required this.textSelection, final  String? $type}): $type = $type ?? 'text',super._();
  factory TextAnnotationSelection.fromJson(Map<String, dynamic> json) => _$TextAnnotationSelectionFromJson(json);

 final  BibleTextSelection textSelection;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of AnnotationSelection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TextAnnotationSelectionCopyWith<TextAnnotationSelection> get copyWith => _$TextAnnotationSelectionCopyWithImpl<TextAnnotationSelection>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TextAnnotationSelectionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TextAnnotationSelection&&(identical(other.textSelection, textSelection) || other.textSelection == textSelection));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,textSelection);

@override
String toString() {
  return 'AnnotationSelection.text(textSelection: $textSelection)';
}


}

/// @nodoc
abstract mixin class $TextAnnotationSelectionCopyWith<$Res> implements $AnnotationSelectionCopyWith<$Res> {
  factory $TextAnnotationSelectionCopyWith(TextAnnotationSelection value, $Res Function(TextAnnotationSelection) _then) = _$TextAnnotationSelectionCopyWithImpl;
@useResult
$Res call({
 BibleTextSelection textSelection
});


$BibleTextSelectionCopyWith<$Res> get textSelection;

}
/// @nodoc
class _$TextAnnotationSelectionCopyWithImpl<$Res>
    implements $TextAnnotationSelectionCopyWith<$Res> {
  _$TextAnnotationSelectionCopyWithImpl(this._self, this._then);

  final TextAnnotationSelection _self;
  final $Res Function(TextAnnotationSelection) _then;

/// Create a copy of AnnotationSelection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? textSelection = null,}) {
  return _then(TextAnnotationSelection(
textSelection: null == textSelection ? _self.textSelection : textSelection // ignore: cast_nullable_to_non_nullable
as BibleTextSelection,
  ));
}

/// Create a copy of AnnotationSelection
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BibleTextSelectionCopyWith<$Res> get textSelection {
  
  return $BibleTextSelectionCopyWith<$Res>(_self.textSelection, (value) {
    return _then(_self.copyWith(textSelection: value));
  });
}
}

// dart format on
