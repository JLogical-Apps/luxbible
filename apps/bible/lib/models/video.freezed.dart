// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'video.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Video {

@JsonKey(name: 'i') String get id;@JsonKey(name: 't') String get title;@JsonKey(name: 'd') int get durationSeconds;@JsonKey(name: 'm') String get muxPlaybackId;@JsonKey(name: 'u') String get thumbnailUrl;@IgnoreIfEmpty(name: 'p') List<VerseSelection> get passages;
/// Create a copy of Video
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VideoCopyWith<Video> get copyWith => _$VideoCopyWithImpl<Video>(this as Video, _$identity);

  /// Serializes this Video to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Video&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.muxPlaybackId, muxPlaybackId) || other.muxPlaybackId == muxPlaybackId)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&const DeepCollectionEquality().equals(other.passages, passages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,durationSeconds,muxPlaybackId,thumbnailUrl,const DeepCollectionEquality().hash(passages));

@override
String toString() {
  return 'Video(id: $id, title: $title, durationSeconds: $durationSeconds, muxPlaybackId: $muxPlaybackId, thumbnailUrl: $thumbnailUrl, passages: $passages)';
}


}

/// @nodoc
abstract mixin class $VideoCopyWith<$Res>  {
  factory $VideoCopyWith(Video value, $Res Function(Video) _then) = _$VideoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'i') String id,@JsonKey(name: 't') String title,@JsonKey(name: 'd') int durationSeconds,@JsonKey(name: 'm') String muxPlaybackId,@JsonKey(name: 'u') String thumbnailUrl,@IgnoreIfEmpty(name: 'p') List<VerseSelection> passages
});




}
/// @nodoc
class _$VideoCopyWithImpl<$Res>
    implements $VideoCopyWith<$Res> {
  _$VideoCopyWithImpl(this._self, this._then);

  final Video _self;
  final $Res Function(Video) _then;

/// Create a copy of Video
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? durationSeconds = null,Object? muxPlaybackId = null,Object? thumbnailUrl = null,Object? passages = null,}) {
  return _then(Video(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,durationSeconds: null == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int,muxPlaybackId: null == muxPlaybackId ? _self.muxPlaybackId : muxPlaybackId // ignore: cast_nullable_to_non_nullable
as String,thumbnailUrl: null == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String,passages: null == passages ? _self.passages : passages // ignore: cast_nullable_to_non_nullable
as List<VerseSelection>,
  ));
}

}


/// Adds pattern-matching-related methods to [Video].
extension VideoPatterns on Video {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Video value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Video() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Video value)  $default,){
final _that = this;
switch (_that) {
case _Video():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Video value)?  $default,){
final _that = this;
switch (_that) {
case _Video() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'i')  String id, @JsonKey(name: 't')  String title, @JsonKey(name: 'd')  int durationSeconds, @JsonKey(name: 'm')  String muxPlaybackId, @JsonKey(name: 'u')  String thumbnailUrl, @IgnoreIfEmpty(name: 'p')  List<VerseSelection> passages)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Video() when $default != null:
return $default(_that.id,_that.title,_that.durationSeconds,_that.muxPlaybackId,_that.thumbnailUrl,_that.passages);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'i')  String id, @JsonKey(name: 't')  String title, @JsonKey(name: 'd')  int durationSeconds, @JsonKey(name: 'm')  String muxPlaybackId, @JsonKey(name: 'u')  String thumbnailUrl, @IgnoreIfEmpty(name: 'p')  List<VerseSelection> passages)  $default,) {final _that = this;
switch (_that) {
case _Video():
return $default(_that.id,_that.title,_that.durationSeconds,_that.muxPlaybackId,_that.thumbnailUrl,_that.passages);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'i')  String id, @JsonKey(name: 't')  String title, @JsonKey(name: 'd')  int durationSeconds, @JsonKey(name: 'm')  String muxPlaybackId, @JsonKey(name: 'u')  String thumbnailUrl, @IgnoreIfEmpty(name: 'p')  List<VerseSelection> passages)?  $default,) {final _that = this;
switch (_that) {
case _Video() when $default != null:
return $default(_that.id,_that.title,_that.durationSeconds,_that.muxPlaybackId,_that.thumbnailUrl,_that.passages);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Video extends Video {
  const _Video({@JsonKey(name: 'i') required this.id, @JsonKey(name: 't') required this.title, @JsonKey(name: 'd') required this.durationSeconds, @JsonKey(name: 'm') required this.muxPlaybackId, @JsonKey(name: 'u') required this.thumbnailUrl, @IgnoreIfEmpty(name: 'p')  List<VerseSelection> passages = const []}): _passages = passages,super._();
  factory _Video.fromJson(Map<String, dynamic> json) => _$VideoFromJson(json);

@override@JsonKey(name: 'i') final  String id;
@override@JsonKey(name: 't') final  String title;
@override@JsonKey(name: 'd') final  int durationSeconds;
@override@JsonKey(name: 'm') final  String muxPlaybackId;
@override@JsonKey(name: 'u') final  String thumbnailUrl;
 final  List<VerseSelection> _passages;
@override@IgnoreIfEmpty(name: 'p') List<VerseSelection> get passages {
  if (_passages is EqualUnmodifiableListView) return _passages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_passages);
}


/// Create a copy of Video
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VideoCopyWith<_Video> get copyWith => __$VideoCopyWithImpl<_Video>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VideoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Video&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.muxPlaybackId, muxPlaybackId) || other.muxPlaybackId == muxPlaybackId)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&const DeepCollectionEquality().equals(other._passages, _passages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,durationSeconds,muxPlaybackId,thumbnailUrl,const DeepCollectionEquality().hash(_passages));

