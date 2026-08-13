// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'study_panel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
StudyPanel _$StudyPanelFromJson(
  Map<String, dynamic> json
) {
        switch (json['runtimeType']) {
                  case 'compare':
          return CompareStudyPanel.fromJson(
            json
          );
                case 'interlinear':
          return InterlinearStudyPanel.fromJson(
            json
          );
                case 'commentary':
          return CommentaryStudyPanel.fromJson(
            json
          );
                case 'crossReferences':
          return CrossReferencesStudyPanel.fromJson(
            json
          );
                case 'notes':
          return NotesStudyPanel.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'runtimeType',
  'StudyPanel',
  'Invalid union type "${json['runtimeType']}"!'
);
        }
      
}

/// @nodoc
mixin _$StudyPanel {



  /// Serializes this StudyPanel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StudyPanel);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'StudyPanel()';
}


}

/// @nodoc
class $StudyPanelCopyWith<$Res>  {
$StudyPanelCopyWith(StudyPanel _, $Res Function(StudyPanel) __);
}


/// Adds pattern-matching-related methods to [StudyPanel].
extension StudyPanelPatterns on StudyPanel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CompareStudyPanel value)?  compare,TResult Function( InterlinearStudyPanel value)?  interlinear,TResult Function( CommentaryStudyPanel value)?  commentary,TResult Function( CrossReferencesStudyPanel value)?  crossReferences,TResult Function( NotesStudyPanel value)?  notes,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CompareStudyPanel() when compare != null:
return compare(_that);case InterlinearStudyPanel() when interlinear != null:
return interlinear(_that);case CommentaryStudyPanel() when commentary != null:
return commentary(_that);case CrossReferencesStudyPanel() when crossReferences != null:
return crossReferences(_that);case NotesStudyPanel() when notes != null:
return notes(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CompareStudyPanel value)  compare,required TResult Function( InterlinearStudyPanel value)  interlinear,required TResult Function( CommentaryStudyPanel value)  commentary,required TResult Function( CrossReferencesStudyPanel value)  crossReferences,required TResult Function( NotesStudyPanel value)  notes,}){
final _that = this;
switch (_that) {
case CompareStudyPanel():
return compare(_that);case InterlinearStudyPanel():
return interlinear(_that);case CommentaryStudyPanel():
return commentary(_that);case CrossReferencesStudyPanel():
return crossReferences(_that);case NotesStudyPanel():
return notes(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CompareStudyPanel value)?  compare,TResult? Function( InterlinearStudyPanel value)?  interlinear,TResult? Function( CommentaryStudyPanel value)?  commentary,TResult? Function( CrossReferencesStudyPanel value)?  crossReferences,TResult? Function( NotesStudyPanel value)?  notes,}){
final _that = this;
switch (_that) {
case CompareStudyPanel() when compare != null:
return compare(_that);case InterlinearStudyPanel() when interlinear != null:
return interlinear(_that);case CommentaryStudyPanel() when commentary != null:
return commentary(_that);case CrossReferencesStudyPanel() when crossReferences != null:
return crossReferences(_that);case NotesStudyPanel() when notes != null:
return notes(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( BibleTranslation translation)?  compare,TResult Function( InterlinearDirection direction)?  interlinear,TResult Function( CommentaryType type)?  commentary,TResult Function()?  crossReferences,TResult Function()?  notes,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CompareStudyPanel() when compare != null:
return compare(_that.translation);case InterlinearStudyPanel() when interlinear != null:
return interlinear(_that.direction);case CommentaryStudyPanel() when commentary != null:
return commentary(_that.type);case CrossReferencesStudyPanel() when crossReferences != null:
return crossReferences();case NotesStudyPanel() when notes != null:
return notes();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( BibleTranslation translation)  compare,required TResult Function( InterlinearDirection direction)  interlinear,required TResult Function( CommentaryType type)  commentary,required TResult Function()  crossReferences,required TResult Function()  notes,}) {final _that = this;
switch (_that) {
case CompareStudyPanel():
return compare(_that.translation);case InterlinearStudyPanel():
return interlinear(_that.direction);case CommentaryStudyPanel():
return commentary(_that.type);case CrossReferencesStudyPanel():
return crossReferences();case NotesStudyPanel():
return notes();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( BibleTranslation translation)?  compare,TResult? Function( InterlinearDirection direction)?  interlinear,TResult? Function( CommentaryType type)?  commentary,TResult? Function()?  crossReferences,TResult? Function()?  notes,}) {final _that = this;
switch (_that) {
case CompareStudyPanel() when compare != null:
return compare(_that.translation);case InterlinearStudyPanel() when interlinear != null:
return interlinear(_that.direction);case CommentaryStudyPanel() when commentary != null:
return commentary(_that.type);case CrossReferencesStudyPanel() when crossReferences != null:
return crossReferences();case NotesStudyPanel() when notes != null:
return notes();case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class CompareStudyPanel extends StudyPanel {
  const CompareStudyPanel({required this.translation,  String? $type}): $type = $type ?? 'compare',super._();
  factory CompareStudyPanel.fromJson(Map<String, dynamic> json) => _$CompareStudyPanelFromJson(json);

 final  BibleTranslation translation;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of StudyPanel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompareStudyPanelCopyWith<CompareStudyPanel> get copyWith => _$CompareStudyPanelCopyWithImpl<CompareStudyPanel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CompareStudyPanelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompareStudyPanel&&(identical(other.translation, translation) || other.translation == translation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,translation);

@override
String toString() {
  return 'StudyPanel.compare(translation: $translation)';
}


}

/// @nodoc
abstract mixin class $CompareStudyPanelCopyWith<$Res> implements $StudyPanelCopyWith<$Res> {
  factory $CompareStudyPanelCopyWith(CompareStudyPanel value, $Res Function(CompareStudyPanel) _then) = _$CompareStudyPanelCopyWithImpl;
@useResult
$Res call({
 BibleTranslation translation
});




}
/// @nodoc
class _$CompareStudyPanelCopyWithImpl<$Res>
    implements $CompareStudyPanelCopyWith<$Res> {
  _$CompareStudyPanelCopyWithImpl(this._self, this._then);

  final CompareStudyPanel _self;
  final $Res Function(CompareStudyPanel) _then;

/// Create a copy of StudyPanel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? translation = null,}) {
  return _then(CompareStudyPanel(
translation: null == translation ? _self.translation : translation // ignore: cast_nullable_to_non_nullable
as BibleTranslation,
  ));
}


}

/// @nodoc
@JsonSerializable()

class InterlinearStudyPanel extends StudyPanel {
  const InterlinearStudyPanel({required this.direction,  String? $type}): $type = $type ?? 'interlinear',super._();
  factory InterlinearStudyPanel.fromJson(Map<String, dynamic> json) => _$InterlinearStudyPanelFromJson(json);

 final  InterlinearDirection direction;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of StudyPanel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InterlinearStudyPanelCopyWith<InterlinearStudyPanel> get copyWith => _$InterlinearStudyPanelCopyWithImpl<InterlinearStudyPanel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InterlinearStudyPanelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InterlinearStudyPanel&&(identical(other.direction, direction) || other.direction == direction));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,direction);

@override
String toString() {
  return 'StudyPanel.interlinear(direction: $direction)';
}


}

