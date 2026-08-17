// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bible_plan.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BiblePlan {

 String get name; List<BiblePlanDay> get days;
/// Create a copy of BiblePlan
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BiblePlanCopyWith<BiblePlan> get copyWith => _$BiblePlanCopyWithImpl<BiblePlan>(this as BiblePlan, _$identity);

  /// Serializes this BiblePlan to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BiblePlan&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.days, days));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,const DeepCollectionEquality().hash(days));

@override
String toString() {
  return 'BiblePlan(name: $name, days: $days)';
}


}

/// @nodoc
abstract mixin class $BiblePlanCopyWith<$Res>  {
  factory $BiblePlanCopyWith(BiblePlan value, $Res Function(BiblePlan) _then) = _$BiblePlanCopyWithImpl;
@useResult
$Res call({
 String name, List<BiblePlanDay> days
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
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? days = null,}) {
  return _then(BiblePlan(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  List<BiblePlanDay> days)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BiblePlan() when $default != null:
return $default(_that.name,_that.days);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  List<BiblePlanDay> days)  $default,) {final _that = this;
switch (_that) {
case _BiblePlan():
return $default(_that.name,_that.days);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  List<BiblePlanDay> days)?  $default,) {final _that = this;
switch (_that) {
case _BiblePlan() when $default != null:
return $default(_that.name,_that.days);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BiblePlan extends BiblePlan {
  const _BiblePlan({required this.name, required  List<BiblePlanDay> days}): _days = days,super._();
  factory _BiblePlan.fromJson(Map<String, dynamic> json) => _$BiblePlanFromJson(json);

@override final  String name;
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BiblePlan&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._days, _days));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,const DeepCollectionEquality().hash(_days));

@override
String toString() {
  return 'BiblePlan(name: $name, days: $days)';
}


}

