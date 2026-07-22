import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:bible/models/reference/chapter_position.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/services/audio_bible_handler.dart';
import 'package:bible/services/path_service.dart';
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
AudioBibleHandler audioBibleHandler(Ref ref) =>
    throw UnimplementedError('AudioBibleHandler must be initialized in main');

@riverpod
Stream<Duration> audioBiblePosition(Ref ref) => ref.watch(audioBibleHandlerProvider).player.positionStream;

@riverpod
Stream<Duration?> audioBibleDuration(Ref ref) => ref.watch(audioBibleHandlerProvider).player.durationStream;

@riverpod
Stream<PlayerState> audioBiblePlayerState(Ref ref) => ref.watch(audioBibleHandlerProvider).player.playerStateStream;

@riverpod
class AudioBiblePlaybackError extends _$AudioBiblePlaybackError {
  @override
  PlayerException? build() {
    final player = ref.watch(audioBibleHandlerProvider).player;
    final subscription = player.errorStream.listen((error) {
      unawaited(player.pause());
      state = error;
    });
    ref.onDispose(subscription.cancel);
    return null;
  }

  void clear() => state = null;
}

Duration? noAudioBibleLoadRetry(int retryCount, Object error) => null;

@riverpod
bool isAudioBiblePlaying(Ref ref) => ref.watch(audioBibleProvider).value?.isPlaying == true;

@Riverpod(keepAlive: true)
class AudioBibleTimer extends _$AudioBibleTimer {
  Timer? timer;

  @override
  DateTime? build() {
    ref.onDispose(() => timer?.cancel());
    return null;
  }

  void update(Duration? duration) {
    timer?.cancel();

    if (duration == null) {
      state = null;
      timer = null;
    } else {
      state = DateTime.now().add(duration);
      timer = Timer(duration, () async {
        state = null;
        await ref.read(audioBibleHandlerProvider).stop();
      });
    }
  }
}

@Riverpod(retry: noAudioBibleLoadRetry)
Future<void> loadedAudioBible(Ref ref) async {
  final source = ref.watch(
    userProvider.select((user) {
      final reference = user.lastReference;
      return (
        uri: user.audioUri,
        id: reference.osisId(),
        album: user.getTranslationFor(reference.book).fullName(),
        title: reference.format(),
      );
    }),
  );
  final handler = ref.read(audioBibleHandlerProvider);

  if (source.uri case final uri?) {
    await handler.loadUrl(
      uri.toString(),
      MediaItem(
        id: source.id,
        album: source.album,
        title: source.title,
        artUri: (await ref.read(pathServiceProvider)?.getAssetAsFile('assets/images/lux-logo-full.png'))?.uri,
      ),
    );
  } else {
    await handler.pause();
  }
}

@riverpod
void audioBibleListeners(Ref ref) {
  ref.listen(userProvider.select((user) => user.audioUri), (_, _) {
    ref.read(audioBiblePlaybackErrorProvider.notifier).clear();
  });

  ref.listen(userProvider.select((user) => user.audio.speed), (prev, next) async {
    if (prev == next) {
      return;
    }

    await ref.read(audioBibleHandlerProvider).setSpeed(next);
  }, fireImmediately: true);

  ref.listen(audioBiblePlayerStateProvider, (_, next) async {
    final player = ref.read(audioBibleHandlerProvider).player;
    final playerState = next.value;
    if (playerState != null && playerState.processingState == .completed && playerState.playing) {
      final nextReference = ref.read(userProvider).lastReference.next;
      if (nextReference != null) {
        await ref
            .read(userProvider.notifier)
            .update((user) => user.withSoftNavigation(ChapterPosition(reference: nextReference)));
      } else {
        await player.pause();
      }
    }
  });
}

@Riverpod(keepAlive: true)
class AudioBible extends _$AudioBible {
  AudioBibleHandler get handler => ref.read(audioBibleHandlerProvider);
  AudioPlayer get player => handler.player;

  @override
  Future<AudioBibleState> build() async {
    ref.watch(audioBibleListenersProvider);
    final playbackError = ref.watch(audioBiblePlaybackErrorProvider);
    await ref.watch(loadedAudioBibleProvider.future);

    final user = ref.watch(userProvider);
    if (user.audioUri == null) {
      throw UnsupportedError('Unsupported chapter');
    }
    if (playbackError != null) {
      throw playbackError;
    }

    final playerState = ref.watch(audioBiblePlayerStateProvider).value;
    final position = ref.watch(audioBiblePositionProvider).requireValue;
    final duration = ref.watch(audioBibleDurationProvider).requireValue;

    return AudioBibleState(position: position, duration: duration, isPlaying: playerState?.playing ?? player.playing);
  }

  Future<void> toggle() async {
    final user = ref.read(userProvider);
    if (user.audioUri == null) {
      return;
    }

    if (state.hasError) {
      await handler.pause();
      ref.read(audioBiblePlaybackErrorProvider.notifier).clear();
      ref.invalidate(loadedAudioBibleProvider);
    } else if (player.playing) {
      await handler.pause();
      return;
    }
    try {
      await future;
    } catch (_) {
      return;
    }

    if (player.processingState == .completed) {
      await player.seek(.zero);
    }
    await handler.play();
  }

  Future<void> seek(Duration position) => handler.seek(position.clamp(.zero, player.duration ?? .zero));

  Future<void> seekBy(Duration offset) => seek(player.position + offset);

  Future<void> close() => handler.stop();
}
