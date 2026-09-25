import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart' as mkv;
import 'package:reels/src/app/caption_field.dart';
import 'package:reels/src/app/clips_list.dart';
import 'package:reels/src/app/media_list.dart';
import 'package:reels/src/app/media_panel.dart';
import 'package:reels/src/app/trim_controls.dart';
import 'package:reels/src/ffmpeg/ingest.dart';
import 'package:reels/src/ffmpeg/media.dart';
import 'package:reels/src/launch/video_builder.dart';
import 'package:reels/src/model/clip.dart';
import 'package:reels/src/model/clips.dart';
import 'package:reels/src/model/clips_list_order.dart';
import 'package:reels/src/model/media.dart';
import 'package:reels/src/render/render.dart';

enum EditorMode { clips, media, preview }

class EditorPage extends HookWidget {
  const EditorPage({required this.builder, super.key});

  final VideoBuilder builder;

  @override
  Widget build(BuildContext context) {
    final video = builder();

    final player = useMemoized(Player.new);
    final controller = useMemoized(() => mkv.VideoController(player), [player]);
    useEffect(() => player.dispose, [player]);

    final artifacts = useState<Ingest?>(null);
    final source = useState<Clips?>(null);
    final progress = useState<(String, double)?>(null);
    final error = useState<Object?>(null);
    final mode = useState(EditorMode.clips);
    final focused = useState<String?>(null);
    final library = useState<MediaLibrary?>(null);
    final focusedMedia = useState<String?>(null);
    final fileClips = video.clips.map((c) => c.name).toList();
    // Keyed by the file's list so a hot reload after pasting resets the ticks to match it.
    final selected = useValueNotifier(fileClips.toSet(), fileClips);
    useValueListenable(selected);
    final loaded = useState<String?>(null);
    final busy = useState(false);
    final pauseAt = useRef<Duration?>(null);

    Duration at(int frame) => Duration(microseconds: frame * 1000000 ~/ source.value!.fps);

    useEffect(() {
      final subscription = player.stream.position.listen((position) {
        if (pauseAt.value case final end? when position >= end) {
          pauseAt.value = null;
          player.pause();
        }
      });
      return subscription.cancel;
    }, [player]);

    Future<void> openMedia(String path, {File? audio}) async {
      pauseAt.value = null;
      await player.open(Media(path), play: false);
      if (player.state.duration == Duration.zero) {
        await player.stream.duration
            .firstWhere((d) => d > Duration.zero)
            .timeout(const Duration(seconds: 10), onTimeout: () => Duration.zero);
      }
      // mpv can only add an external track once the file has loaded, which a known duration confirms.
      if (audio != null) await player.setAudioTrack(AudioTrack.uri(audio.path));
      loaded.value = path;
    }

    useEffect(() {
      Future<void>(() async {
        try {
          final result = await ingest(video, onProgress: (step, f) => progress.value = (step, f));
          artifacts.value = result;
          source.value = loadClips(video);
          await openMedia(result.proxy.path, audio: result.voice);
        } on Object catch (e) {
          error.value = e;
        } finally {
          progress.value = null;
        }
      });
      return null;
    }, []);

    Future<void> playClip(SourceClip clip) async {
      if (artifacts.value case final ready?) {
        focused.value = clip.name;
        mode.value = EditorMode.clips;
        if (loaded.value != ready.proxy.path) await openMedia(ready.proxy.path, audio: ready.voice);
        pauseAt.value = at(clip.keeper.end);
        await player.seek(at(clip.keeper.start));
        await player.play();
      }
    }

    Duration getPreviewStart() {
      final clips = video.resolve(source.value!);
      if (!clips.any((c) => c.name == focused.value)) return Duration.zero;
      return at(clips.takeWhile((c) => c.name != focused.value).map((c) => c.take.frameCount).sum);
    }

    Future<void> showPreview() async {
      if (busy.value || source.value == null || video.clips.isEmpty) return;

      busy.value = true;
      try {
        final file = await buildPreview(video, onProgress: (step, f) => progress.value = (step, f));
        if (loaded.value != file.path) await openMedia(file.path);
        await player.seek(getPreviewStart());
        await player.play();
      } on Object catch (e) {
        error.value = e;
      } finally {
        busy.value = false;
        progress.value = null;
      }
    }

    Future<void> showMedia(MediaFile file) async {
      focusedMedia.value = file.name;
      if (loaded.value != file.preview.path) await openMedia(file.preview.path);
      await player.seek(
        Duration(microseconds: (library.value!.getFrame(file.name, 'start') + 0.25) * 1000000 ~/ outputFps),
      );
    }

    // Reloaded on every visit, so newly recorded files show up. Normalizing is cached per version of each file.
    Future<void> loadMedia() async {
      if (busy.value) return;
      busy.value = true;
      try {
        final loadedLibrary = await ingestMedia(video, onProgress: (step, f) => progress.value = (step, f));
        library.value = loadedLibrary;
        final files = loadedLibrary.files;
        if (files.firstWhereOrNull((f) => f.name == focusedMedia.value) ?? files.firstOrNull case final file?) {
          await showMedia(file);
        }
      } on Object catch (e) {
        error.value = e;
      } finally {
        busy.value = false;
        progress.value = null;
      }
    }

    void editTags(MediaFile file, Map<String, int> tags) {
      library.value = library.value!.withTags(file.name, tags);
      saveMediaTags(video, library.value!);
    }

    Future<void> renderVideo() async {
      if (busy.value) return;
      busy.value = true;
      try {
        final output = await render(video, onProgress: (step, f) => progress.value = (step, f));
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Rendered ${output.path}')));
        }
      } on Object catch (e) {
        error.value = e;
      } finally {
        busy.value = false;
        progress.value = null;
      }
    }