/// @nodoc
abstract mixin class _$BiblePlanCopyWith<$Res> implements $BiblePlanCopyWith<$Res> {
  factory _$BiblePlanCopyWith(_BiblePlan value, $Res Function(_BiblePlan) _then) = __$BiblePlanCopyWithImpl;
@override @useResult
$Res call({
 String name, List<BiblePlanDay> days
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
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? days = null,}) {
  return _then(_BiblePlan(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
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
  return _then(BiblePlanDay(
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
  const _BiblePlanDay({ List<VerseSelection> passages = const []}): _passages = passages,super._();
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

 List<BiblePlanDayProgress> get days; BiblePlanReminder? get reminder; CalendarDateTime? get lastCompletedAt;
/// Create a copy of BiblePlanProgress
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BiblePlanProgressCopyWith<BiblePlanProgress> get copyWith => _$BiblePlanProgressCopyWithImpl<BiblePlanProgress>(this as BiblePlanProgress, _$identity);

  /// Serializes this BiblePlanProgress to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BiblePlanProgress&&const DeepCollectionEquality().equals(other.days, days)&&(identical(other.reminder, reminder) || other.reminder == reminder)&&(identical(other.lastCompletedAt, lastCompletedAt) || other.lastCompletedAt == lastCompletedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(days),reminder,lastCompletedAt);

@override
String toString() {
  return 'BiblePlanProgress(days: $days, reminder: $reminder, lastCompletedAt: $lastCompletedAt)';
}


}

/// @nodoc
abstract mixin class $BiblePlanProgressCopyWith<$Res>  {
  factory $BiblePlanProgressCopyWith(BiblePlanProgress value, $Res Function(BiblePlanProgress) _then) = _$BiblePlanProgressCopyWithImpl;
@useResult
$Res call({
 List<BiblePlanDayProgress> days, BiblePlanReminder? reminder, CalendarDateTime? lastCompletedAt
});


$BiblePlanReminderCopyWith<$Res>? get reminder;

}
/// @nodoc
class _$BiblePlanProgressCopyWithImpl<$Res>
    implements $BiblePlanProgressCopyWith<$Res> {
  _$BiblePlanProgressCopyWithImpl(this._self, this._then);

  final BiblePlanProgress _self;
  final $Res Function(BiblePlanProgress) _then;

/// Create a copy of BiblePlanProgress
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? days = null,Object? reminder = freezed,Object? lastCompletedAt = freezed,}) {
  return _then(BiblePlanProgress(
days: null == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as List<BiblePlanDayProgress>,reminder: freezed == reminder ? _self.reminder : reminder // ignore: cast_nullable_to_non_nullable
as BiblePlanReminder?,lastCompletedAt: freezed == lastCompletedAt ? _self.lastCompletedAt : lastCompletedAt // ignore: cast_nullable_to_non_nullable
as CalendarDateTime?,
  ));
}
/// Create a copy of BiblePlanProgress
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BiblePlanReminderCopyWith<$Res>? get reminder {
    if (_self.reminder == null) {
    return null;
  }

  return $BiblePlanReminderCopyWith<$Res>(_self.reminder!, (value) {
    return _then(_self.copyWith(reminder: value));
  });
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<BiblePlanDayProgress> days,  BiblePlanReminder? reminder,  CalendarDateTime? lastCompletedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BiblePlanProgress() when $default != null:
return $default(_that.days,_that.reminder,_that.lastCompletedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<BiblePlanDayProgress> days,  BiblePlanReminder? reminder,  CalendarDateTime? lastCompletedAt)  $default,) {final _that = this;
switch (_that) {
case _BiblePlanProgress():
return $default(_that.days,_that.reminder,_that.lastCompletedAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<BiblePlanDayProgress> days,  BiblePlanReminder? reminder,  CalendarDateTime? lastCompletedAt)?  $default,) {final _that = this;
switch (_that) {
case _BiblePlanProgress() when $default != null:
return $default(_that.days,_that.reminder,_that.lastCompletedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BiblePlanProgress extends BiblePlanProgress {
  const _BiblePlanProgress({required  List<BiblePlanDayProgress> days, this.reminder, this.lastCompletedAt}): _days = days,super._();
  factory _BiblePlanProgress.fromJson(Map<String, dynamic> json) => _$BiblePlanProgressFromJson(json);

 final  List<BiblePlanDayProgress> _days;
@override List<BiblePlanDayProgress> get days {
  if (_days is EqualUnmodifiableListView) return _days;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_days);
}

@override final  BiblePlanReminder? reminder;
@override final  CalendarDateTime? lastCompletedAt;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BiblePlanProgress&&const DeepCollectionEquality().equals(other._days, _days)&&(identical(other.reminder, reminder) || other.reminder == reminder)&&(identical(other.lastCompletedAt, lastCompletedAt) || other.lastCompletedAt == lastCompletedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_days),reminder,lastCompletedAt);

@override
String toString() {
  return 'BiblePlanProgress(days: $days, reminder: $reminder, lastCompletedAt: $lastCompletedAt)';
}


}

/// @nodoc
abstract mixin class _$BiblePlanProgressCopyWith<$Res> implements $BiblePlanProgressCopyWith<$Res> {
  factory _$BiblePlanProgressCopyWith(_BiblePlanProgress value, $Res Function(_BiblePlanProgress) _then) = __$BiblePlanProgressCopyWithImpl;
@override @useResult
$Res call({
 List<BiblePlanDayProgress> days, BiblePlanReminder? reminder, CalendarDateTime? lastCompletedAt
});


@override $BiblePlanReminderCopyWith<$Res>? get reminder;

}
/// @nodoc
class __$BiblePlanProgressCopyWithImpl<$Res>
    implements _$BiblePlanProgressCopyWith<$Res> {
  __$BiblePlanProgressCopyWithImpl(this._self, this._then);

  final _BiblePlanProgress _self;
  final $Res Function(_BiblePlanProgress) _then;

/// Create a copy of BiblePlanProgress
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? days = null,Object? reminder = freezed,Object? lastCompletedAt = freezed,}) {
  return _then(_BiblePlanProgress(
days: null == days ? _self._days : days // ignore: cast_nullable_to_non_nullable
as List<BiblePlanDayProgress>,reminder: freezed == reminder ? _self.reminder : reminder // ignore: cast_nullable_to_non_nullable
as BiblePlanReminder?,lastCompletedAt: freezed == lastCompletedAt ? _self.lastCompletedAt : lastCompletedAt // ignore: cast_nullable_to_non_nullable
as CalendarDateTime?,
  ));
}

/// Create a copy of BiblePlanProgress
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BiblePlanReminderCopyWith<$Res>? get reminder {
    if (_self.reminder == null) {
    return null;
  }

  return $BiblePlanReminderCopyWith<$Res>(_self.reminder!, (value) {
    return _then(_self.copyWith(reminder: value));
  });
}
}

BiblePlanDayProgress _$BiblePlanDayProgressFromJson(
  Map<String, dynamic> json
) {
        switch (json['runtimeType']) {
                  case 'incomplete':
          return IncompleteBiblePlanDayProgress.fromJson(
            json
          );
                case 'complete':
          return CompleteBiblePlanDayProgress.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'runtimeType',
  'BiblePlanDayProgress',
  'Invalid union type "${json['runtimeType']}"!'
);
        }
      
}

/// @nodoc
mixin _$BiblePlanDayProgress {



  /// Serializes this BiblePlanDayProgress to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BiblePlanDayProgress);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BiblePlanDayProgress()';
}


}

/// @nodoc
class $BiblePlanDayProgressCopyWith<$Res>  {
$BiblePlanDayProgressCopyWith(BiblePlanDayProgress _, $Res Function(BiblePlanDayProgress) __);
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( IncompleteBiblePlanDayProgress value)?  incomplete,TResult Function( CompleteBiblePlanDayProgress value)?  complete,required TResult orElse(),}){
final _that = this;
switch (_that) {
case IncompleteBiblePlanDayProgress() when incomplete != null:
return incomplete(_that);case CompleteBiblePlanDayProgress() when complete != null:
return complete(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( IncompleteBiblePlanDayProgress value)  incomplete,required TResult Function( CompleteBiblePlanDayProgress value)  complete,}){
final _that = this;
switch (_that) {
case IncompleteBiblePlanDayProgress():
return incomplete(_that);case CompleteBiblePlanDayProgress():
return complete(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( IncompleteBiblePlanDayProgress value)?  incomplete,TResult? Function( CompleteBiblePlanDayProgress value)?  complete,}){
final _that = this;
switch (_that) {
case IncompleteBiblePlanDayProgress() when incomplete != null:
return incomplete(_that);case CompleteBiblePlanDayProgress() when complete != null:
return complete(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( Set<VerseSelection> completedPassages)?  incomplete,TResult Function()?  complete,required TResult orElse(),}) {final _that = this;
switch (_that) {
case IncompleteBiblePlanDayProgress() when incomplete != null:
return incomplete(_that.completedPassages);case CompleteBiblePlanDayProgress() when complete != null:
return complete();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( Set<VerseSelection> completedPassages)  incomplete,required TResult Function()  complete,}) {final _that = this;
switch (_that) {
case IncompleteBiblePlanDayProgress():
return incomplete(_that.completedPassages);case CompleteBiblePlanDayProgress():
return complete();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( Set<VerseSelection> completedPassages)?  incomplete,TResult? Function()?  complete,}) {final _that = this;
switch (_that) {
case IncompleteBiblePlanDayProgress() when incomplete != null:
return incomplete(_that.completedPassages);case CompleteBiblePlanDayProgress() when complete != null:
return complete();case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class IncompleteBiblePlanDayProgress extends BiblePlanDayProgress {
  const IncompleteBiblePlanDayProgress({ Set<VerseSelection> completedPassages = const {},  String? $type}): _completedPassages = completedPassages,$type = $type ?? 'incomplete',super._();
  factory IncompleteBiblePlanDayProgress.fromJson(Map<String, dynamic> json) => _$IncompleteBiblePlanDayProgressFromJson(json);

 final  Set<VerseSelection> _completedPassages;
@JsonKey() Set<VerseSelection> get completedPassages {
  if (_completedPassages is EqualUnmodifiableSetView) return _completedPassages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_completedPassages);
}


@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of BiblePlanDayProgress
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IncompleteBiblePlanDayProgressCopyWith<IncompleteBiblePlanDayProgress> get copyWith => _$IncompleteBiblePlanDayProgressCopyWithImpl<IncompleteBiblePlanDayProgress>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IncompleteBiblePlanDayProgressToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IncompleteBiblePlanDayProgress&&const DeepCollectionEquality().equals(other._completedPassages, _completedPassages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_completedPassages));

@override
String toString() {
  return 'BiblePlanDayProgress.incomplete(completedPassages: $completedPassages)';
}


}

/// @nodoc
abstract mixin class $IncompleteBiblePlanDayProgressCopyWith<$Res> implements $BiblePlanDayProgressCopyWith<$Res> {
  factory $IncompleteBiblePlanDayProgressCopyWith(IncompleteBiblePlanDayProgress value, $Res Function(IncompleteBiblePlanDayProgress) _then) = _$IncompleteBiblePlanDayProgressCopyWithImpl;
@useResult
$Res call({
 Set<VerseSelection> completedPassages
});




}
/// @nodoc
class _$IncompleteBiblePlanDayProgressCopyWithImpl<$Res>
    implements $IncompleteBiblePlanDayProgressCopyWith<$Res> {
  _$IncompleteBiblePlanDayProgressCopyWithImpl(this._self, this._then);

  final IncompleteBiblePlanDayProgress _self;
  final $Res Function(IncompleteBiblePlanDayProgress) _then;

/// Create a copy of BiblePlanDayProgress
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? completedPassages = null,}) {
  return _then(IncompleteBiblePlanDayProgress(
completedPassages: null == completedPassages ? _self._completedPassages : completedPassages // ignore: cast_nullable_to_non_nullable
as Set<VerseSelection>,
  ));
}


}

/// @nodoc
@JsonSerializable()

class CompleteBiblePlanDayProgress extends BiblePlanDayProgress {
  const CompleteBiblePlanDayProgress({ String? $type}): $type = $type ?? 'complete',super._();
  factory CompleteBiblePlanDayProgress.fromJson(Map<String, dynamic> json) => _$CompleteBiblePlanDayProgressFromJson(json);



@JsonKey(name: 'runtimeType')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$CompleteBiblePlanDayProgressToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompleteBiblePlanDayProgress);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BiblePlanDayProgress.complete()';
}


}




