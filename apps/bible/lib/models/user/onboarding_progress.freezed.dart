// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onboarding_progress.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OnboardingProgress {

 OnboardingTour get tour;@KnownOnboardingSteps() List<OnboardingStep> get completedSteps;
/// Create a copy of OnboardingProgress
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnboardingProgressCopyWith<OnboardingProgress> get copyWith => _$OnboardingProgressCopyWithImpl<OnboardingProgress>(this as OnboardingProgress, _$identity);

  /// Serializes this OnboardingProgress to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingProgress&&(identical(other.tour, tour) || other.tour == tour)&&const DeepCollectionEquality().equals(other.completedSteps, completedSteps));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tour,const DeepCollectionEquality().hash(completedSteps));

@override
String toString() {
  return 'OnboardingProgress(tour: $tour, completedSteps: $completedSteps)';
}


}

/// @nodoc
abstract mixin class $OnboardingProgressCopyWith<$Res>  {
  factory $OnboardingProgressCopyWith(OnboardingProgress value, $Res Function(OnboardingProgress) _then) = _$OnboardingProgressCopyWithImpl;
@useResult
$Res call({
 OnboardingTour tour,@KnownOnboardingSteps() List<OnboardingStep> completedSteps
});




}
/// @nodoc
class _$OnboardingProgressCopyWithImpl<$Res>
    implements $OnboardingProgressCopyWith<$Res> {
  _$OnboardingProgressCopyWithImpl(this._self, this._then);

  final OnboardingProgress _self;
  final $Res Function(OnboardingProgress) _then;

/// Create a copy of OnboardingProgress
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tour = null,Object? completedSteps = null,}) {
  return _then(OnboardingProgress(
tour: null == tour ? _self.tour : tour // ignore: cast_nullable_to_non_nullable
as OnboardingTour,completedSteps: null == completedSteps ? _self.completedSteps : completedSteps // ignore: cast_nullable_to_non_nullable
as List<OnboardingStep>,
  ));
}

}


/// Adds pattern-matching-related methods to [OnboardingProgress].
extension OnboardingProgressPatterns on OnboardingProgress {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OnboardingProgress value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OnboardingProgress() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OnboardingProgress value)  $default,){
final _that = this;
switch (_that) {
case _OnboardingProgress():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OnboardingProgress value)?  $default,){
final _that = this;
switch (_that) {
case _OnboardingProgress() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( OnboardingTour tour, @KnownOnboardingSteps()  List<OnboardingStep> completedSteps)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OnboardingProgress() when $default != null:
return $default(_that.tour,_that.completedSteps);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( OnboardingTour tour, @KnownOnboardingSteps()  List<OnboardingStep> completedSteps)  $default,) {final _that = this;
switch (_that) {
case _OnboardingProgress():
return $default(_that.tour,_that.completedSteps);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( OnboardingTour tour, @KnownOnboardingSteps()  List<OnboardingStep> completedSteps)?  $default,) {final _that = this;
switch (_that) {
case _OnboardingProgress() when $default != null:
return $default(_that.tour,_that.completedSteps);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OnboardingProgress extends OnboardingProgress {
  const _OnboardingProgress({required this.tour, @KnownOnboardingSteps()  List<OnboardingStep> completedSteps = const []}): _completedSteps = completedSteps,super._();
  factory _OnboardingProgress.fromJson(Map<String, dynamic> json) => _$OnboardingProgressFromJson(json);

@override final  OnboardingTour tour;
 final  List<OnboardingStep> _completedSteps;
@override@JsonKey()@KnownOnboardingSteps() List<OnboardingStep> get completedSteps {
  if (_completedSteps is EqualUnmodifiableListView) return _completedSteps;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_completedSteps);
}


/// Create a copy of OnboardingProgress
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OnboardingProgressCopyWith<_OnboardingProgress> get copyWith => __$OnboardingProgressCopyWithImpl<_OnboardingProgress>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OnboardingProgressToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OnboardingProgress&&(identical(other.tour, tour) || other.tour == tour)&&const DeepCollectionEquality().equals(other._completedSteps, _completedSteps));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tour,const DeepCollectionEquality().hash(_completedSteps));

@override
String toString() {
  return 'OnboardingProgress(tour: $tour, completedSteps: $completedSteps)';
}


}

/// @nodoc
abstract mixin class _$OnboardingProgressCopyWith<$Res> implements $OnboardingProgressCopyWith<$Res> {
  factory _$OnboardingProgressCopyWith(_OnboardingProgress value, $Res Function(_OnboardingProgress) _then) = __$OnboardingProgressCopyWithImpl;
@override @useResult
$Res call({
 OnboardingTour tour,@KnownOnboardingSteps() List<OnboardingStep> completedSteps
});




}
/// @nodoc
class __$OnboardingProgressCopyWithImpl<$Res>
    implements _$OnboardingProgressCopyWith<$Res> {
  __$OnboardingProgressCopyWithImpl(this._self, this._then);

  final _OnboardingProgress _self;
  final $Res Function(_OnboardingProgress) _then;

/// Create a copy of OnboardingProgress
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tour = null,Object? completedSteps = null,}) {
  return _then(_OnboardingProgress(
tour: null == tour ? _self.tour : tour // ignore: cast_nullable_to_non_nullable
as OnboardingTour,completedSteps: null == completedSteps ? _self._completedSteps : completedSteps // ignore: cast_nullable_to_non_nullable
as List<OnboardingStep>,
  ));
}


}

// dart format on
