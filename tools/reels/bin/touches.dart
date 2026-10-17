import 'dart:io';

import 'package:reels/src/ffmpeg/touches.dart';

Future<void> main(List<String> args) async {
  if (args.length != 3) {
    stderr.writeln('Usage: dart run bin/touches.dart <video> <touches.json> <output.mp4>');
    exit(64);
  }
  await drawTouches(File(args[0]), File(args[1]), File(args[2]));
}
