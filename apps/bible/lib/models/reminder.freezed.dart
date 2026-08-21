// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reminder.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
Reminder _$ReminderFromJson(
  Map<String, dynamic> json
) {
        switch (json['runtimeType']) {
                  case 'none':
          return NoneReminder.fromJson(
            json
          );
                case 'daily':
          return DailyReminder.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'runtimeType',
  'Reminder',
  'Invalid union type "${json['runtimeType']}"!'
);
        }
      
}

/// @nodoc
mixin _$Reminder {



  /// Serializes this Reminder to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Reminder);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Reminder()';
}


}

/// @nodoc
class $ReminderCopyWith<$Res>  {
$ReminderCopyWith(Reminder _, $Res Function(Reminder) __);
}


/// Adds pattern-matching-related methods to [Reminder].
extension ReminderPatterns on Reminder {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( NoneReminder value)?  none,TResult Function( DailyReminder value)?  daily,required TResult orElse(),}){
final _that = this;
switch (_that) {
case NoneReminder() when none != null:
return none(_that);case DailyReminder() when daily != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( NoneReminder value)  none,required TResult Function( DailyReminder value)  daily,}){
final _that = this;
switch (_that) {
case NoneReminder():
return none(_that);case DailyReminder():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( NoneReminder value)?  none,TResult? Function( DailyReminder value)?  daily,}){
final _that = this;
switch (_that) {
case NoneReminder() when none != null:
return none(_that);case DailyReminder() when daily != null:
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
case NoneReminder() when none != null:
return none();case DailyReminder() when daily != null:
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
case NoneReminder():
return none();case DailyReminder():
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
case NoneReminder() when none != null:
return none();case DailyReminder() when daily != null:
return daily(_that.time);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class NoneReminder extends Reminder {
  const NoneReminder({ String? $type}): $type = $type ?? 'none',super._();
  factory NoneReminder.fromJson(Map<String, dynamic> json) => _$NoneReminderFromJson(json);



@JsonKey(name: 'runtimeType')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$NoneReminderToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NoneReminder);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Reminder.none()';
}


}




/// @nodoc
@JsonSerializable()

class DailyReminder extends Reminder {
  const DailyReminder({required this.time,  String? $type}): $type = $type ?? 'daily',super._();
  factory DailyReminder.fromJson(Map<String, dynamic> json) => _$DailyReminderFromJson(json);

 final  Time time;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of Reminder
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DailyReminderCopyWith<DailyReminder> get copyWith => _$DailyReminderCopyWithImpl<DailyReminder>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DailyReminderToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DailyReminder&&(identical(other.time, time) || other.time == time));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,time);

@override
String toString() {
  return 'Reminder.daily(time: $time)';
}


}

/// @nodoc
abstract mixin class $DailyReminderCopyWith<$Res> implements $ReminderCopyWith<$Res> {
  factory $DailyReminderCopyWith(DailyReminder value, $Res Function(DailyReminder) _then) = _$DailyReminderCopyWithImpl;
@useResult
$Res call({
 Time time
});




}
/// @nodoc
class _$DailyReminderCopyWithImpl<$Res>
    implements $DailyReminderCopyWith<$Res> {
  _$DailyReminderCopyWithImpl(this._self, this._then);

  final DailyReminder _self;
  final $Res Function(DailyReminder) _then;

/// Create a copy of Reminder
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? time = null,}) {
  return _then(DailyReminder(
time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as Time,
  ));
}


}

// dart format on