@override
String toString() {
  return 'Video(id: $id, title: $title, durationSeconds: $durationSeconds, muxPlaybackId: $muxPlaybackId, thumbnailUrl: $thumbnailUrl, passages: $passages)';
}


}

/// @nodoc
abstract mixin class _$VideoCopyWith<$Res> implements $VideoCopyWith<$Res> {
  factory _$VideoCopyWith(_Video value, $Res Function(_Video) _then) = __$VideoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'i') String id,@JsonKey(name: 't') String title,@JsonKey(name: 'd') int durationSeconds,@JsonKey(name: 'm') String muxPlaybackId,@JsonKey(name: 'u') String thumbnailUrl,@IgnoreIfEmpty(name: 'p') List<VerseSelection> passages
});




}
/// @nodoc
class __$VideoCopyWithImpl<$Res>
    implements _$VideoCopyWith<$Res> {
  __$VideoCopyWithImpl(this._self, this._then);

  final _Video _self;
  final $Res Function(_Video) _then;

/// Create a copy of Video
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? durationSeconds = null,Object? muxPlaybackId = null,Object? thumbnailUrl = null,Object? passages = null,}) {
  return _then(_Video(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,durationSeconds: null == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int,muxPlaybackId: null == muxPlaybackId ? _self.muxPlaybackId : muxPlaybackId // ignore: cast_nullable_to_non_nullable
as String,thumbnailUrl: null == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String,passages: null == passages ? _self._passages : passages // ignore: cast_nullable_to_non_nullable
as List<VerseSelection>,
  ));
}


}


/// @nodoc
mixin _$VideoCollection {

@JsonKey(name: 't') String get title;@JsonKey(name: 'v') List<Video> get videos;
/// Create a copy of VideoCollection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VideoCollectionCopyWith<VideoCollection> get copyWith => _$VideoCollectionCopyWithImpl<VideoCollection>(this as VideoCollection, _$identity);

  /// Serializes this VideoCollection to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VideoCollection&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.videos, videos));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,const DeepCollectionEquality().hash(videos));

@override
String toString() {
  return 'VideoCollection(title: $title, videos: $videos)';
}


}

/// @nodoc
abstract mixin class $VideoCollectionCopyWith<$Res>  {
  factory $VideoCollectionCopyWith(VideoCollection value, $Res Function(VideoCollection) _then) = _$VideoCollectionCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 't') String title,@JsonKey(name: 'v') List<Video> videos
});




}
/// @nodoc
class _$VideoCollectionCopyWithImpl<$Res>
    implements $VideoCollectionCopyWith<$Res> {
  _$VideoCollectionCopyWithImpl(this._self, this._then);

  final VideoCollection _self;
  final $Res Function(VideoCollection) _then;

/// Create a copy of VideoCollection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? videos = null,}) {
  return _then(VideoCollection(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,videos: null == videos ? _self.videos : videos // ignore: cast_nullable_to_non_nullable
as List<Video>,
  ));
}

}


/// Adds pattern-matching-related methods to [VideoCollection].
extension VideoCollectionPatterns on VideoCollection {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VideoCollection value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VideoCollection() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VideoCollection value)  $default,){
final _that = this;
switch (_that) {
case _VideoCollection():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VideoCollection value)?  $default,){
final _that = this;
switch (_that) {
case _VideoCollection() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 't')  String title, @JsonKey(name: 'v')  List<Video> videos)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VideoCollection() when $default != null:
return $default(_that.title,_that.videos);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 't')  String title, @JsonKey(name: 'v')  List<Video> videos)  $default,) {final _that = this;
switch (_that) {
case _VideoCollection():
return $default(_that.title,_that.videos);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 't')  String title, @JsonKey(name: 'v')  List<Video> videos)?  $default,) {final _that = this;
switch (_that) {
case _VideoCollection() when $default != null:
return $default(_that.title,_that.videos);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VideoCollection implements VideoCollection {
  const _VideoCollection({@JsonKey(name: 't') required this.title, @JsonKey(name: 'v') required  List<Video> videos}): _videos = videos;
  factory _VideoCollection.fromJson(Map<String, dynamic> json) => _$VideoCollectionFromJson(json);

@override@JsonKey(name: 't') final  String title;
 final  List<Video> _videos;
@override@JsonKey(name: 'v') List<Video> get videos {
  if (_videos is EqualUnmodifiableListView) return _videos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_videos);
}


/// Create a copy of VideoCollection
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VideoCollectionCopyWith<_VideoCollection> get copyWith => __$VideoCollectionCopyWithImpl<_VideoCollection>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VideoCollectionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VideoCollection&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other._videos, _videos));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,const DeepCollectionEquality().hash(_videos));

@override
String toString() {
  return 'VideoCollection(title: $title, videos: $videos)';
}


}

/// @nodoc
abstract mixin class _$VideoCollectionCopyWith<$Res> implements $VideoCollectionCopyWith<$Res> {
  factory _$VideoCollectionCopyWith(_VideoCollection value, $Res Function(_VideoCollection) _then) = __$VideoCollectionCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 't') String title,@JsonKey(name: 'v') List<Video> videos
});




}
/// @nodoc
class __$VideoCollectionCopyWithImpl<$Res>
    implements _$VideoCollectionCopyWith<$Res> {
  __$VideoCollectionCopyWithImpl(this._self, this._then);

  final _VideoCollection _self;
  final $Res Function(_VideoCollection) _then;

/// Create a copy of VideoCollection
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? videos = null,}) {
  return _then(_VideoCollection(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,videos: null == videos ? _self._videos : videos // ignore: cast_nullable_to_non_nullable
as List<Video>,
  ));
}


}

// dart format on
