import 'dart:math';

import 'package:collection/collection.dart';
import 'package:reels/src/ffmpeg/transcribe.dart';
import 'package:reels/src/model/clip.dart';
import 'package:reels/src/model/framing.dart';
import 'package:reels/src/render/clip_time.dart';

List<CropChange> getCropChanges(ResolvedClip clip, Transcript transcript, {required int fps}) => [
  if (clip.zoomOut case final zoomOut?)
    CropChange(
      at: getClipFrame(zoomOut.at, clip, transcript, fps: fps),
      frames: max(1, zoomOut.frames),
      framing: clip.framing,
      crop: clip.crop,
      easing: zoomOut.easing,
    ),
  ...clip.zooms.map(
    (zoom) => CropChange(
      at: getClipFrame(zoom.at, clip, transcript, fps: fps),
      frames: max(1, zoom.frames),
      framing: zoom.framing,
      crop: clip.getZoomCrop(zoom),
      easing: zoom.easing,
    ),
  ),
];

Framing getFramingAt(ResolvedClip clip, List<CropChange> changes, int frame) =>
    changes.lastWhereOrNull((change) => change.at <= frame)?.framing ?? clip.framing;

// `crop` and `zoompan` both snap the window to whole source pixels, which judders as a zoom slows down. perspective
// samples between pixels, mapping the window's corners to the frame's.
String getZoomFilter(Crop start, List<CropChange> changes) {
  final zoom = getCropExpression(start, changes, (crop) => crop.zoom);
  final top = 'H*(${getCropExpression(start, changes, (crop) => crop.top)})';
  final left = 'W*(${getCropExpression(start, changes, (crop) => crop.left)})';
  final right = '$left+W/($zoom)';
  final bottom = '$top+H/($zoom)';
  return "perspective=x0='$left':y0='$top':x1='$right':y1='$top':x2='$left':y2='$bottom':x3='$right':y3='$bottom'"
      ':eval=frame';
}

// An expression over the clip's frame: the start value, plus each change's difference eased in. perspective's `in`
// counts from 1.
String getCropExpression(Crop start, List<CropChange> changes, double Function(Crop) valueOf) => [
  '${valueOf(start)}',
  ...changes.mapIndexed((index, change) {
    final from = index == 0 ? start : changes[index - 1].crop;
    final eased = getEasedExpression(change.easing, 'clip((in-1-${change.at})/${change.frames},0,1)');
    return '(${valueOf(change.crop) - valueOf(from)})*($eased)';
  }),
].join('+');

String getEasedExpression(Easing easing, String progress) => switch (easing) {
  .cubicInOut => 'if(lt($progress,0.5),4*pow($progress,3),1-pow(2-2*$progress,3)/2)',
  .quarticInOut => 'if(lt($progress,0.5),8*pow($progress,4),1-pow(2-2*$progress,4)/2)',
};
