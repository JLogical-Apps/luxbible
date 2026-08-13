// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'activity_plan.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
ActivityPlan _$ActivityPlanFromJson(
  Map<String, dynamic> json
) {
        switch (json['runtimeType']) {
                  case 'phraseRead':
          return PhraseReadActivityPlan.fromJson(
            json
          );
                case 'readContext':
          return ReadContextActivityPlan.fromJson(
            json
          );
                case 'phraseSelection':
          return PhraseSelectionActivityPlan.fromJson(
            json
          );
                case 'wordSelection':
          return WordSelectionActivityPlan.fromJson(
            json
          );
                case 'wordType':
          return WordTypeActivityPlan.fromJson(
            json
          );
                case 'referenceSelection':
          return ReferenceSelectionActivityPlan.fromJson(
            json
          );
                case 'referenceType':
          return ReferenceTypeActivityPlan.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'runtimeType',
  'ActivityPlan',
  'Invalid union type "${json['runtimeType']}"!'
);
        }
      
}

/// @nodoc
mixin _$ActivityPlan {

 VerseSelection get passage;
/// Create a copy of ActivityPlan
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActivityPlanCopyWith<ActivityPlan> get copyWith => _$ActivityPlanCopyWithImpl<ActivityPlan>(this as ActivityPlan, _$identity);

  /// Serializes this ActivityPlan to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActivityPlan&&(identical(other.passage, passage) || other.passage == passage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,passage);

@override
String toString() {
  return 'ActivityPlan(passage: $passage)';
}


}

/// @nodoc
abstract mixin class $ActivityPlanCopyWith<$Res>  {
  factory $ActivityPlanCopyWith(ActivityPlan value, $Res Function(ActivityPlan) _then) = _$ActivityPlanCopyWithImpl;
@useResult
$Res call({
 VerseSelection passage
});




}
/// @nodoc
class _$ActivityPlanCopyWithImpl<$Res>
    implements $ActivityPlanCopyWith<$Res> {
  _$ActivityPlanCopyWithImpl(this._self, this._then);

  final ActivityPlan _self;
  final $Res Function(ActivityPlan) _then;

/// Create a copy of ActivityPlan
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? passage = null,}) {
  return _then(_self.copyWith(
passage: null == passage ? _self.passage : passage // ignore: cast_nullable_to_non_nullable
as VerseSelection,
  ));
}

}


