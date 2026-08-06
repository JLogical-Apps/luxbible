// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'activity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
Activity _$ActivityFromJson(
  Map<String, dynamic> json
) {
        switch (json['runtimeType']) {
                  case 'phraseRead':
          return PhraseReadActivity.fromJson(
            json
          );
                case 'readContext':
          return ReadContextActivity.fromJson(
            json
          );
                case 'phraseSelection':
          return PhraseSelectionActivity.fromJson(
            json
          );
                case 'wordSelection':
          return WordSelectionActivity.fromJson(
            json
          );
                case 'wordType':
          return WordTypeActivity.fromJson(
            json
          );
                case 'referenceSelection':
          return ReferenceSelectionActivity.fromJson(
            json
          );
                case 'referenceType':
          return ReferenceTypeActivity.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'runtimeType',
  'Activity',
  'Invalid union type "${json['runtimeType']}"!'
);
        }
      
}

/// @nodoc
mixin _$Activity {

 InvalidType get plan;
/// Create a copy of Activity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActivityCopyWith<Activity> get copyWith => _$ActivityCopyWithImpl<Activity>(this as Activity, _$identity);

  /// Serializes this Activity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Activity&&const DeepCollectionEquality().equals(other.plan, plan));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(plan));

@override
String toString() {
  return 'Activity(plan: $plan)';
}


}

/// @nodoc
abstract mixin class $ActivityCopyWith<$Res>  {
  factory $ActivityCopyWith(Activity value, $Res Function(Activity) _then) = _$ActivityCopyWithImpl;
@useResult
$Res call({
 InvalidType plan
});




}
/// @nodoc
class _$ActivityCopyWithImpl<$Res>
    implements $ActivityCopyWith<$Res> {
  _$ActivityCopyWithImpl(this._self, this._then);

  final Activity _self;
  final $Res Function(Activity) _then;

/// Create a copy of Activity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? plan = freezed,}) {
  return _then(_self.copyWith(
plan: freezed == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as InvalidType,
  ));
}

}


