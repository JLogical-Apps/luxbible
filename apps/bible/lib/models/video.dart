import 'package:bible/models/linked_resource.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lux/lux_core.dart';

part 'video.freezed.dart';
part 'video.g.dart';

@freezed
sealed class Video with _$Video, LinkedResource {
  const Video._();

  static const source = 'BibleProject';

  const factory Video({
    @JsonKey(name: 'i') required String id,
    @JsonKey(name: 't') required String title,
    @JsonKey(name: 'd') required int durationSeconds,
    @JsonKey(name: 'm') required String muxPlaybackId,
    @JsonKey(name: 'u') required String thumbnailUrl,
    @IgnoreIfEmpty(name: 'p') @Default([]) List<VerseSelection> passages,
  }) = _Video;

  factory Video.fromJson(Map<String, dynamic> json) => _$VideoFromJson(json);

  Duration get duration => Duration(seconds: durationSeconds);

  Uri get streamUri => Uri.parse('https://stream.mux.com/$muxPlaybackId.m3u8');

  // ImageKit resizes the artwork on request, so a list thumbnail doesn't download the full-size poster.
  String getThumbnailUrl({required int width}) => '$thumbnailUrl?tr=w-$width';

  Uri get pageUri => Uri.parse('https://bibleproject.com/videos/$id/');
}

@freezed
sealed class VideoCollection with _$VideoCollection {
  const factory VideoCollection({
    @JsonKey(name: 't') required String title,
    @JsonKey(name: 'v') required List<Video> videos,
  }) = _VideoCollection;

  factory VideoCollection.fromJson(Map<String, dynamic> json) => _$VideoCollectionFromJson(json);
}
