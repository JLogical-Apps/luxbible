// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bible_plan.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BiblePlan {

 String get name; String get description; List<BiblePlanDay> get days;
/// Create a copy of BiblePlan
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BiblePlanCopyWith<BiblePlan> get copyWith => _$BiblePlanCopyWithImpl<BiblePlan>(this as BiblePlan, _$identity);

  /// Serializes this BiblePlan to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BiblePlan&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.days, days));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,description,const DeepCollectionEquality().hash(days));

@override
String toString() {
  return 'BiblePlan(name: $name, description: $description, days: $days)';
}


}

/// @nodoc
abstract mixin class $BiblePlanCopyWith<$Res>  {
  factory $BiblePlanCopyWith(BiblePlan value, $Res Function(BiblePlan) _then) = _$BiblePlanCopyWithImpl;
@useResult
$Res call({
 String name, String description, List<BiblePlanDay> days
});




}
/// @nodoc
class _$BiblePlanCopyWithImpl<$Res>
    implements $BiblePlanCopyWith<$Res> {
  _$BiblePlanCopyWithImpl(this._self, this._then);

  final BiblePlan _self;
  final $Res Function(BiblePlan) _then;

/// Create a copy of BiblePlan
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? description = null,Object? days = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,days: null == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as List<BiblePlanDay>,
  ));
}

}


/// Adds pattern-matching-related methods to [BiblePlan].
extension BiblePlanPatterns on BiblePlan {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BiblePlan value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BiblePlan() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BiblePlan value)  $default,){
final _that = this;
switch (_that) {
case _BiblePlan():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BiblePlan value)?  $default,){
final _that = this;
switch (_that) {
case _BiblePlan() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String description,  List<BiblePlanDay> days)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BiblePlan() when $default != null:
return $default(_that.name,_that.description,_that.days);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String description,  List<BiblePlanDay> days)  $default,) {final _that = this;
switch (_that) {
case _BiblePlan():
return $default(_that.name,_that.description,_that.days);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String description,  List<BiblePlanDay> days)?  $default,) {final _that = this;
switch (_that) {
case _BiblePlan() when $default != null:
return $default(_that.name,_that.description,_that.days);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BiblePlan extends BiblePlan {
  const _BiblePlan({required this.name, this.description = '', required final  List<BiblePlanDay> days}): _days = days,super._();
  factory _BiblePlan.fromJson(Map<String, dynamic> json) => _$BiblePlanFromJson(json);

@override final  String name;
@override@JsonKey() final  String description;
 final  List<BiblePlanDay> _days;
@override List<BiblePlanDay> get days {
  if (_days is EqualUnmodifiableListView) return _days;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_days);
}


/// Create a copy of BiblePlan
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BiblePlanCopyWith<_BiblePlan> get copyWith => __$BiblePlanCopyWithImpl<_BiblePlan>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BiblePlanToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BiblePlan&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._days, _days));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,description,const DeepCollectionEquality().hash(_days));

@override
String toString() {
  return 'BiblePlan(name: $name, description: $description, days: $days)';
}


}

/// @nodoc
abstract mixin class _$BiblePlanCopyWith<$Res> implements $BiblePlanCopyWith<$Res> {
  factory _$BiblePlanCopyWith(_BiblePlan value, $Res Function(_BiblePlan) _then) = __$BiblePlanCopyWithImpl;
@override @useResult
$Res call({
 String name, String description, List<BiblePlanDay> days
});




}
/// @nodoc
class __$BiblePlanCopyWithImpl<$Res>
    implements _$BiblePlanCopyWith<$Res> {
  __$BiblePlanCopyWithImpl(this._self, this._then);

  final _BiblePlan _self;
  final $Res Function(_BiblePlan) _then;

/// Create a copy of BiblePlan
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? description = null,Object? days = null,}) {
  return _then(_BiblePlan(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,days: null == days ? _self._days : days // ignore: cast_nullable_to_non_nullable
as List<BiblePlanDay>,
  ));
}


}


/// @nodoc
mixin _$BiblePlanDay {

 List<VerseSelection> get passages;
/// Create a copy of BiblePlanDay
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BiblePlanDayCopyWith<BiblePlanDay> get copyWith => _$BiblePlanDayCopyWithImpl<BiblePlanDay>(this as BiblePlanDay, _$identity);

  /// Serializes this BiblePlanDay to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BiblePlanDay&&const DeepCollectionEquality().equals(other.passages, passages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(passages));

@override
String toString() {
  return 'BiblePlanDay(passages: $passages)';
}


}

