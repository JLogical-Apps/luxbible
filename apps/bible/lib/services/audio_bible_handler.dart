import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class AudioBibleHandler extends BaseAudioHandler with SeekHandler {
  static const seekBackwardControl = MediaControl(
    androidIcon: 'drawable/replay_10_24px',
    label: 'Back 10 seconds',
    action: .rewind,
  );

  static const seekForwardControl = MediaControl(
    androidIcon: 'drawable/forward_10_24px',
    label: 'Forward 10 seconds',
    action: .fastForward,
  );

  final AudioPlayer player = AudioPlayer();

  AudioBibleHandler() {
    player.playbackEventStream.listen(
      (event) => playbackState.add(
        PlaybackState(
          controls: [seekBackwardControl, if (player.playing) .pause else .play, .stop, seekForwardControl],
          systemActions: {.seek, .seekForward, .seekBackward},
          androidCompactActionIndices: [0, 1, 3],
          processingState: switch (player.processingState) {
            .idle => .idle,
            .loading => .loading,
            .buffering => .buffering,
            .ready => .ready,
            .completed => .completed,
          },
          playing: player.playing,
          updatePosition: player.position,
          bufferedPosition: player.bufferedPosition,
          speed: player.speed,
          queueIndex: event.currentIndex,
        ),
      ),
    );
  }

  Future<void> loadUrl(String url, MediaItem item, {Duration? clipEnd}) async {
    mediaItem.add(item);
    final duration = await player.setUrl(url);
    final clippedDuration = clipEnd == null ? duration : await player.setClip(end: clipEnd);
    mediaItem.add(item.copyWith(duration: clippedDuration));
  }

  @override
  Future<void> setSpeed(double speed) => player.setSpeed(speed);

  @override
  Future<void> play() => player.play();

  @override
  Future<void> pause() => player.pause();

  @override
  Future<void> seek(Duration position) => player.seek(position);

  @override
  Future<void> stop() => player.stop();

  @override
  Future<void> onTaskRemoved() => stop();
}