BiblePlanReminder _$BiblePlanReminderFromJson(
  Map<String, dynamic> json
) {
        switch (json['runtimeType']) {
                  case 'none':
          return NoneBiblePlanReminder.fromJson(
            json
          );
                case 'daily':
          return DailyBiblePlanReminder.fromJson(
            json
          );

          default:
            throw CheckedFromJsonException(
  json,
  'runtimeType',
  'BiblePlanReminder',
  'Invalid union type "${json['runtimeType']}"!'
);
        }

}

/// @nodoc
mixin _$BiblePlanReminder {



  /// Serializes this BiblePlanReminder to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BiblePlanReminder);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BiblePlanReminder()';
}


}

/// @nodoc
class $BiblePlanReminderCopyWith<$Res>  {
$BiblePlanReminderCopyWith(BiblePlanReminder _, $Res Function(BiblePlanReminder) __);
}


/// Adds pattern-matching-related methods to [BiblePlanReminder].
extension BiblePlanReminderPatterns on BiblePlanReminder {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( NoneBiblePlanReminder value)?  none,TResult Function( DailyBiblePlanReminder value)?  daily,required TResult orElse(),}){
final _that = this;
switch (_that) {
case NoneBiblePlanReminder() when none != null:
return none(_that);case DailyBiblePlanReminder() when daily != null:
return daily(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( NoneBiblePlanReminder value)  none,required TResult Function( DailyBiblePlanReminder value)  daily,}){
final _that = this;
switch (_that) {
case NoneBiblePlanReminder():
return none(_that);case DailyBiblePlanReminder():
return daily(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( NoneBiblePlanReminder value)?  none,TResult? Function( DailyBiblePlanReminder value)?  daily,}){
final _that = this;
switch (_that) {
case NoneBiblePlanReminder() when none != null:
return none(_that);case DailyBiblePlanReminder() when daily != null:
return daily(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  none,TResult Function( Time time)?  daily,required TResult orElse(),}) {final _that = this;
switch (_that) {
case NoneBiblePlanReminder() when none != null:
return none();case DailyBiblePlanReminder() when daily != null:
return daily(_that.time);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  none,required TResult Function( Time time)  daily,}) {final _that = this;
switch (_that) {
case NoneBiblePlanReminder():
return none();case DailyBiblePlanReminder():
return daily(_that.time);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  none,TResult? Function( Time time)?  daily,}) {final _that = this;
switch (_that) {
case NoneBiblePlanReminder() when none != null:
return none();case DailyBiblePlanReminder() when daily != null:
return daily(_that.time);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class NoneBiblePlanReminder extends BiblePlanReminder {
  const NoneBiblePlanReminder({ String? $type}): $type = $type ?? 'none',super._();
  factory NoneBiblePlanReminder.fromJson(Map<String, dynamic> json) => _$NoneBiblePlanReminderFromJson(json);



@JsonKey(name: 'runtimeType')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$NoneBiblePlanReminderToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NoneBiblePlanReminder);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BiblePlanReminder.none()';
}


}




/// @nodoc
@JsonSerializable()

class DailyBiblePlanReminder extends BiblePlanReminder {
  const DailyBiblePlanReminder({required this.time,  String? $type}): $type = $type ?? 'daily',super._();
  factory DailyBiblePlanReminder.fromJson(Map<String, dynamic> json) => _$DailyBiblePlanReminderFromJson(json);

 final  Time time;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of BiblePlanReminder
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DailyBiblePlanReminderCopyWith<DailyBiblePlanReminder> get copyWith => _$DailyBiblePlanReminderCopyWithImpl<DailyBiblePlanReminder>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DailyBiblePlanReminderToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DailyBiblePlanReminder&&(identical(other.time, time) || other.time == time));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,time);

@override
String toString() {
  return 'BiblePlanReminder.daily(time: $time)';
}


}

/// @nodoc
abstract mixin class $DailyBiblePlanReminderCopyWith<$Res> implements $BiblePlanReminderCopyWith<$Res> {
  factory $DailyBiblePlanReminderCopyWith(DailyBiblePlanReminder value, $Res Function(DailyBiblePlanReminder) _then) = _$DailyBiblePlanReminderCopyWithImpl;
@useResult
$Res call({
 Time time
});




}
/// @nodoc
class _$DailyBiblePlanReminderCopyWithImpl<$Res>
    implements $DailyBiblePlanReminderCopyWith<$Res> {
  _$DailyBiblePlanReminderCopyWithImpl(this._self, this._then);

  final DailyBiblePlanReminder _self;
  final $Res Function(DailyBiblePlanReminder) _then;

/// Create a copy of BiblePlanReminder
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? time = null,}) {
  return _then(DailyBiblePlanReminder(
time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as Time,
  ));
}


}

// dart format on
