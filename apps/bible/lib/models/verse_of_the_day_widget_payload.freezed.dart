// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'verse_of_the_day_widget_payload.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VerseOfTheDayWidgetEntry {

@isoDate DateTime get date; String get reference; String get translation; String get text;
/// Create a copy of VerseOfTheDayWidgetEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VerseOfTheDayWidgetEntryCopyWith<VerseOfTheDayWidgetEntry> get copyWith => _$VerseOfTheDayWidgetEntryCopyWithImpl<VerseOfTheDayWidgetEntry>(this as VerseOfTheDayWidgetEntry, _$identity);

  /// Serializes this VerseOfTheDayWidgetEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerseOfTheDayWidgetEntry&&(identical(other.date, date) || other.date == date)&&(identical(other.reference, reference) || other.reference == reference)&&(identical(other.translation, translation) || other.translation == translation)&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,reference,translation,text);

@override
String toString() {
  return 'VerseOfTheDayWidgetEntry(date: $date, reference: $reference, translation: $translation, text: $text)';
}


}

/// @nodoc
abstract mixin class $VerseOfTheDayWidgetEntryCopyWith<$Res>  {
  factory $VerseOfTheDayWidgetEntryCopyWith(VerseOfTheDayWidgetEntry value, $Res Function(VerseOfTheDayWidgetEntry) _then) = _$VerseOfTheDayWidgetEntryCopyWithImpl;
@useResult
$Res call({
@isoDate DateTime date, String reference, String translation, String text
});




}
/// @nodoc
class _$VerseOfTheDayWidgetEntryCopyWithImpl<$Res>
    implements $VerseOfTheDayWidgetEntryCopyWith<$Res> {
  _$VerseOfTheDayWidgetEntryCopyWithImpl(this._self, this._then);

  final VerseOfTheDayWidgetEntry _self;
  final $Res Function(VerseOfTheDayWidgetEntry) _then;

/// Create a copy of VerseOfTheDayWidgetEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? reference = null,Object? translation = null,Object? text = null,}) {
  return _then(VerseOfTheDayWidgetEntry(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,reference: null == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String,translation: null == translation ? _self.translation : translation // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [VerseOfTheDayWidgetEntry].
extension VerseOfTheDayWidgetEntryPatterns on VerseOfTheDayWidgetEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VerseOfTheDayWidgetEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VerseOfTheDayWidgetEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VerseOfTheDayWidgetEntry value)  $default,){
final _that = this;
switch (_that) {
case _VerseOfTheDayWidgetEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VerseOfTheDayWidgetEntry value)?  $default,){
final _that = this;
switch (_that) {
case _VerseOfTheDayWidgetEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@isoDate  DateTime date,  String reference,  String translation,  String text)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VerseOfTheDayWidgetEntry() when $default != null:
return $default(_that.date,_that.reference,_that.translation,_that.text);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@isoDate  DateTime date,  String reference,  String translation,  String text)  $default,) {final _that = this;
switch (_that) {
case _VerseOfTheDayWidgetEntry():
return $default(_that.date,_that.reference,_that.translation,_that.text);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@isoDate  DateTime date,  String reference,  String translation,  String text)?  $default,) {final _that = this;
switch (_that) {
case _VerseOfTheDayWidgetEntry() when $default != null:
return $default(_that.date,_that.reference,_that.translation,_that.text);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VerseOfTheDayWidgetEntry implements VerseOfTheDayWidgetEntry {
  const _VerseOfTheDayWidgetEntry({@isoDate required this.date, required this.reference, required this.translation, required this.text});
  factory _VerseOfTheDayWidgetEntry.fromJson(Map<String, dynamic> json) => _$VerseOfTheDayWidgetEntryFromJson(json);

@override@isoDate final  DateTime date;
@override final  String reference;
@override final  String translation;
@override final  String text;

/// Create a copy of VerseOfTheDayWidgetEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VerseOfTheDayWidgetEntryCopyWith<_VerseOfTheDayWidgetEntry> get copyWith => __$VerseOfTheDayWidgetEntryCopyWithImpl<_VerseOfTheDayWidgetEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VerseOfTheDayWidgetEntryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VerseOfTheDayWidgetEntry&&(identical(other.date, date) || other.date == date)&&(identical(other.reference, reference) || other.reference == reference)&&(identical(other.translation, translation) || other.translation == translation)&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,reference,translation,text);

@override
String toString() {
  return 'VerseOfTheDayWidgetEntry(date: $date, reference: $reference, translation: $translation, text: $text)';
}


}

/// @nodoc
abstract mixin class _$VerseOfTheDayWidgetEntryCopyWith<$Res> implements $VerseOfTheDayWidgetEntryCopyWith<$Res> {
  factory _$VerseOfTheDayWidgetEntryCopyWith(_VerseOfTheDayWidgetEntry value, $Res Function(_VerseOfTheDayWidgetEntry) _then) = __$VerseOfTheDayWidgetEntryCopyWithImpl;
@override @useResult
$Res call({
@isoDate DateTime date, String reference, String translation, String text
});




}
/// @nodoc
class __$VerseOfTheDayWidgetEntryCopyWithImpl<$Res>
    implements _$VerseOfTheDayWidgetEntryCopyWith<$Res> {
  __$VerseOfTheDayWidgetEntryCopyWithImpl(this._self, this._then);

  final _VerseOfTheDayWidgetEntry _self;
  final $Res Function(_VerseOfTheDayWidgetEntry) _then;

/// Create a copy of VerseOfTheDayWidgetEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? reference = null,Object? translation = null,Object? text = null,}) {
  return _then(_VerseOfTheDayWidgetEntry(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,reference: null == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String,translation: null == translation ? _self.translation : translation // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$VerseOfTheDayWidgetPayload {

 List<VerseOfTheDayWidgetEntry> get entries;
/// Create a copy of VerseOfTheDayWidgetPayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VerseOfTheDayWidgetPayloadCopyWith<VerseOfTheDayWidgetPayload> get copyWith => _$VerseOfTheDayWidgetPayloadCopyWithImpl<VerseOfTheDayWidgetPayload>(this as VerseOfTheDayWidgetPayload, _$identity);

  /// Serializes this VerseOfTheDayWidgetPayload to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerseOfTheDayWidgetPayload&&const DeepCollectionEquality().equals(other.entries, entries));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(entries));

@override
String toString() {
  return 'VerseOfTheDayWidgetPayload(entries: $entries)';
}


}

/// @nodoc
abstract mixin class $VerseOfTheDayWidgetPayloadCopyWith<$Res>  {
  factory $VerseOfTheDayWidgetPayloadCopyWith(VerseOfTheDayWidgetPayload value, $Res Function(VerseOfTheDayWidgetPayload) _then) = _$VerseOfTheDayWidgetPayloadCopyWithImpl;
@useResult
$Res call({
 List<VerseOfTheDayWidgetEntry> entries
});




}
/// @nodoc
class _$VerseOfTheDayWidgetPayloadCopyWithImpl<$Res>
    implements $VerseOfTheDayWidgetPayloadCopyWith<$Res> {
  _$VerseOfTheDayWidgetPayloadCopyWithImpl(this._self, this._then);

  final VerseOfTheDayWidgetPayload _self;
  final $Res Function(VerseOfTheDayWidgetPayload) _then;

/// Create a copy of VerseOfTheDayWidgetPayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? entries = null,}) {
  return _then(VerseOfTheDayWidgetPayload(
entries: null == entries ? _self.entries : entries // ignore: cast_nullable_to_non_nullable
as List<VerseOfTheDayWidgetEntry>,
  ));
}

}


/// Adds pattern-matching-related methods to [VerseOfTheDayWidgetPayload].
extension VerseOfTheDayWidgetPayloadPatterns on VerseOfTheDayWidgetPayload {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VerseOfTheDayWidgetPayload value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VerseOfTheDayWidgetPayload() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VerseOfTheDayWidgetPayload value)  $default,){
final _that = this;
switch (_that) {
case _VerseOfTheDayWidgetPayload():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VerseOfTheDayWidgetPayload value)?  $default,){
final _that = this;
switch (_that) {
case _VerseOfTheDayWidgetPayload() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<VerseOfTheDayWidgetEntry> entries)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VerseOfTheDayWidgetPayload() when $default != null:
return $default(_that.entries);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<VerseOfTheDayWidgetEntry> entries)  $default,) {final _that = this;
switch (_that) {
case _VerseOfTheDayWidgetPayload():
return $default(_that.entries);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<VerseOfTheDayWidgetEntry> entries)?  $default,) {final _that = this;
switch (_that) {
case _VerseOfTheDayWidgetPayload() when $default != null:
return $default(_that.entries);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VerseOfTheDayWidgetPayload extends VerseOfTheDayWidgetPayload {
  const _VerseOfTheDayWidgetPayload({required  List<VerseOfTheDayWidgetEntry> entries}): _entries = entries,super._();
  factory _VerseOfTheDayWidgetPayload.fromJson(Map<String, dynamic> json) => _$VerseOfTheDayWidgetPayloadFromJson(json);

 final  List<VerseOfTheDayWidgetEntry> _entries;
@override List<VerseOfTheDayWidgetEntry> get entries {
  if (_entries is EqualUnmodifiableListView) return _entries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_entries);
}


/// Create a copy of VerseOfTheDayWidgetPayload
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VerseOfTheDayWidgetPayloadCopyWith<_VerseOfTheDayWidgetPayload> get copyWith => __$VerseOfTheDayWidgetPayloadCopyWithImpl<_VerseOfTheDayWidgetPayload>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VerseOfTheDayWidgetPayloadToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VerseOfTheDayWidgetPayload&&const DeepCollectionEquality().equals(other._entries, _entries));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_entries));