/// Adds pattern-matching-related methods to [ActivityPlan].
extension ActivityPlanPatterns on ActivityPlan {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( PhraseReadActivityPlan value)?  phraseRead,TResult Function( ReadContextActivityPlan value)?  readContext,TResult Function( PhraseSelectionActivityPlan value)?  phraseSelection,TResult Function( WordSelectionActivityPlan value)?  wordSelection,TResult Function( WordTypeActivityPlan value)?  wordType,TResult Function( ReferenceSelectionActivityPlan value)?  referenceSelection,TResult Function( ReferenceTypeActivityPlan value)?  referenceType,required TResult orElse(),}){
final _that = this;
switch (_that) {
case PhraseReadActivityPlan() when phraseRead != null:
return phraseRead(_that);case ReadContextActivityPlan() when readContext != null:
return readContext(_that);case PhraseSelectionActivityPlan() when phraseSelection != null:
return phraseSelection(_that);case WordSelectionActivityPlan() when wordSelection != null:
return wordSelection(_that);case WordTypeActivityPlan() when wordType != null:
return wordType(_that);case ReferenceSelectionActivityPlan() when referenceSelection != null:
return referenceSelection(_that);case ReferenceTypeActivityPlan() when referenceType != null:
return referenceType(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( PhraseReadActivityPlan value)  phraseRead,required TResult Function( ReadContextActivityPlan value)  readContext,required TResult Function( PhraseSelectionActivityPlan value)  phraseSelection,required TResult Function( WordSelectionActivityPlan value)  wordSelection,required TResult Function( WordTypeActivityPlan value)  wordType,required TResult Function( ReferenceSelectionActivityPlan value)  referenceSelection,required TResult Function( ReferenceTypeActivityPlan value)  referenceType,}){
final _that = this;
switch (_that) {
case PhraseReadActivityPlan():
return phraseRead(_that);case ReadContextActivityPlan():
return readContext(_that);case PhraseSelectionActivityPlan():
return phraseSelection(_that);case WordSelectionActivityPlan():
return wordSelection(_that);case WordTypeActivityPlan():
return wordType(_that);case ReferenceSelectionActivityPlan():
return referenceSelection(_that);case ReferenceTypeActivityPlan():
return referenceType(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( PhraseReadActivityPlan value)?  phraseRead,TResult? Function( ReadContextActivityPlan value)?  readContext,TResult? Function( PhraseSelectionActivityPlan value)?  phraseSelection,TResult? Function( WordSelectionActivityPlan value)?  wordSelection,TResult? Function( WordTypeActivityPlan value)?  wordType,TResult? Function( ReferenceSelectionActivityPlan value)?  referenceSelection,TResult? Function( ReferenceTypeActivityPlan value)?  referenceType,}){
final _that = this;
switch (_that) {
case PhraseReadActivityPlan() when phraseRead != null:
return phraseRead(_that);case ReadContextActivityPlan() when readContext != null:
return readContext(_that);case PhraseSelectionActivityPlan() when phraseSelection != null:
return phraseSelection(_that);case WordSelectionActivityPlan() when wordSelection != null:
return wordSelection(_that);case WordTypeActivityPlan() when wordType != null:
return wordType(_that);case ReferenceSelectionActivityPlan() when referenceSelection != null:
return referenceSelection(_that);case ReferenceTypeActivityPlan() when referenceType != null:
return referenceType(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( VerseSelection passage)?  phraseRead,TResult Function( VerseSelection passage)?  readContext,TResult Function( VerseSelection passage)?  phraseSelection,TResult Function( VerseSelection passage)?  wordSelection,TResult Function( VerseSelection passage)?  wordType,TResult Function( VerseSelection passage)?  referenceSelection,TResult Function( VerseSelection passage)?  referenceType,required TResult orElse(),}) {final _that = this;
switch (_that) {
case PhraseReadActivityPlan() when phraseRead != null:
return phraseRead(_that.passage);case ReadContextActivityPlan() when readContext != null:
return readContext(_that.passage);case PhraseSelectionActivityPlan() when phraseSelection != null:
return phraseSelection(_that.passage);case WordSelectionActivityPlan() when wordSelection != null:
return wordSelection(_that.passage);case WordTypeActivityPlan() when wordType != null:
return wordType(_that.passage);case ReferenceSelectionActivityPlan() when referenceSelection != null:
return referenceSelection(_that.passage);case ReferenceTypeActivityPlan() when referenceType != null:
return referenceType(_that.passage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( VerseSelection passage)  phraseRead,required TResult Function( VerseSelection passage)  readContext,required TResult Function( VerseSelection passage)  phraseSelection,required TResult Function( VerseSelection passage)  wordSelection,required TResult Function( VerseSelection passage)  wordType,required TResult Function( VerseSelection passage)  referenceSelection,required TResult Function( VerseSelection passage)  referenceType,}) {final _that = this;
switch (_that) {
case PhraseReadActivityPlan():
return phraseRead(_that.passage);case ReadContextActivityPlan():
return readContext(_that.passage);case PhraseSelectionActivityPlan():
return phraseSelection(_that.passage);case WordSelectionActivityPlan():
return wordSelection(_that.passage);case WordTypeActivityPlan():
return wordType(_that.passage);case ReferenceSelectionActivityPlan():
return referenceSelection(_that.passage);case ReferenceTypeActivityPlan():
return referenceType(_that.passage);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( VerseSelection passage)?  phraseRead,TResult? Function( VerseSelection passage)?  readContext,TResult? Function( VerseSelection passage)?  phraseSelection,TResult? Function( VerseSelection passage)?  wordSelection,TResult? Function( VerseSelection passage)?  wordType,TResult? Function( VerseSelection passage)?  referenceSelection,TResult? Function( VerseSelection passage)?  referenceType,}) {final _that = this;
switch (_that) {
case PhraseReadActivityPlan() when phraseRead != null:
return phraseRead(_that.passage);case ReadContextActivityPlan() when readContext != null:
return readContext(_that.passage);case PhraseSelectionActivityPlan() when phraseSelection != null:
return phraseSelection(_that.passage);case WordSelectionActivityPlan() when wordSelection != null:
return wordSelection(_that.passage);case WordTypeActivityPlan() when wordType != null:
return wordType(_that.passage);case ReferenceSelectionActivityPlan() when referenceSelection != null:
return referenceSelection(_that.passage);case ReferenceTypeActivityPlan() when referenceType != null:
return referenceType(_that.passage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class PhraseReadActivityPlan extends ActivityPlan {
  const PhraseReadActivityPlan({required this.passage,  String? $type}): $type = $type ?? 'phraseRead',super._();
  factory PhraseReadActivityPlan.fromJson(Map<String, dynamic> json) => _$PhraseReadActivityPlanFromJson(json);

@override final  VerseSelection passage;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of ActivityPlan
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PhraseReadActivityPlanCopyWith<PhraseReadActivityPlan> get copyWith => _$PhraseReadActivityPlanCopyWithImpl<PhraseReadActivityPlan>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PhraseReadActivityPlanToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PhraseReadActivityPlan&&(identical(other.passage, passage) || other.passage == passage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,passage);

@override
String toString() {
  return 'ActivityPlan.phraseRead(passage: $passage)';
}


}

/// @nodoc
abstract mixin class $PhraseReadActivityPlanCopyWith<$Res> implements $ActivityPlanCopyWith<$Res> {
  factory $PhraseReadActivityPlanCopyWith(PhraseReadActivityPlan value, $Res Function(PhraseReadActivityPlan) _then) = _$PhraseReadActivityPlanCopyWithImpl;
@override @useResult
$Res call({
 VerseSelection passage
});




}
/// @nodoc
class _$PhraseReadActivityPlanCopyWithImpl<$Res>
    implements $PhraseReadActivityPlanCopyWith<$Res> {
  _$PhraseReadActivityPlanCopyWithImpl(this._self, this._then);

  final PhraseReadActivityPlan _self;
  final $Res Function(PhraseReadActivityPlan) _then;

/// Create a copy of ActivityPlan
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? passage = null,}) {
  return _then(PhraseReadActivityPlan(
passage: null == passage ? _self.passage : passage // ignore: cast_nullable_to_non_nullable
as VerseSelection,
  ));
}


}

/// @nodoc
@JsonSerializable()

class ReadContextActivityPlan extends ActivityPlan {
  const ReadContextActivityPlan({required this.passage,  String? $type}): $type = $type ?? 'readContext',super._();
  factory ReadContextActivityPlan.fromJson(Map<String, dynamic> json) => _$ReadContextActivityPlanFromJson(json);

@override final  VerseSelection passage;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of ActivityPlan
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReadContextActivityPlanCopyWith<ReadContextActivityPlan> get copyWith => _$ReadContextActivityPlanCopyWithImpl<ReadContextActivityPlan>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReadContextActivityPlanToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReadContextActivityPlan&&(identical(other.passage, passage) || other.passage == passage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,passage);

@override
String toString() {
  return 'ActivityPlan.readContext(passage: $passage)';
}


}

/// @nodoc
abstract mixin class $ReadContextActivityPlanCopyWith<$Res> implements $ActivityPlanCopyWith<$Res> {
  factory $ReadContextActivityPlanCopyWith(ReadContextActivityPlan value, $Res Function(ReadContextActivityPlan) _then) = _$ReadContextActivityPlanCopyWithImpl;
@override @useResult
$Res call({
 VerseSelection passage
});




}
/// @nodoc
class _$ReadContextActivityPlanCopyWithImpl<$Res>
    implements $ReadContextActivityPlanCopyWith<$Res> {
  _$ReadContextActivityPlanCopyWithImpl(this._self, this._then);

  final ReadContextActivityPlan _self;
  final $Res Function(ReadContextActivityPlan) _then;

/// Create a copy of ActivityPlan
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? passage = null,}) {
  return _then(ReadContextActivityPlan(
passage: null == passage ? _self.passage : passage // ignore: cast_nullable_to_non_nullable
as VerseSelection,
  ));
}


}

/// @nodoc
@JsonSerializable()

class PhraseSelectionActivityPlan extends ActivityPlan {
  const PhraseSelectionActivityPlan({required this.passage,  String? $type}): $type = $type ?? 'phraseSelection',super._();
  factory PhraseSelectionActivityPlan.fromJson(Map<String, dynamic> json) => _$PhraseSelectionActivityPlanFromJson(json);

@override final  VerseSelection passage;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of ActivityPlan
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PhraseSelectionActivityPlanCopyWith<PhraseSelectionActivityPlan> get copyWith => _$PhraseSelectionActivityPlanCopyWithImpl<PhraseSelectionActivityPlan>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PhraseSelectionActivityPlanToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PhraseSelectionActivityPlan&&(identical(other.passage, passage) || other.passage == passage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,passage);

@override
String toString() {
  return 'ActivityPlan.phraseSelection(passage: $passage)';
}


}

/// @nodoc
abstract mixin class $PhraseSelectionActivityPlanCopyWith<$Res> implements $ActivityPlanCopyWith<$Res> {
  factory $PhraseSelectionActivityPlanCopyWith(PhraseSelectionActivityPlan value, $Res Function(PhraseSelectionActivityPlan) _then) = _$PhraseSelectionActivityPlanCopyWithImpl;
@override @useResult
$Res call({
 VerseSelection passage
});




}
/// @nodoc
class _$PhraseSelectionActivityPlanCopyWithImpl<$Res>
    implements $PhraseSelectionActivityPlanCopyWith<$Res> {
  _$PhraseSelectionActivityPlanCopyWithImpl(this._self, this._then);

  final PhraseSelectionActivityPlan _self;
  final $Res Function(PhraseSelectionActivityPlan) _then;

/// Create a copy of ActivityPlan
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? passage = null,}) {
  return _then(PhraseSelectionActivityPlan(
passage: null == passage ? _self.passage : passage // ignore: cast_nullable_to_non_nullable
as VerseSelection,
  ));
}


}

/// @nodoc
@JsonSerializable()

class WordSelectionActivityPlan extends ActivityPlan {
  const WordSelectionActivityPlan({required this.passage,  String? $type}): $type = $type ?? 'wordSelection',super._();
  factory WordSelectionActivityPlan.fromJson(Map<String, dynamic> json) => _$WordSelectionActivityPlanFromJson(json);

@override final  VerseSelection passage;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of ActivityPlan
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WordSelectionActivityPlanCopyWith<WordSelectionActivityPlan> get copyWith => _$WordSelectionActivityPlanCopyWithImpl<WordSelectionActivityPlan>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WordSelectionActivityPlanToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WordSelectionActivityPlan&&(identical(other.passage, passage) || other.passage == passage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,passage);

@override
String toString() {
  return 'ActivityPlan.wordSelection(passage: $passage)';
}


}

/// @nodoc
abstract mixin class $WordSelectionActivityPlanCopyWith<$Res> implements $ActivityPlanCopyWith<$Res> {
  factory $WordSelectionActivityPlanCopyWith(WordSelectionActivityPlan value, $Res Function(WordSelectionActivityPlan) _then) = _$WordSelectionActivityPlanCopyWithImpl;
@override @useResult
$Res call({
 VerseSelection passage
});




}
/// @nodoc
class _$WordSelectionActivityPlanCopyWithImpl<$Res>
    implements $WordSelectionActivityPlanCopyWith<$Res> {
  _$WordSelectionActivityPlanCopyWithImpl(this._self, this._then);

  final WordSelectionActivityPlan _self;
  final $Res Function(WordSelectionActivityPlan) _then;

/// Create a copy of ActivityPlan
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? passage = null,}) {
  return _then(WordSelectionActivityPlan(
passage: null == passage ? _self.passage : passage // ignore: cast_nullable_to_non_nullable
as VerseSelection,
  ));
}


}

