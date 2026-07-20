import 'dart:async';

import 'package:bible/providers/user_provider.dart';
import 'package:bible/utils/extensions/duration_extensions.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'audio_bible_provider.g.dart';

class AudioBibleState {
  final Duration position;
  final Duration? duration;
  final bool isPlaying;

  const AudioBibleState({required this.position, required this.duration, this.isPlaying = false});
}

@Riverpod(keepAlive: true)
AudioPlayer audioBiblePlayer(Ref ref) {
  final player = AudioPlayer();
  ref.onDispose(() => player.dispose());
  return player;
}

@riverpod
Stream<Duration> audioBiblePosition(Ref ref) => ref.watch(audioBiblePlayerProvider).positionStream;

@riverpod
Stream<Duration?> audioBibleDuration(Ref ref) => ref.watch(audioBiblePlayerProvider).durationStream;

@riverpod
Stream<PlayerState> audioBiblePlayerState(Ref ref) => ref.watch(audioBiblePlayerProvider).playerStateStream;

@riverpod
bool isAudioBiblePlaying(Ref ref) => ref.watch(audioBibleProvider).value?.isPlaying == true;

@riverpod
void audioAssetLoader(Ref ref) {
  ref.listen(userProvider.select((user) => user.lastReference.audioAssetPath), (prev, next) async {
    if (prev == next) {
      return;
    }

    final player = ref.read(audioBiblePlayerProvider);
    if (next != null) {
      await player.setAsset(next);
    } else {
      player.pause();
    }
  }, fireImmediately: true);

  ref.listen(userProvider.select((user) => user.audio.speed), (prev, next) async {
    if (prev == next) {
      return;
    }

    final player = ref.read(audioBiblePlayerProvider);
    await player.setSpeed(next);
  }, fireImmediately: true);

  ref.listen(audioBiblePlayerStateProvider, (_, next) async {
    final player = ref.read(audioBiblePlayerProvider);
    final playerState = next.value;
    if (playerState != null && playerState.processingState == .completed && playerState.playing) {
      await player.pause();
      await player.seek(.zero);
    }
  });
}

@Riverpod(keepAlive: true)
class AudioBible extends _$AudioBible {
  AudioPlayer get player => ref.read(audioBiblePlayerProvider);

  @override
  Future<AudioBibleState> build() async {
    ref.watch(audioAssetLoaderProvider);

    final user = ref.watch(userProvider);
    final assetPath = user.lastReference.audioAssetPath;
    if (assetPath == null) {
      throw UnsupportedError('Unsupported chapter');
    }

    final playerState = ref.watch(audioBiblePlayerStateProvider).value;
    final position = ref.watch(audioBiblePositionProvider).requireValue;
    final duration = ref.watch(audioBibleDurationProvider).requireValue;

    return AudioBibleState(position: position, duration: duration, isPlaying: playerState?.playing ?? player.playing);
  }

  Future<void> toggle() async {
    final user = ref.read(userProvider);
    if (user.lastReference.audioAssetPath == null) {
      return;
    }

    if (player.playing) {
      await player.pause();
      return;
    }

    if (state.hasError) {
      ref.invalidate(audioBibleProvider);
    }
    try {
      await future;
    } catch (_) {
      return;
    }

    if (player.processingState == .completed) {
      await player.seek(.zero);
    }
    await player.play();
  }

  Future<void> seek(Duration position) => player.seek(position.clamp(.zero, player.duration ?? .zero));

  Future<void> seekBy(Duration offset) => seek(player.position + offset);

  Future<void> close() => player.stop();
}