/// @nodoc
abstract mixin class $InterlinearStudyPanelCopyWith<$Res> implements $StudyPanelCopyWith<$Res> {
  factory $InterlinearStudyPanelCopyWith(InterlinearStudyPanel value, $Res Function(InterlinearStudyPanel) _then) = _$InterlinearStudyPanelCopyWithImpl;
@useResult
$Res call({
 InterlinearDirection direction
});




}
/// @nodoc
class _$InterlinearStudyPanelCopyWithImpl<$Res>
    implements $InterlinearStudyPanelCopyWith<$Res> {
  _$InterlinearStudyPanelCopyWithImpl(this._self, this._then);

  final InterlinearStudyPanel _self;
  final $Res Function(InterlinearStudyPanel) _then;

/// Create a copy of StudyPanel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? direction = null,}) {
  return _then(InterlinearStudyPanel(
direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as InterlinearDirection,
  ));
}


}

/// @nodoc
@JsonSerializable()

class CommentaryStudyPanel extends StudyPanel {
  const CommentaryStudyPanel({required this.type,  String? $type}): $type = $type ?? 'commentary',super._();
  factory CommentaryStudyPanel.fromJson(Map<String, dynamic> json) => _$CommentaryStudyPanelFromJson(json);

 final  CommentaryType type;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of StudyPanel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommentaryStudyPanelCopyWith<CommentaryStudyPanel> get copyWith => _$CommentaryStudyPanelCopyWithImpl<CommentaryStudyPanel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommentaryStudyPanelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommentaryStudyPanel&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type);

@override
String toString() {
  return 'StudyPanel.commentary(type: $type)';
}


}

/// @nodoc
abstract mixin class $CommentaryStudyPanelCopyWith<$Res> implements $StudyPanelCopyWith<$Res> {
  factory $CommentaryStudyPanelCopyWith(CommentaryStudyPanel value, $Res Function(CommentaryStudyPanel) _then) = _$CommentaryStudyPanelCopyWithImpl;
@useResult
$Res call({
 CommentaryType type
});




}
/// @nodoc
class _$CommentaryStudyPanelCopyWithImpl<$Res>
    implements $CommentaryStudyPanelCopyWith<$Res> {
  _$CommentaryStudyPanelCopyWithImpl(this._self, this._then);

  final CommentaryStudyPanel _self;
  final $Res Function(CommentaryStudyPanel) _then;

/// Create a copy of StudyPanel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? type = null,}) {
  return _then(CommentaryStudyPanel(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as CommentaryType,
  ));
}


}

/// @nodoc
@JsonSerializable()

class CrossReferencesStudyPanel extends StudyPanel {
  const CrossReferencesStudyPanel({ String? $type}): $type = $type ?? 'crossReferences',super._();
  factory CrossReferencesStudyPanel.fromJson(Map<String, dynamic> json) => _$CrossReferencesStudyPanelFromJson(json);



@JsonKey(name: 'runtimeType')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$CrossReferencesStudyPanelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CrossReferencesStudyPanel);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'StudyPanel.crossReferences()';
}


}




/// @nodoc
@JsonSerializable()

class NotesStudyPanel extends StudyPanel {
  const NotesStudyPanel({ String? $type}): $type = $type ?? 'notes',super._();
  factory NotesStudyPanel.fromJson(Map<String, dynamic> json) => _$NotesStudyPanelFromJson(json);



@JsonKey(name: 'runtimeType')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$NotesStudyPanelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotesStudyPanel);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'StudyPanel.notes()';
}


}




// dart format on