/// @nodoc
abstract mixin class $BiblePlanDayCopyWith<$Res>  {
  factory $BiblePlanDayCopyWith(BiblePlanDay value, $Res Function(BiblePlanDay) _then) = _$BiblePlanDayCopyWithImpl;
@useResult
$Res call({
 List<VerseSelection> passages
});




}
/// @nodoc
class _$BiblePlanDayCopyWithImpl<$Res>
    implements $BiblePlanDayCopyWith<$Res> {
  _$BiblePlanDayCopyWithImpl(this._self, this._then);

  final BiblePlanDay _self;
  final $Res Function(BiblePlanDay) _then;

/// Create a copy of BiblePlanDay
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? passages = null,}) {
  return _then(_self.copyWith(
passages: null == passages ? _self.passages : passages // ignore: cast_nullable_to_non_nullable
as List<VerseSelection>,
  ));
}

}


/// Adds pattern-matching-related methods to [BiblePlanDay].
extension BiblePlanDayPatterns on BiblePlanDay {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BiblePlanDay value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BiblePlanDay() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BiblePlanDay value)  $default,){
final _that = this;
switch (_that) {
case _BiblePlanDay():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BiblePlanDay value)?  $default,){
final _that = this;
switch (_that) {
case _BiblePlanDay() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<VerseSelection> passages)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BiblePlanDay() when $default != null:
return $default(_that.passages);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<VerseSelection> passages)  $default,) {final _that = this;
switch (_that) {
case _BiblePlanDay():
return $default(_that.passages);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<VerseSelection> passages)?  $default,) {final _that = this;
switch (_that) {
case _BiblePlanDay() when $default != null:
return $default(_that.passages);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BiblePlanDay extends BiblePlanDay {
  const _BiblePlanDay({final  List<VerseSelection> passages = const []}): _passages = passages,super._();
  factory _BiblePlanDay.fromJson(Map<String, dynamic> json) => _$BiblePlanDayFromJson(json);

 final  List<VerseSelection> _passages;
@override@JsonKey() List<VerseSelection> get passages {
  if (_passages is EqualUnmodifiableListView) return _passages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_passages);
}


/// Create a copy of BiblePlanDay
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BiblePlanDayCopyWith<_BiblePlanDay> get copyWith => __$BiblePlanDayCopyWithImpl<_BiblePlanDay>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BiblePlanDayToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BiblePlanDay&&const DeepCollectionEquality().equals(other._passages, _passages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_passages));

@override
String toString() {
  return 'BiblePlanDay(passages: $passages)';
}


}

/// @nodoc
abstract mixin class _$BiblePlanDayCopyWith<$Res> implements $BiblePlanDayCopyWith<$Res> {
  factory _$BiblePlanDayCopyWith(_BiblePlanDay value, $Res Function(_BiblePlanDay) _then) = __$BiblePlanDayCopyWithImpl;
@override @useResult
$Res call({
 List<VerseSelection> passages
});




}
/// @nodoc
class __$BiblePlanDayCopyWithImpl<$Res>
    implements _$BiblePlanDayCopyWith<$Res> {
  __$BiblePlanDayCopyWithImpl(this._self, this._then);

  final _BiblePlanDay _self;
  final $Res Function(_BiblePlanDay) _then;

/// Create a copy of BiblePlanDay
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? passages = null,}) {
  return _then(_BiblePlanDay(
passages: null == passages ? _self._passages : passages // ignore: cast_nullable_to_non_nullable
as List<VerseSelection>,
  ));
}


}


/// @nodoc
mixin _$BiblePlanProgress {

 List<BiblePlanDayProgress> get days;
/// Create a copy of BiblePlanProgress
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BiblePlanProgressCopyWith<BiblePlanProgress> get copyWith => _$BiblePlanProgressCopyWithImpl<BiblePlanProgress>(this as BiblePlanProgress, _$identity);

  /// Serializes this BiblePlanProgress to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BiblePlanProgress&&const DeepCollectionEquality().equals(other.days, days));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(days));

@override
String toString() {
  return 'BiblePlanProgress(days: $days)';
}


}