/// Adds pattern-matching-related methods to [Activity].
extension ActivityPatterns on Activity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( PhraseReadActivity value)?  phraseRead,TResult Function( ReadContextActivity value)?  readContext,TResult Function( PhraseSelectionActivity value)?  phraseSelection,TResult Function( WordSelectionActivity value)?  wordSelection,TResult Function( WordTypeActivity value)?  wordType,TResult Function( ReferenceSelectionActivity value)?  referenceSelection,TResult Function( ReferenceTypeActivity value)?  referenceType,required TResult orElse(),}){
final _that = this;
switch (_that) {
case PhraseReadActivity() when phraseRead != null:
return phraseRead(_that);case ReadContextActivity() when readContext != null:
return readContext(_that);case PhraseSelectionActivity() when phraseSelection != null:
return phraseSelection(_that);case WordSelectionActivity() when wordSelection != null:
return wordSelection(_that);case WordTypeActivity() when wordType != null:
return wordType(_that);case ReferenceSelectionActivity() when referenceSelection != null:
return referenceSelection(_that);case ReferenceTypeActivity() when referenceType != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( PhraseReadActivity value)  phraseRead,required TResult Function( ReadContextActivity value)  readContext,required TResult Function( PhraseSelectionActivity value)  phraseSelection,required TResult Function( WordSelectionActivity value)  wordSelection,required TResult Function( WordTypeActivity value)  wordType,required TResult Function( ReferenceSelectionActivity value)  referenceSelection,required TResult Function( ReferenceTypeActivity value)  referenceType,}){
final _that = this;
switch (_that) {
case PhraseReadActivity():
return phraseRead(_that);case ReadContextActivity():
return readContext(_that);case PhraseSelectionActivity():
return phraseSelection(_that);case WordSelectionActivity():
return wordSelection(_that);case WordTypeActivity():
return wordType(_that);case ReferenceSelectionActivity():
return referenceSelection(_that);case ReferenceTypeActivity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( PhraseReadActivity value)?  phraseRead,TResult? Function( ReadContextActivity value)?  readContext,TResult? Function( PhraseSelectionActivity value)?  phraseSelection,TResult? Function( WordSelectionActivity value)?  wordSelection,TResult? Function( WordTypeActivity value)?  wordType,TResult? Function( ReferenceSelectionActivity value)?  referenceSelection,TResult? Function( ReferenceTypeActivity value)?  referenceType,}){
final _that = this;
switch (_that) {
case PhraseReadActivity() when phraseRead != null:
return phraseRead(_that);case ReadContextActivity() when readContext != null:
return readContext(_that);case PhraseSelectionActivity() when phraseSelection != null:
return phraseSelection(_that);case WordSelectionActivity() when wordSelection != null:
return wordSelection(_that);case WordTypeActivity() when wordType != null:
return wordType(_that);case ReferenceSelectionActivity() when referenceSelection != null:
return referenceSelection(_that);case ReferenceTypeActivity() when referenceType != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( PhraseReadActivityPlan plan)?  phraseRead,TResult Function( ReadContextActivityPlan plan)?  readContext,TResult Function( PhraseSelectionActivityPlan plan)?  phraseSelection,TResult Function( WordSelectionActivityPlan plan)?  wordSelection,TResult Function( WordTypeActivityPlan plan)?  wordType,TResult Function( ReferenceSelectionActivityPlan plan)?  referenceSelection,TResult Function( ReferenceTypeActivityPlan plan)?  referenceType,required TResult orElse(),}) {final _that = this;
switch (_that) {
case PhraseReadActivity() when phraseRead != null:
return phraseRead(_that.plan);case ReadContextActivity() when readContext != null:
return readContext(_that.plan);case PhraseSelectionActivity() when phraseSelection != null:
return phraseSelection(_that.plan);case WordSelectionActivity() when wordSelection != null:
return wordSelection(_that.plan);case WordTypeActivity() when wordType != null:
return wordType(_that.plan);case ReferenceSelectionActivity() when referenceSelection != null:
return referenceSelection(_that.plan);case ReferenceTypeActivity() when referenceType != null:
return referenceType(_that.plan);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( PhraseReadActivityPlan plan)  phraseRead,required TResult Function( ReadContextActivityPlan plan)  readContext,required TResult Function( PhraseSelectionActivityPlan plan)  phraseSelection,required TResult Function( WordSelectionActivityPlan plan)  wordSelection,required TResult Function( WordTypeActivityPlan plan)  wordType,required TResult Function( ReferenceSelectionActivityPlan plan)  referenceSelection,required TResult Function( ReferenceTypeActivityPlan plan)  referenceType,}) {final _that = this;
switch (_that) {
case PhraseReadActivity():
return phraseRead(_that.plan);case ReadContextActivity():
return readContext(_that.plan);case PhraseSelectionActivity():
return phraseSelection(_that.plan);case WordSelectionActivity():
return wordSelection(_that.plan);case WordTypeActivity():
return wordType(_that.plan);case ReferenceSelectionActivity():
return referenceSelection(_that.plan);case ReferenceTypeActivity():
return referenceType(_that.plan);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( PhraseReadActivityPlan plan)?  phraseRead,TResult? Function( ReadContextActivityPlan plan)?  readContext,TResult? Function( PhraseSelectionActivityPlan plan)?  phraseSelection,TResult? Function( WordSelectionActivityPlan plan)?  wordSelection,TResult? Function( WordTypeActivityPlan plan)?  wordType,TResult? Function( ReferenceSelectionActivityPlan plan)?  referenceSelection,TResult? Function( ReferenceTypeActivityPlan plan)?  referenceType,}) {final _that = this;
switch (_that) {
case PhraseReadActivity() when phraseRead != null:
return phraseRead(_that.plan);case ReadContextActivity() when readContext != null:
return readContext(_that.plan);case PhraseSelectionActivity() when phraseSelection != null:
return phraseSelection(_that.plan);case WordSelectionActivity() when wordSelection != null:
return wordSelection(_that.plan);case WordTypeActivity() when wordType != null:
return wordType(_that.plan);case ReferenceSelectionActivity() when referenceSelection != null:
return referenceSelection(_that.plan);case ReferenceTypeActivity() when referenceType != null:
return referenceType(_that.plan);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class PhraseReadActivity extends Activity {
  const PhraseReadActivity({required this.plan, final  String? $type}): $type = $type ?? 'phraseRead',super._();
  factory PhraseReadActivity.fromJson(Map<String, dynamic> json) => _$PhraseReadActivityFromJson(json);

@override final  PhraseReadActivityPlan plan;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of Activity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PhraseReadActivityCopyWith<PhraseReadActivity> get copyWith => _$PhraseReadActivityCopyWithImpl<PhraseReadActivity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PhraseReadActivityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PhraseReadActivity&&const DeepCollectionEquality().equals(other.plan, plan));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(plan));

@override
String toString() {
  return 'Activity.phraseRead(plan: $plan)';
}


}

