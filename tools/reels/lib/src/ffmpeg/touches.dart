import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:reels/src/ffmpeg/ffmpeg.dart';

// Matches RocketSim's indicator and the app recorder's: 44 pt across on a phone about 400 pt wide, growing in over 5
// frames from touch down and fading out over 6 from release.
const touchFps = 30;
const touchDiameter = 0.11;
// Light gray rather than white, so it still shows on a white screen.
const touchGray = 180;
const touchOpacity = 0.8;
const touchGrowFrames = 5;
const touchFadeFrames = 6;

class TouchPoint {
  const TouchPoint({required this.frame, required this.x, required this.y});

  final int frame;
  final double x;
  final double y;

  double get time => frame / touchFps;
}

/// One finger from touch down to release, through every point it moved to.
class Touch {
  const Touch(this.points);

  final List<TouchPoint> points;

  double get start => points.first.time;
  double get end => points.last.time;
}

/// Groups `touches.json` events, `{frame, phase, x, y}` at 30 fps with `x` and `y` as fractions of the screen, into
/// touches. Every `down` starts one, and its `move`s and `up` follow it.
List<Touch> getTouches(List<Map<String, dynamic>> events) => events
    .fold<List<List<TouchPoint>>>([], (touches, event) {
      final point = TouchPoint(
        frame: event['frame'] as int,
        x: (event['x'] as num).toDouble(),
        y: (event['y'] as num).toDouble(),
      );
      return event['phase'] == 'down'
          ? [
              ...touches,
              [point],
            ]
          : [
              ...touches.take(touches.length - 1),
              [...touches.last, point],
            ];
    })
    .map(Touch.new)
    .toList();

/// An ffmpeg expression over the time variable [t] that sums [term] while each touch shows, so only one touch counts at
/// a time. A touch shows until it has faded out, or the next one starts.
String getTouchExpression(List<Touch> touches, String t, String Function(Touch touch) term) {
  final fade = touchFadeFrames / touchFps;
  final terms = touches.mapIndexed((index, touch) {
    final until = [touch.end + fade, ?touches.elementAtOrNull(index + 1)?.start].min;
    return 'gte($t,${touch.start})*lt($t,$until)*(${term(touch)})';
  });
  return terms.isEmpty ? '0' : terms.join('+');
}

String getGrowExpression(Touch touch, String t) =>
    '1-pow(1-clip(($t-${touch.start})/${touchGrowFrames / touchFps},0,1),3)';

String getFadeExpression(Touch touch, String t) => '1-clip(($t-${touch.end})/${touchFadeFrames / touchFps},0,1)';

// Moves linearly between the touch's points.
String getPositionExpression(Touch touch, String t, double Function(TouchPoint point) axis) => [
  '${axis(touch.points.first)}',
  ...IterableZip([touch.points, touch.points.skip(1)])
      .where((pair) => pair[1].time > pair[0].time && axis(pair[1]) != axis(pair[0]))
      .map(
        (pair) => '(${axis(pair[1]) - axis(pair[0])})*clip(($t-${pair[0].time})/${pair[1].time - pair[0].time},0,1)',
      ),
].join('+');

/// Draws [touches] (a `touches.json`) onto [video] as translucent dots, writing [output] as H.264.
Future<void> drawTouches(File video, File touchesFile, File output) async {
  final touches = getTouches((jsonDecode(await touchesFile.readAsString()) as List).cast<Map<String, dynamic>>());
  final stream = await runFfprobe([
    '-select_streams',
    'v:0',
    '-show_entries',
    'stream=width,r_frame_rate',
    '-of',
    'csv=p=0',
    video.path,
  ]);
  final [width, frameRate] = stream.trim().split(',');
  final duration = await probeDuration(video.path);

  // Two pixels of margin keep the antialiased edge inside the canvas.
  final size = (int.parse(width) * touchDiameter).round() + 2;
  final center = size / 2;
  final radius = getTouchExpression(
    touches,
    'T',
    (touch) => '${size / 2 - 1}*(0.6+0.4*(${getGrowExpression(touch, 'T')}))',
  );
  final opacity = getTouchExpression(
    touches,
    'T',
    (touch) => '(0.4+0.6*(${getGrowExpression(touch, 'T')}))*(${getFadeExpression(touch, 'T')})',
  );
  final x = getTouchExpression(touches, 't', (touch) => getPositionExpression(touch, 't', (point) => point.x));
  final y = getTouchExpression(touches, 't', (touch) => getPositionExpression(touch, 't', (point) => point.y));

  await runFfmpeg([
    '-i',
    video.path,
    '-f',
    'lavfi',
    '-i',
    'color=c=white@0:s=${size}x$size:r=$frameRate:d=${duration.inMicroseconds / 1000000}',
    '-filter_complex',
    "[1:v]format=rgba,geq=r=$touchGray:g=$touchGray:b=$touchGray:a='255*$touchOpacity*($opacity)*clip(($radius)-hypot(X-$center,Y-$center)+0.5,0,1)'[dot];"
        "[0:v][dot]overlay=x='($x)*W-w/2':y='($y)*H-h/2':eval=frame[v]",
    '-map',
    '[v]',
    '-map',
    '0:a?',
    '-c:v',
    'libx264',
    '-crf',
    '14',
    '-preset',
    'medium',
    '-pix_fmt',
    'yuv420p',
    '-c:a',
    'copy',
    '-movflags',
    '+faststart',
    output.path,
  ], total: duration);
}
