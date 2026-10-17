import 'dart:io';

import 'package:bible/models/user/toolbar_preset.dart';
import 'package:bible/models/user/user.dart';
import 'package:bible/ui/widgets/interlinear_word_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'harness.dart';
import 'recording.dart';
import 'seed.dart';

void main() {
  late User demo;

  setUpAll(() async {
    await setUpScreenshotApp();
    HttpOverrides.global = null;
    demo = await buildDemoUser();
    await preload(demo);
  });

  User at(String passage, {ToolbarPreset preset = .reader}) =>
      demo.withPreset(preset).copyWith(lastPosition: positionOf(passage));

  recordingTest('1_read', (recording) async {
    await recording.screenshot.pumpApp(at('Genesis 1'));
    await recording.hold(1);
    await recording.drag(Offset(240, 760), Offset(240, 420), seconds: 1.4, after: 1);
  });

  recordingTest('2_annotate', (recording) async {
    await recording.screenshot.pumpApp(at('Genesis 1', preset: .noteTaker));
    await recording.hold(0.4);
    await recording.selectText('the light was good', after: 0.5);
    await recording.tap(find.byTooltip('Annotate'), after: 0.6);
    await recording.tap(find.textContaining('Sunday'), after: 0.3);
    final faith = recording.tester.getCenter(find.text('Faith'));
    await recording.drag(faith, faith - Offset(300, 0), seconds: 0.7, after: 0.2);
    await recording.tap(find.text('Application'), after: 0.3);
    await recording.tap(find.byType(EditableText).last, after: 0.2);
    await recording.type(
      find.byType(EditableText).last,
      'Light comes before the sun (v. 16)',
      seconds: 1.6,
      after: 0.4,
    );
    await recording.tap(find.text('Save'), after: 1.5);
  });

  recordingTest('3_interlinear', (recording) async {
    await recording.screenshot.pumpApp(at('John 1', preset: .studier));
    await recording.hold(0.5);
    await recording.tapText('In the beginning was the Word', after: 0.8);
    await recording.tap(find.byTooltip('Interlinear'), after: 1.5);
    await recording.tap(find.ancestor(of: find.text('Word,'), matching: find.byType(InterlinearWordTile)), after: 0.8);
    await recording.drag(Offset(240, 800), Offset(240, 440), seconds: 1.2, after: 1);
  });

  recordingTest('4_compare', (recording) async {
    await recording.screenshot.pumpApp(at('Psalm 23'));
    await recording.hold(0.5);
    await recording.tapText('The LORD is my shepherd', after: 0.8);
    await recording.tap(find.byTooltip('Compare'), after: 0.8);
    await recording.drag(Offset(240, 820), Offset(240, 380), seconds: 1.4, after: 1);
  });
}