/// @nodoc
abstract mixin class $PhraseReadActivityCopyWith<$Res> implements $ActivityCopyWith<$Res> {
  factory $PhraseReadActivityCopyWith(PhraseReadActivity value, $Res Function(PhraseReadActivity) _then) = _$PhraseReadActivityCopyWithImpl;
@override @useResult
$Res call({
 PhraseReadActivityPlan plan
});




}
/// @nodoc
class _$PhraseReadActivityCopyWithImpl<$Res>
    implements $PhraseReadActivityCopyWith<$Res> {
  _$PhraseReadActivityCopyWithImpl(this._self, this._then);

  final PhraseReadActivity _self;
  final $Res Function(PhraseReadActivity) _then;

/// Create a copy of Activity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? plan = freezed,}) {
  return _then(PhraseReadActivity(
plan: freezed == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as PhraseReadActivityPlan,
  ));
}


}

/// @nodoc
@JsonSerializable()

class ReadContextActivity extends Activity {
  const ReadContextActivity({required this.plan, final  String? $type}): $type = $type ?? 'readContext',super._();
  factory ReadContextActivity.fromJson(Map<String, dynamic> json) => _$ReadContextActivityFromJson(json);

@override final  ReadContextActivityPlan plan;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of Activity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReadContextActivityCopyWith<ReadContextActivity> get copyWith => _$ReadContextActivityCopyWithImpl<ReadContextActivity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReadContextActivityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReadContextActivity&&const DeepCollectionEquality().equals(other.plan, plan));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(plan));

@override
String toString() {
  return 'Activity.readContext(plan: $plan)';
}


}

/// @nodoc
abstract mixin class $ReadContextActivityCopyWith<$Res> implements $ActivityCopyWith<$Res> {
  factory $ReadContextActivityCopyWith(ReadContextActivity value, $Res Function(ReadContextActivity) _then) = _$ReadContextActivityCopyWithImpl;
@override @useResult
$Res call({
 ReadContextActivityPlan plan
});




}
/// @nodoc
class _$ReadContextActivityCopyWithImpl<$Res>
    implements $ReadContextActivityCopyWith<$Res> {
  _$ReadContextActivityCopyWithImpl(this._self, this._then);

  final ReadContextActivity _self;
  final $Res Function(ReadContextActivity) _then;

/// Create a copy of Activity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? plan = freezed,}) {
  return _then(ReadContextActivity(
plan: freezed == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as ReadContextActivityPlan,
  ));
}


}

/// @nodoc
@JsonSerializable()

class PhraseSelectionActivity extends Activity {
  const PhraseSelectionActivity({required this.plan, final  String? $type}): $type = $type ?? 'phraseSelection',super._();
  factory PhraseSelectionActivity.fromJson(Map<String, dynamic> json) => _$PhraseSelectionActivityFromJson(json);

@override final  PhraseSelectionActivityPlan plan;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of Activity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PhraseSelectionActivityCopyWith<PhraseSelectionActivity> get copyWith => _$PhraseSelectionActivityCopyWithImpl<PhraseSelectionActivity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PhraseSelectionActivityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PhraseSelectionActivity&&const DeepCollectionEquality().equals(other.plan, plan));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(plan));

