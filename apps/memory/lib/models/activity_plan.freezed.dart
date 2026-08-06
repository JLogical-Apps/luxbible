// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'activity_plan.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

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



  /// Serializes this ActivityPlan to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActivityPlan);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ActivityPlan()';
}


}

/// @nodoc
class $ActivityPlanCopyWith<$Res>  {
$ActivityPlanCopyWith(ActivityPlan _, $Res Function(ActivityPlan) __);
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  phraseRead,TResult Function()?  readContext,TResult Function()?  phraseSelection,TResult Function()?  wordSelection,TResult Function()?  wordType,TResult Function()?  referenceSelection,TResult Function()?  referenceType,required TResult orElse(),}) {final _that = this;
switch (_that) {
case PhraseReadActivityPlan() when phraseRead != null:
return phraseRead();case ReadContextActivityPlan() when readContext != null:
return readContext();case PhraseSelectionActivityPlan() when phraseSelection != null:
return phraseSelection();case WordSelectionActivityPlan() when wordSelection != null:
return wordSelection();case WordTypeActivityPlan() when wordType != null:
return wordType();case ReferenceSelectionActivityPlan() when referenceSelection != null:
return referenceSelection();case ReferenceTypeActivityPlan() when referenceType != null:
return referenceType();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  phraseRead,required TResult Function()  readContext,required TResult Function()  phraseSelection,required TResult Function()  wordSelection,required TResult Function()  wordType,required TResult Function()  referenceSelection,required TResult Function()  referenceType,}) {final _that = this;
switch (_that) {
case PhraseReadActivityPlan():
return phraseRead();case ReadContextActivityPlan():
return readContext();case PhraseSelectionActivityPlan():
return phraseSelection();case WordSelectionActivityPlan():
return wordSelection();case WordTypeActivityPlan():
return wordType();case ReferenceSelectionActivityPlan():
return referenceSelection();case ReferenceTypeActivityPlan():
return referenceType();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  phraseRead,TResult? Function()?  readContext,TResult? Function()?  phraseSelection,TResult? Function()?  wordSelection,TResult? Function()?  wordType,TResult? Function()?  referenceSelection,TResult? Function()?  referenceType,}) {final _that = this;
switch (_that) {
case PhraseReadActivityPlan() when phraseRead != null:
return phraseRead();case ReadContextActivityPlan() when readContext != null:
return readContext();case PhraseSelectionActivityPlan() when phraseSelection != null:
return phraseSelection();case WordSelectionActivityPlan() when wordSelection != null:
return wordSelection();case WordTypeActivityPlan() when wordType != null:
return wordType();case ReferenceSelectionActivityPlan() when referenceSelection != null:
return referenceSelection();case ReferenceTypeActivityPlan() when referenceType != null:
return referenceType();case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class PhraseReadActivityPlan extends ActivityPlan {
  const PhraseReadActivityPlan({final  String? $type}): $type = $type ?? 'phraseRead',super._();
  factory PhraseReadActivityPlan.fromJson(Map<String, dynamic> json) => _$PhraseReadActivityPlanFromJson(json);



@JsonKey(name: 'runtimeType')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$PhraseReadActivityPlanToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PhraseReadActivityPlan);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ActivityPlan.phraseRead()';
}


}




/// @nodoc
@JsonSerializable()

class ReadContextActivityPlan extends ActivityPlan {
  const ReadContextActivityPlan({final  String? $type}): $type = $type ?? 'readContext',super._();
  factory ReadContextActivityPlan.fromJson(Map<String, dynamic> json) => _$ReadContextActivityPlanFromJson(json);



@JsonKey(name: 'runtimeType')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$ReadContextActivityPlanToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReadContextActivityPlan);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ActivityPlan.readContext()';
}


}




/// @nodoc
@JsonSerializable()

class PhraseSelectionActivityPlan extends ActivityPlan {
  const PhraseSelectionActivityPlan({final  String? $type}): $type = $type ?? 'phraseSelection',super._();
  factory PhraseSelectionActivityPlan.fromJson(Map<String, dynamic> json) => _$PhraseSelectionActivityPlanFromJson(json);



@JsonKey(name: 'runtimeType')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$PhraseSelectionActivityPlanToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PhraseSelectionActivityPlan);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ActivityPlan.phraseSelection()';
}


}




/// @nodoc
@JsonSerializable()

class WordSelectionActivityPlan extends ActivityPlan {
  const WordSelectionActivityPlan({final  String? $type}): $type = $type ?? 'wordSelection',super._();
  factory WordSelectionActivityPlan.fromJson(Map<String, dynamic> json) => _$WordSelectionActivityPlanFromJson(json);



@JsonKey(name: 'runtimeType')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$WordSelectionActivityPlanToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WordSelectionActivityPlan);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ActivityPlan.wordSelection()';
}


}




/// @nodoc
@JsonSerializable()

class WordTypeActivityPlan extends ActivityPlan {
  const WordTypeActivityPlan({final  String? $type}): $type = $type ?? 'wordType',super._();
  factory WordTypeActivityPlan.fromJson(Map<String, dynamic> json) => _$WordTypeActivityPlanFromJson(json);



@JsonKey(name: 'runtimeType')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$WordTypeActivityPlanToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WordTypeActivityPlan);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ActivityPlan.wordType()';
}


}




/// @nodoc
@JsonSerializable()

class ReferenceSelectionActivityPlan extends ActivityPlan {
  const ReferenceSelectionActivityPlan({final  String? $type}): $type = $type ?? 'referenceSelection',super._();
  factory ReferenceSelectionActivityPlan.fromJson(Map<String, dynamic> json) => _$ReferenceSelectionActivityPlanFromJson(json);



@JsonKey(name: 'runtimeType')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$ReferenceSelectionActivityPlanToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReferenceSelectionActivityPlan);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ActivityPlan.referenceSelection()';
}


}




/// @nodoc
@JsonSerializable()

class ReferenceTypeActivityPlan extends ActivityPlan {
  const ReferenceTypeActivityPlan({final  String? $type}): $type = $type ?? 'referenceType',super._();
  factory ReferenceTypeActivityPlan.fromJson(Map<String, dynamic> json) => _$ReferenceTypeActivityPlanFromJson(json);



@JsonKey(name: 'runtimeType')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$ReferenceTypeActivityPlanToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReferenceTypeActivityPlan);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ActivityPlan.referenceType()';
}


}




// dart format on