    void commit(Clips next) {
      source.value = next;
      saveClips(video, next);
    }

    void trim(SourceClip clip, {int start = 0, int end = 0}) =>
        commit(source.value!.replacing(clip.name, clip.trimmed(start: start, end: end)));

    void editCaption(SourceClip clip, String text) =>
        commit(source.value!.replacing(clip.name, clip.withKeeper(clip.keeper.transcribed(text))));

    void rename(SourceClip clip, String name) {
      if (name.isEmpty || name == clip.name || source.value![name] != null) return;
      commit(source.value!.replacing(clip.name, clip.renamed(name)));
      if (focused.value == clip.name) focused.value = name;
      if (selected.value.contains(clip.name)) {
        selected.value = {...selected.value.where((n) => n != clip.name), name};
      }
    }

    void copyClips() {
      final names = getUpdatedClipsList(current: fileClips, selected: selected.value, source: source.value!);
      final body = names
          .map((name) => '    ${(video.clips.firstWhereOrNull((c) => c.name == name) ?? Clip(name)).toDart()},')
          .join('\n');
      Clipboard.setData(ClipboardData(text: 'clips: [\n$body\n  ],'));
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Copied ${names.length} clips. Paste them into ${video.name}.dart')));
    }

    useEffect(() {
      switch (mode.value) {
        case EditorMode.preview:
          showPreview();
        case EditorMode.media:
          loadMedia();
        case EditorMode.clips:
      }
      return null;
    }, [mode.value, fileClips.join(',')]);

    if (error.value case final failure?) {
      return ErrorScreen(error: failure, onRetry: () => error.value = null);
    }