@override
String toString() {
  return 'Activity.phraseSelection(plan: $plan)';
}


}

/// @nodoc
abstract mixin class $PhraseSelectionActivityCopyWith<$Res> implements $ActivityCopyWith<$Res> {
  factory $PhraseSelectionActivityCopyWith(PhraseSelectionActivity value, $Res Function(PhraseSelectionActivity) _then) = _$PhraseSelectionActivityCopyWithImpl;
@override @useResult
$Res call({
 PhraseSelectionActivityPlan plan
});




}
/// @nodoc
class _$PhraseSelectionActivityCopyWithImpl<$Res>
    implements $PhraseSelectionActivityCopyWith<$Res> {
  _$PhraseSelectionActivityCopyWithImpl(this._self, this._then);

  final PhraseSelectionActivity _self;
  final $Res Function(PhraseSelectionActivity) _then;

/// Create a copy of Activity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? plan = freezed,}) {
  return _then(PhraseSelectionActivity(
plan: freezed == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as PhraseSelectionActivityPlan,
  ));
}


}

/// @nodoc
@JsonSerializable()

class WordSelectionActivity extends Activity {
  const WordSelectionActivity({required this.plan, final  String? $type}): $type = $type ?? 'wordSelection',super._();
  factory WordSelectionActivity.fromJson(Map<String, dynamic> json) => _$WordSelectionActivityFromJson(json);

@override final  WordSelectionActivityPlan plan;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of Activity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WordSelectionActivityCopyWith<WordSelectionActivity> get copyWith => _$WordSelectionActivityCopyWithImpl<WordSelectionActivity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WordSelectionActivityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WordSelectionActivity&&const DeepCollectionEquality().equals(other.plan, plan));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(plan));

@override
String toString() {
  return 'Activity.wordSelection(plan: $plan)';
}


}

/// @nodoc
abstract mixin class $WordSelectionActivityCopyWith<$Res> implements $ActivityCopyWith<$Res> {
  factory $WordSelectionActivityCopyWith(WordSelectionActivity value, $Res Function(WordSelectionActivity) _then) = _$WordSelectionActivityCopyWithImpl;
@override @useResult
$Res call({
 WordSelectionActivityPlan plan
});




}
/// @nodoc
class _$WordSelectionActivityCopyWithImpl<$Res>
    implements $WordSelectionActivityCopyWith<$Res> {
  _$WordSelectionActivityCopyWithImpl(this._self, this._then);

  final WordSelectionActivity _self;
  final $Res Function(WordSelectionActivity) _then;

/// Create a copy of Activity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? plan = freezed,}) {
  return _then(WordSelectionActivity(
plan: freezed == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as WordSelectionActivityPlan,
  ));
}


}

/// @nodoc
@JsonSerializable()

class WordTypeActivity extends Activity {
  const WordTypeActivity({required this.plan, final  String? $type}): $type = $type ?? 'wordType',super._();
  factory WordTypeActivity.fromJson(Map<String, dynamic> json) => _$WordTypeActivityFromJson(json);

@override final  WordTypeActivityPlan plan;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of Activity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WordTypeActivityCopyWith<WordTypeActivity> get copyWith => _$WordTypeActivityCopyWithImpl<WordTypeActivity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WordTypeActivityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WordTypeActivity&&const DeepCollectionEquality().equals(other.plan, plan));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(plan));

@override
String toString() {
  return 'Activity.wordType(plan: $plan)';
}


}

/// @nodoc
abstract mixin class $WordTypeActivityCopyWith<$Res> implements $ActivityCopyWith<$Res> {
  factory $WordTypeActivityCopyWith(WordTypeActivity value, $Res Function(WordTypeActivity) _then) = _$WordTypeActivityCopyWithImpl;
@override @useResult
$Res call({
 WordTypeActivityPlan plan
});




}
/// @nodoc
class _$WordTypeActivityCopyWithImpl<$Res>
    implements $WordTypeActivityCopyWith<$Res> {
  _$WordTypeActivityCopyWithImpl(this._self, this._then);

  final WordTypeActivity _self;
  final $Res Function(WordTypeActivity) _then;

/// Create a copy of Activity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? plan = freezed,}) {
  return _then(WordTypeActivity(
plan: freezed == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as WordTypeActivityPlan,
  ));
}


}