/// @nodoc
@JsonSerializable()

class WordTypeActivityPlan extends ActivityPlan {
  const WordTypeActivityPlan({required this.passage,  String? $type}): $type = $type ?? 'wordType',super._();
  factory WordTypeActivityPlan.fromJson(Map<String, dynamic> json) => _$WordTypeActivityPlanFromJson(json);

@override final  VerseSelection passage;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of ActivityPlan
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WordTypeActivityPlanCopyWith<WordTypeActivityPlan> get copyWith => _$WordTypeActivityPlanCopyWithImpl<WordTypeActivityPlan>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WordTypeActivityPlanToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WordTypeActivityPlan&&(identical(other.passage, passage) || other.passage == passage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,passage);

@override
String toString() {
  return 'ActivityPlan.wordType(passage: $passage)';
}


}

/// @nodoc
abstract mixin class $WordTypeActivityPlanCopyWith<$Res> implements $ActivityPlanCopyWith<$Res> {
  factory $WordTypeActivityPlanCopyWith(WordTypeActivityPlan value, $Res Function(WordTypeActivityPlan) _then) = _$WordTypeActivityPlanCopyWithImpl;
@override @useResult
$Res call({
 VerseSelection passage
});




}
/// @nodoc
class _$WordTypeActivityPlanCopyWithImpl<$Res>
    implements $WordTypeActivityPlanCopyWith<$Res> {
  _$WordTypeActivityPlanCopyWithImpl(this._self, this._then);

  final WordTypeActivityPlan _self;
  final $Res Function(WordTypeActivityPlan) _then;

/// Create a copy of ActivityPlan
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? passage = null,}) {
  return _then(WordTypeActivityPlan(
passage: null == passage ? _self.passage : passage // ignore: cast_nullable_to_non_nullable
as VerseSelection,
  ));
}


}

