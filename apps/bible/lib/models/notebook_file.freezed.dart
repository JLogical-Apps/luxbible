// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notebook_file.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NotebookImportTarget {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotebookImportTarget);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NotebookImportTarget()';
}


}

/// @nodoc
class $NotebookImportTargetCopyWith<$Res>  {
$NotebookImportTargetCopyWith(NotebookImportTarget _, $Res Function(NotebookImportTarget) __);
}


/// Adds pattern-matching-related methods to [NotebookImportTarget].
extension NotebookImportTargetPatterns on NotebookImportTarget {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( NewNotebookImportTarget value)?  newNotebook,TResult Function( ExistingNotebookImportTarget value)?  existing,required TResult orElse(),}){
final _that = this;
switch (_that) {
case NewNotebookImportTarget() when newNotebook != null:
return newNotebook(_that);case ExistingNotebookImportTarget() when existing != null:
return existing(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( NewNotebookImportTarget value)  newNotebook,required TResult Function( ExistingNotebookImportTarget value)  existing,}){
final _that = this;
switch (_that) {
case NewNotebookImportTarget():
return newNotebook(_that);case ExistingNotebookImportTarget():
return existing(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( NewNotebookImportTarget value)?  newNotebook,TResult? Function( ExistingNotebookImportTarget value)?  existing,}){
final _that = this;
switch (_that) {
case NewNotebookImportTarget() when newNotebook != null:
return newNotebook(_that);case ExistingNotebookImportTarget() when existing != null:
return existing(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( Notebook notebook)?  newNotebook,TResult Function( String? notebookId)?  existing,required TResult orElse(),}) {final _that = this;
switch (_that) {
case NewNotebookImportTarget() when newNotebook != null:
return newNotebook(_that.notebook);case ExistingNotebookImportTarget() when existing != null:
return existing(_that.notebookId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( Notebook notebook)  newNotebook,required TResult Function( String? notebookId)  existing,}) {final _that = this;
switch (_that) {
case NewNotebookImportTarget():
return newNotebook(_that.notebook);case ExistingNotebookImportTarget():
return existing(_that.notebookId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( Notebook notebook)?  newNotebook,TResult? Function( String? notebookId)?  existing,}) {final _that = this;
switch (_that) {
case NewNotebookImportTarget() when newNotebook != null:
return newNotebook(_that.notebook);case ExistingNotebookImportTarget() when existing != null:
return existing(_that.notebookId);case _:
  return null;

}
}

}

/// @nodoc


class NewNotebookImportTarget implements NotebookImportTarget {
  const NewNotebookImportTarget(this.notebook);
  

 final  Notebook notebook;

/// Create a copy of NotebookImportTarget
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NewNotebookImportTargetCopyWith<NewNotebookImportTarget> get copyWith => _$NewNotebookImportTargetCopyWithImpl<NewNotebookImportTarget>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NewNotebookImportTarget&&(identical(other.notebook, notebook) || other.notebook == notebook));
}


@override
int get hashCode => Object.hash(runtimeType,notebook);

@override
String toString() {
  return 'NotebookImportTarget.newNotebook(notebook: $notebook)';
}


}

/// @nodoc
abstract mixin class $NewNotebookImportTargetCopyWith<$Res> implements $NotebookImportTargetCopyWith<$Res> {
  factory $NewNotebookImportTargetCopyWith(NewNotebookImportTarget value, $Res Function(NewNotebookImportTarget) _then) = _$NewNotebookImportTargetCopyWithImpl;
@useResult
$Res call({
 Notebook notebook
});


$NotebookCopyWith<$Res> get notebook;

}
/// @nodoc
class _$NewNotebookImportTargetCopyWithImpl<$Res>
    implements $NewNotebookImportTargetCopyWith<$Res> {
  _$NewNotebookImportTargetCopyWithImpl(this._self, this._then);

  final NewNotebookImportTarget _self;
  final $Res Function(NewNotebookImportTarget) _then;

/// Create a copy of NotebookImportTarget
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? notebook = null,}) {
  return _then(NewNotebookImportTarget(
null == notebook ? _self.notebook : notebook // ignore: cast_nullable_to_non_nullable
as Notebook,
  ));
}

/// Create a copy of NotebookImportTarget
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotebookCopyWith<$Res> get notebook {
  
  return $NotebookCopyWith<$Res>(_self.notebook, (value) {
    return _then(_self.copyWith(notebook: value));
  });
}
}

/// @nodoc


class ExistingNotebookImportTarget implements NotebookImportTarget {
  const ExistingNotebookImportTarget(this.notebookId);
  

 final  String? notebookId;

/// Create a copy of NotebookImportTarget
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExistingNotebookImportTargetCopyWith<ExistingNotebookImportTarget> get copyWith => _$ExistingNotebookImportTargetCopyWithImpl<ExistingNotebookImportTarget>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExistingNotebookImportTarget&&(identical(other.notebookId, notebookId) || other.notebookId == notebookId));
}


@override
int get hashCode => Object.hash(runtimeType,notebookId);

@override
String toString() {
  return 'NotebookImportTarget.existing(notebookId: $notebookId)';
}


}

/// @nodoc
abstract mixin class $ExistingNotebookImportTargetCopyWith<$Res> implements $NotebookImportTargetCopyWith<$Res> {
  factory $ExistingNotebookImportTargetCopyWith(ExistingNotebookImportTarget value, $Res Function(ExistingNotebookImportTarget) _then) = _$ExistingNotebookImportTargetCopyWithImpl;
@useResult
$Res call({
 String? notebookId
});




}
/// @nodoc
class _$ExistingNotebookImportTargetCopyWithImpl<$Res>
    implements $ExistingNotebookImportTargetCopyWith<$Res> {
  _$ExistingNotebookImportTargetCopyWithImpl(this._self, this._then);

  final ExistingNotebookImportTarget _self;
  final $Res Function(ExistingNotebookImportTarget) _then;

/// Create a copy of NotebookImportTarget
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? notebookId = freezed,}) {
  return _then(ExistingNotebookImportTarget(
freezed == notebookId ? _self.notebookId : notebookId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
