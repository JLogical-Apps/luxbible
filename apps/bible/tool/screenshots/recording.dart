// ignore_for_file: invalid_use_of_visible_for_testing_member, depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lux/lux.dart';

import 'harness.dart';

final previewDirectory = Directory('build/preview');
final previewFps = 30;
final previewPixelRatio = 2.0;
final frameDuration = Duration(microseconds: Duration.microsecondsPerSecond ~/ previewFps);

class Recording {
  final Screenshot screenshot;
  final String name;
  final touches = <Map<String, Object>>[];
  var frameCount = 0;

  Recording(this.screenshot, this.name);

  WidgetTester get tester => screenshot.tester;

  String get directory => '${previewDirectory.path}/${screenshot.device.name}/$name';

  Duration get elapsed => frameDuration * frameCount;

  Future<void> start() async {
    final frames = Directory('$directory/frames');
    await tester.runAsync(() async {
      if (await frames.exists()) await frames.delete(recursive: true);
      await frames.create(recursive: true);
    });
  }

  // Each frame also gives real time to IO and isolates, so loads triggered mid-recording still land.
  Future<void> frame() async {
    await tester.pump(frameDuration);
    final path = '$directory/frames/${'$frameCount'.padLeft(4, '0')}.png';
    frameCount++;
    await tester.runAsync(() => screenshot.writePng(screenshot.screenKey, path, pixelRatio: previewPixelRatio));
  }

  Future<void> hold(double seconds) async {
    for (final _ in Range.generate(1, (seconds * previewFps).round())) {
      await frame();
    }
  }

  Future<void> type(Finder field, String text, {required double seconds, double after = 0}) async {
    await tester.showKeyboard(field);
    final frames = (seconds * previewFps).round();
    for (final index in Range.generate(1, frames)) {
      tester.testTextInput.enterText(text.substring(0, (text.length * index / frames).round()));
      await frame();
    }
    await hold(after);
  }

  void logTouch(String phase, Offset globalPosition) {
    final position = globalPosition - Offset(screenshot.device.bezelWidth, screenshot.device.bezelWidth);
    final size = screenshot.device.logicalScreenSize;
    touches.add({'frame': frameCount, 'phase': phase, 'x': position.dx / size.width, 'y': position.dy / size.height});
  }

  Future<TestGesture> down(Offset position) async {
    final gesture = await tester.createGesture();
    await gesture.down(position, timeStamp: elapsed);
    logTouch('down', position);
    return gesture;
  }

  Future<void> up(TestGesture gesture, Offset position) async {
    await gesture.up(timeStamp: elapsed);
    logTouch('up', position);
  }

  Future<void> tapAt(Offset position, {double after = 0}) async {
    final gesture = await down(position);
    await hold(0.1);
    await up(gesture, position);
    await hold(after);
  }

  Future<void> tap(Finder finder, {double after = 0}) => tapAt(tester.getCenter(finder.first), after: after);

  Future<void> tapText(String text, {double after = 0}) => tapAt(textCenter(text), after: after);

  Offset characterCenter(String text, int index) {
    final paragraph = screenshot.findParagraph(text)!;
    final offset = paragraph.text.toPlainText().indexOf(text) + index;
    final box = paragraph.getBoxesForSelection(TextSelection(baseOffset: offset, extentOffset: offset + 1)).first;
    return paragraph.localToGlobal(box.toRect().center);
  }

  Offset textCenter(String text) => Offset.lerp(characterCenter(text, 0), characterCenter(text, text.length - 1), 0.5)!;

  Future<void> move(
    TestGesture gesture,
    Offset from,
    Offset to, {
    required double seconds,
    Curve curve = Curves.easeInOut,
  }) async {
    final frames = (seconds * previewFps).round();
    for (final index in Range.generate(1, frames)) {
      final position = Offset.lerp(from, to, curve.transform(index / frames))!;
      await gesture.moveTo(position, timeStamp: elapsed);
      logTouch('move', position);
      await frame();
    }
  }

  Future<void> drag(
    Offset from,
    Offset to, {
    required double seconds,
    Curve curve = Curves.easeInOut,
    double after = 0,
  }) async {
    final gesture = await down(from);
    await frame();
    await move(gesture, from, to, seconds: seconds, curve: curve);
    // Resting before lifting zeroes the velocity, so the scroll stops where the drag ends instead of flinging on.
    await hold(0.15);
    await up(gesture, to);
    await hold(after);
  }

  // Long-presses the first word of [text], then drags to the end of it to select the phrase.
  Future<void> selectText(String text, {double dragSeconds = 0.8, double after = 0}) async {
    final from = characterCenter(text, 0);
    final to = characterCenter(text, text.length - 1);
    final gesture = await down(from);
    await hold(0.6);
    await move(gesture, from, to, seconds: dragSeconds);
    await up(gesture, to);
    await hold(after);
  }

  Future<void> finish() => tester.runAsync(() async {
    await File('$directory/touches.json').writeAsString(jsonEncode(touches));
    final result = await Process.run('ffmpeg', [
      '-y',
      '-loglevel',
      'error',
      '-framerate',
      '$previewFps',
      '-i',
      '$directory/frames/%04d.png',
      '-c:v',
      'libx264',
      '-preset',
      'slow',
      '-crf',
      '12',
      '-pix_fmt',
      'yuv420p',
      '-movflags',
      '+faststart',
      '$directory/$name.mp4',
    ]);
    if (result.exitCode != 0) throw StateError('ffmpeg failed for $name: ${result.stderr}');
  });
}