/// @nodoc
abstract mixin class $BiblePlanProgressCopyWith<$Res>  {
  factory $BiblePlanProgressCopyWith(BiblePlanProgress value, $Res Function(BiblePlanProgress) _then) = _$BiblePlanProgressCopyWithImpl;
@useResult
$Res call({
 List<BiblePlanDayProgress> days
});




}
/// @nodoc
class _$BiblePlanProgressCopyWithImpl<$Res>
    implements $BiblePlanProgressCopyWith<$Res> {
  _$BiblePlanProgressCopyWithImpl(this._self, this._then);

  final BiblePlanProgress _self;
  final $Res Function(BiblePlanProgress) _then;

/// Create a copy of BiblePlanProgress
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? days = null,}) {
  return _then(_self.copyWith(
days: null == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as List<BiblePlanDayProgress>,
  ));
}

}


/// Adds pattern-matching-related methods to [BiblePlanProgress].
extension BiblePlanProgressPatterns on BiblePlanProgress {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BiblePlanProgress value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BiblePlanProgress() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BiblePlanProgress value)  $default,){
final _that = this;
switch (_that) {
case _BiblePlanProgress():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BiblePlanProgress value)?  $default,){
final _that = this;
switch (_that) {
case _BiblePlanProgress() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<BiblePlanDayProgress> days)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BiblePlanProgress() when $default != null:
return $default(_that.days);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<BiblePlanDayProgress> days)  $default,) {final _that = this;
switch (_that) {
case _BiblePlanProgress():
return $default(_that.days);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<BiblePlanDayProgress> days)?  $default,) {final _that = this;
switch (_that) {
case _BiblePlanProgress() when $default != null:
return $default(_that.days);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BiblePlanProgress extends BiblePlanProgress {
  const _BiblePlanProgress({required final  List<BiblePlanDayProgress> days}): _days = days,super._();
  factory _BiblePlanProgress.fromJson(Map<String, dynamic> json) => _$BiblePlanProgressFromJson(json);

 final  List<BiblePlanDayProgress> _days;
@override List<BiblePlanDayProgress> get days {
  if (_days is EqualUnmodifiableListView) return _days;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_days);
}


/// Create a copy of BiblePlanProgress
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BiblePlanProgressCopyWith<_BiblePlanProgress> get copyWith => __$BiblePlanProgressCopyWithImpl<_BiblePlanProgress>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BiblePlanProgressToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BiblePlanProgress&&const DeepCollectionEquality().equals(other._days, _days));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_days));

@override
String toString() {
  return 'BiblePlanProgress(days: $days)';
}


}

/// @nodoc
abstract mixin class _$BiblePlanProgressCopyWith<$Res> implements $BiblePlanProgressCopyWith<$Res> {
  factory _$BiblePlanProgressCopyWith(_BiblePlanProgress value, $Res Function(_BiblePlanProgress) _then) = __$BiblePlanProgressCopyWithImpl;
@override @useResult
$Res call({
 List<BiblePlanDayProgress> days
});




}
/// @nodoc
class __$BiblePlanProgressCopyWithImpl<$Res>
    implements _$BiblePlanProgressCopyWith<$Res> {
  __$BiblePlanProgressCopyWithImpl(this._self, this._then);

  final _BiblePlanProgress _self;
  final $Res Function(_BiblePlanProgress) _then;

/// Create a copy of BiblePlanProgress
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? days = null,}) {
  return _then(_BiblePlanProgress(
days: null == days ? _self._days : days // ignore: cast_nullable_to_non_nullable
as List<BiblePlanDayProgress>,
  ));
}


}


/// @nodoc
mixin _$BiblePlanDayProgress {

 Set<VerseSelection> get completedPassages;
/// Create a copy of BiblePlanDayProgress
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BiblePlanDayProgressCopyWith<BiblePlanDayProgress> get copyWith => _$BiblePlanDayProgressCopyWithImpl<BiblePlanDayProgress>(this as BiblePlanDayProgress, _$identity);

  /// Serializes this BiblePlanDayProgress to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BiblePlanDayProgress&&const DeepCollectionEquality().equals(other.completedPassages, completedPassages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(completedPassages));

@override
String toString() {
  return 'BiblePlanDayProgress(completedPassages: $completedPassages)';
}


}