/// @nodoc
@JsonSerializable()

class ReferenceSelectionActivityPlan extends ActivityPlan {
  const ReferenceSelectionActivityPlan({required this.passage,  String? $type}): $type = $type ?? 'referenceSelection',super._();
  factory ReferenceSelectionActivityPlan.fromJson(Map<String, dynamic> json) => _$ReferenceSelectionActivityPlanFromJson(json);

@override final  VerseSelection passage;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of ActivityPlan
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReferenceSelectionActivityPlanCopyWith<ReferenceSelectionActivityPlan> get copyWith => _$ReferenceSelectionActivityPlanCopyWithImpl<ReferenceSelectionActivityPlan>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReferenceSelectionActivityPlanToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReferenceSelectionActivityPlan&&(identical(other.passage, passage) || other.passage == passage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,passage);

@override
String toString() {
  return 'ActivityPlan.referenceSelection(passage: $passage)';
}


}

/// @nodoc
abstract mixin class $ReferenceSelectionActivityPlanCopyWith<$Res> implements $ActivityPlanCopyWith<$Res> {
  factory $ReferenceSelectionActivityPlanCopyWith(ReferenceSelectionActivityPlan value, $Res Function(ReferenceSelectionActivityPlan) _then) = _$ReferenceSelectionActivityPlanCopyWithImpl;
@override @useResult
$Res call({
 VerseSelection passage
});




}
/// @nodoc
class _$ReferenceSelectionActivityPlanCopyWithImpl<$Res>
    implements $ReferenceSelectionActivityPlanCopyWith<$Res> {
  _$ReferenceSelectionActivityPlanCopyWithImpl(this._self, this._then);

  final ReferenceSelectionActivityPlan _self;
  final $Res Function(ReferenceSelectionActivityPlan) _then;

/// Create a copy of ActivityPlan
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? passage = null,}) {
  return _then(ReferenceSelectionActivityPlan(
passage: null == passage ? _self.passage : passage // ignore: cast_nullable_to_non_nullable
as VerseSelection,
  ));
}


}