    if (source.value case final loadedSource?) {
      return Scaffold(
        appBar: AppBar(
          title: Text(video.name),
          actions: [
            SegmentedButton<EditorMode>(
              segments: const [
                ButtonSegment(value: EditorMode.clips, label: Text('Clips')),
                ButtonSegment(value: EditorMode.media, label: Text('Media')),
                ButtonSegment(value: EditorMode.preview, label: Text('Preview')),
              ],
              selected: {mode.value},
              // A switch while busy would never build its preview, since nothing re-triggers it afterwards.
              onSelectionChanged: busy.value ? null : (s) => mode.value = s.first,
            ),
            const SizedBox(width: 16),
            FilledButton.icon(
              onPressed: busy.value || video.clips.isEmpty ? null : renderVideo,
              icon: const Icon(Icons.movie_creation_outlined),
              label: const Text('Render'),
            ),
            const SizedBox(width: 16),
          ],
        ),
        body: Row(
          children: [
            SizedBox(
              width: 340,
              child: mode.value == EditorMode.media
                  ? MediaList(
                      library: library.value,
                      fps: loadedSource.fps,
                      focused: focusedMedia.value,
                      hasFolder: video.media != null,
                      onFocus: showMedia,
                    )
                  : Column(
                      children: [
                        Expanded(
                          child: ClipsList(
                            source: loadedSource,
                            focused: focused.value,
                            selected: selected.value,
                            onFocus: playClip,
                            onToggle: (clip) => selected.value = selected.value.contains(clip.name)
                                ? ({...selected.value}..remove(clip.name))
                                : {...selected.value, clip.name},
                            onRename: rename,
                          ),
                        ),
                        SelectionSyncBar(
                          fileName: '${video.name}.dart',
                          added: selected.value.difference(fileClips.toSet()).length,
                          removed: fileClips.toSet().difference(selected.value).length,
                          onCopy: copyClips,
                        ),
                      ],
                    ),
            ),
            const VerticalDivider(width: 1),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: mode.value == EditorMode.preview && video.clips.isEmpty
                        ? const EmptyPreviewHint()
                        : mkv.Video(controller: controller, fit: .contain),
                  ),
                  if (progress.value case final active?)
                    Padding(
                      padding: .symmetric(horizontal: 16, vertical: 8),
                      child: Row(
                        spacing: 12,
                        children: [
                          Expanded(child: LinearProgressIndicator(value: active.$2)),
                          Text(active.$1),
                        ],
                      ),
                    ),
                  if (mode.value == EditorMode.clips)
                    if (loadedSource[focused.value ?? ''] case final clip?) ...[
                      TrimControls(clip: clip, fps: loadedSource.fps, onTrim: trim, onReplay: () => playClip(clip)),
                      CaptionField(clip: clip, onChanged: (text) => editCaption(clip, text)),
                    ],
                  if (mode.value == EditorMode.media)
                    if (library.value case final ready?)
                      if (ready.files.firstWhereOrNull((f) => f.name == focusedMedia.value) case final file?
                          when loaded.value == file.preview.path)
                        MediaPanel(
                          player: player,
                          file: file,
                          library: ready,
                          fps: loadedSource.fps,
                          onChanged: (tags) => editTags(file, tags),
                        ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: .min,
          spacing: 16,
          children: [
            SizedBox(width: 280, child: LinearProgressIndicator(value: progress.value?.$2)),
            Text(progress.value?.$1 ?? 'Preparing'),
          ],
        ),
      ),
    );
  }
}

class EmptyPreviewHint extends StatelessWidget {
  const EmptyPreviewHint({super.key});

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: .all(32),
      child: Text(
        'This video has no clips yet.\n\n'
        'Tick the clips you want, copy them as Dart, and paste them into the video file.',
        textAlign: .center,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    ),
  );
}

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({required this.error, required this.onRetry, super.key});

  final Object error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: Padding(
        padding: .all(32),
        child: Column(
          mainAxisSize: .min,
          spacing: 16,
          children: [
            SelectableText('$error', style: Theme.of(context).textTheme.bodySmall),
            FilledButton(onPressed: onRetry, child: const Text('Dismiss')),
          ],
        ),
      ),
    ),
  );
}