@override
String toString() {
  return 'VerseOfTheDayWidgetPayload(entries: $entries)';
}


}

/// @nodoc
abstract mixin class _$VerseOfTheDayWidgetPayloadCopyWith<$Res> implements $VerseOfTheDayWidgetPayloadCopyWith<$Res> {
  factory _$VerseOfTheDayWidgetPayloadCopyWith(_VerseOfTheDayWidgetPayload value, $Res Function(_VerseOfTheDayWidgetPayload) _then) = __$VerseOfTheDayWidgetPayloadCopyWithImpl;
@override @useResult
$Res call({
 List<VerseOfTheDayWidgetEntry> entries
});




}
/// @nodoc
class __$VerseOfTheDayWidgetPayloadCopyWithImpl<$Res>
    implements _$VerseOfTheDayWidgetPayloadCopyWith<$Res> {
  __$VerseOfTheDayWidgetPayloadCopyWithImpl(this._self, this._then);

  final _VerseOfTheDayWidgetPayload _self;
  final $Res Function(_VerseOfTheDayWidgetPayload) _then;

/// Create a copy of VerseOfTheDayWidgetPayload
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? entries = null,}) {
  return _then(_VerseOfTheDayWidgetPayload(
entries: null == entries ? _self._entries : entries // ignore: cast_nullable_to_non_nullable
as List<VerseOfTheDayWidgetEntry>,
  ));
}


}

// dart format on
