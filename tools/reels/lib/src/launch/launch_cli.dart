import 'dart:io';

import 'package:collection/collection.dart';
import 'package:reels/src/ffmpeg/ingest.dart';
import 'package:reels/src/ffmpeg/transcribe.dart';
import 'package:reels/src/launch/video_builder.dart';
import 'package:reels/src/paths.dart';
import 'package:reels/src/render/render.dart';

const usage = '''
Usage: dart run <video.dart> <command>

  ingest    Normalize the source and detect clips
  clips     List detected clips and their takes
  captions  List each clip's caption words and when they start
  render    Render the final video

Run this file with `flutter run -d macos -t <video.dart>` for the preview UI.''';

Future<void> runVideo(List<String> args, VideoBuilder builder) async {
  final video = builder();

  switch (args.firstOrNull) {
    case 'ingest':
      await ingest(video, onProgress: report);
      stdout.writeln('\nIngested ${video.name}.');
    case 'clips':
      await ingest(video, onProgress: report);
      final source = loadClips(video);
      stdout.writeln('\n${source.clips.length} clips');
      final width = source.clips.map((c) => c.name.length).max;
      for (final clip in source.clips) {
        final seconds = (clip.keeper.frameCount / source.fps).toStringAsFixed(2).padLeft(5);
        final takes = (clip.takes.length > 1 ? '×${clip.takes.length}' : '').padLeft(3);
        final text = clip.keeper.isSilent ? '(no speech)' : clip.keeper.text ?? '(not transcribed)';
        stdout.writeln('${clip.name.padRight(width)} ${seconds}s $takes  $text');
      }
    case 'captions':
      final artifacts = await ingest(video, onProgress: report);
      final source = loadClips(video);
      stdout.writeln();
      for (final clip in source.clips) {
        final captions = await getCaptions(
          artifacts.audio,
          take: clip.keeper,
          fps: source.fps,
          cache: cacheDirFor(video),
        );
        final words = captions.words.map((w) => '${w.text}@${(w.start / source.fps).toStringAsFixed(2)}');
        stdout.writeln('${clip.name}: ${words.join(' ')}');
      }
    case 'render':
      final output = await render(video, onProgress: report);
      stdout.writeln('\nRendered ${output.path}');
    case _:
      stdout.writeln(usage);
  }
}

void report(String step, double fraction) =>
    stdout.write('\r${step.padRight(42)} ${(fraction * 100).toStringAsFixed(0).padLeft(3)}%');