/// @nodoc
@JsonSerializable()

class ReferenceTypeActivityPlan extends ActivityPlan {
  const ReferenceTypeActivityPlan({required this.passage,  String? $type}): $type = $type ?? 'referenceType',super._();
  factory ReferenceTypeActivityPlan.fromJson(Map<String, dynamic> json) => _$ReferenceTypeActivityPlanFromJson(json);

@override final  VerseSelection passage;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of ActivityPlan
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReferenceTypeActivityPlanCopyWith<ReferenceTypeActivityPlan> get copyWith => _$ReferenceTypeActivityPlanCopyWithImpl<ReferenceTypeActivityPlan>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReferenceTypeActivityPlanToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReferenceTypeActivityPlan&&(identical(other.passage, passage) || other.passage == passage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,passage);

@override
String toString() {
  return 'ActivityPlan.referenceType(passage: $passage)';
}


}

/// @nodoc
abstract mixin class $ReferenceTypeActivityPlanCopyWith<$Res> implements $ActivityPlanCopyWith<$Res> {
  factory $ReferenceTypeActivityPlanCopyWith(ReferenceTypeActivityPlan value, $Res Function(ReferenceTypeActivityPlan) _then) = _$ReferenceTypeActivityPlanCopyWithImpl;
@override @useResult
$Res call({
 VerseSelection passage
});




}
/// @nodoc
class _$ReferenceTypeActivityPlanCopyWithImpl<$Res>
    implements $ReferenceTypeActivityPlanCopyWith<$Res> {
  _$ReferenceTypeActivityPlanCopyWithImpl(this._self, this._then);

  final ReferenceTypeActivityPlan _self;
  final $Res Function(ReferenceTypeActivityPlan) _then;

/// Create a copy of ActivityPlan
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? passage = null,}) {
  return _then(ReferenceTypeActivityPlan(
passage: null == passage ? _self.passage : passage // ignore: cast_nullable_to_non_nullable
as VerseSelection,
  ));
}


}

// dart format on