/// @nodoc
abstract mixin class $BiblePlanDayProgressCopyWith<$Res>  {
  factory $BiblePlanDayProgressCopyWith(BiblePlanDayProgress value, $Res Function(BiblePlanDayProgress) _then) = _$BiblePlanDayProgressCopyWithImpl;
@useResult
$Res call({
 Set<VerseSelection> completedPassages
});




}
/// @nodoc
class _$BiblePlanDayProgressCopyWithImpl<$Res>
    implements $BiblePlanDayProgressCopyWith<$Res> {
  _$BiblePlanDayProgressCopyWithImpl(this._self, this._then);

  final BiblePlanDayProgress _self;
  final $Res Function(BiblePlanDayProgress) _then;

/// Create a copy of BiblePlanDayProgress
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? completedPassages = null,}) {
  return _then(_self.copyWith(
completedPassages: null == completedPassages ? _self.completedPassages : completedPassages // ignore: cast_nullable_to_non_nullable
as Set<VerseSelection>,
  ));
}

}


/// Adds pattern-matching-related methods to [BiblePlanDayProgress].
extension BiblePlanDayProgressPatterns on BiblePlanDayProgress {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BiblePlanDayProgress value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BiblePlanDayProgress() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BiblePlanDayProgress value)  $default,){
final _that = this;
switch (_that) {
case _BiblePlanDayProgress():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BiblePlanDayProgress value)?  $default,){
final _that = this;
switch (_that) {
case _BiblePlanDayProgress() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Set<VerseSelection> completedPassages)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BiblePlanDayProgress() when $default != null:
return $default(_that.completedPassages);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Set<VerseSelection> completedPassages)  $default,) {final _that = this;
switch (_that) {
case _BiblePlanDayProgress():
return $default(_that.completedPassages);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Set<VerseSelection> completedPassages)?  $default,) {final _that = this;
switch (_that) {
case _BiblePlanDayProgress() when $default != null:
return $default(_that.completedPassages);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BiblePlanDayProgress extends BiblePlanDayProgress {
  const _BiblePlanDayProgress({final  Set<VerseSelection> completedPassages = const {}}): _completedPassages = completedPassages,super._();
  factory _BiblePlanDayProgress.fromJson(Map<String, dynamic> json) => _$BiblePlanDayProgressFromJson(json);

 final  Set<VerseSelection> _completedPassages;
@override@JsonKey() Set<VerseSelection> get completedPassages {
  if (_completedPassages is EqualUnmodifiableSetView) return _completedPassages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_completedPassages);
}


/// Create a copy of BiblePlanDayProgress
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BiblePlanDayProgressCopyWith<_BiblePlanDayProgress> get copyWith => __$BiblePlanDayProgressCopyWithImpl<_BiblePlanDayProgress>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BiblePlanDayProgressToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BiblePlanDayProgress&&const DeepCollectionEquality().equals(other._completedPassages, _completedPassages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_completedPassages));

@override
String toString() {
  return 'BiblePlanDayProgress(completedPassages: $completedPassages)';
}


}

/// @nodoc
abstract mixin class _$BiblePlanDayProgressCopyWith<$Res> implements $BiblePlanDayProgressCopyWith<$Res> {
  factory _$BiblePlanDayProgressCopyWith(_BiblePlanDayProgress value, $Res Function(_BiblePlanDayProgress) _then) = __$BiblePlanDayProgressCopyWithImpl;
@override @useResult
$Res call({
 Set<VerseSelection> completedPassages
});




}
/// @nodoc
class __$BiblePlanDayProgressCopyWithImpl<$Res>
    implements _$BiblePlanDayProgressCopyWith<$Res> {
  __$BiblePlanDayProgressCopyWithImpl(this._self, this._then);

  final _BiblePlanDayProgress _self;
  final $Res Function(_BiblePlanDayProgress) _then;

/// Create a copy of BiblePlanDayProgress
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? completedPassages = null,}) {
  return _then(_BiblePlanDayProgress(
completedPassages: null == completedPassages ? _self._completedPassages : completedPassages // ignore: cast_nullable_to_non_nullable
as Set<VerseSelection>,
  ));
}


}

// dart format on