/// @nodoc
@JsonSerializable()

class ReferenceSelectionActivity extends Activity {
  const ReferenceSelectionActivity({required this.plan, final  String? $type}): $type = $type ?? 'referenceSelection',super._();
  factory ReferenceSelectionActivity.fromJson(Map<String, dynamic> json) => _$ReferenceSelectionActivityFromJson(json);

@override final  ReferenceSelectionActivityPlan plan;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of Activity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReferenceSelectionActivityCopyWith<ReferenceSelectionActivity> get copyWith => _$ReferenceSelectionActivityCopyWithImpl<ReferenceSelectionActivity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReferenceSelectionActivityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReferenceSelectionActivity&&const DeepCollectionEquality().equals(other.plan, plan));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(plan));

@override
String toString() {
  return 'Activity.referenceSelection(plan: $plan)';
}


}

/// @nodoc
abstract mixin class $ReferenceSelectionActivityCopyWith<$Res> implements $ActivityCopyWith<$Res> {
  factory $ReferenceSelectionActivityCopyWith(ReferenceSelectionActivity value, $Res Function(ReferenceSelectionActivity) _then) = _$ReferenceSelectionActivityCopyWithImpl;
@override @useResult
$Res call({
 ReferenceSelectionActivityPlan plan
});




}
/// @nodoc
class _$ReferenceSelectionActivityCopyWithImpl<$Res>
    implements $ReferenceSelectionActivityCopyWith<$Res> {
  _$ReferenceSelectionActivityCopyWithImpl(this._self, this._then);

  final ReferenceSelectionActivity _self;
  final $Res Function(ReferenceSelectionActivity) _then;

/// Create a copy of Activity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? plan = freezed,}) {
  return _then(ReferenceSelectionActivity(
plan: freezed == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as ReferenceSelectionActivityPlan,
  ));
}


}

/// @nodoc
@JsonSerializable()

class ReferenceTypeActivity extends Activity {
  const ReferenceTypeActivity({required this.plan, final  String? $type}): $type = $type ?? 'referenceType',super._();
  factory ReferenceTypeActivity.fromJson(Map<String, dynamic> json) => _$ReferenceTypeActivityFromJson(json);

@override final  ReferenceTypeActivityPlan plan;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of Activity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReferenceTypeActivityCopyWith<ReferenceTypeActivity> get copyWith => _$ReferenceTypeActivityCopyWithImpl<ReferenceTypeActivity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReferenceTypeActivityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReferenceTypeActivity&&const DeepCollectionEquality().equals(other.plan, plan));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(plan));

@override
String toString() {
  return 'Activity.referenceType(plan: $plan)';
}


}

/// @nodoc
abstract mixin class $ReferenceTypeActivityCopyWith<$Res> implements $ActivityCopyWith<$Res> {
  factory $ReferenceTypeActivityCopyWith(ReferenceTypeActivity value, $Res Function(ReferenceTypeActivity) _then) = _$ReferenceTypeActivityCopyWithImpl;
@override @useResult
$Res call({
 ReferenceTypeActivityPlan plan
});




}
/// @nodoc
class _$ReferenceTypeActivityCopyWithImpl<$Res>
    implements $ReferenceTypeActivityCopyWith<$Res> {
  _$ReferenceTypeActivityCopyWithImpl(this._self, this._then);

  final ReferenceTypeActivity _self;
  final $Res Function(ReferenceTypeActivity) _then;

/// Create a copy of Activity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? plan = freezed,}) {
  return _then(ReferenceTypeActivity(
plan: freezed == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as ReferenceTypeActivityPlan,
  ));
}


}

// dart format on
