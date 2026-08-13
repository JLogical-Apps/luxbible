import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:bible/models/audio_bible_playback_target.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/services/audio_bible_handler.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lux/lux.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'audio_bible_provider.g.dart';

class AudioBibleState {
  final Duration position;
  final Duration? duration;

  const AudioBibleState({required this.position, required this.duration});
}

@Riverpod(keepAlive: true)
AudioBibleHandler audioBibleHandler(Ref ref) =>
    throw UnimplementedError('AudioBibleHandler must be initialized in main');

@riverpod
Stream<Duration> audioBiblePosition(Ref ref) => ref
    .watch(audioBibleHandlerProvider)
    .player
    .createPositionStream(
      steps: 1,
      minPeriod: const Duration(milliseconds: 16),
      maxPeriod: const Duration(milliseconds: 16),
    );

@riverpod
Stream<Duration?> audioBibleDuration(Ref ref) => ref.watch(audioBibleHandlerProvider).player.durationStream;

@riverpod
Stream<PlayerState> audioBiblePlayerState(Ref ref) => ref.watch(audioBibleHandlerProvider).player.playerStateStream;

@Riverpod(keepAlive: true)
class AudioBibleTarget extends _$AudioBibleTarget {
  @override
  AudioBiblePlaybackTarget? build() => null;

  void update(AudioBiblePlaybackTarget target) => state = target;

  void clear() => state = null;
}

@riverpod
class AudioBiblePlaybackError extends _$AudioBiblePlaybackError {
  @override
  PlayerException? build() {
    final player = ref.watch(audioBibleHandlerProvider).player;
    final subscription = player.errorStream.listen((error) {
      player.pause();
      state = error;
    });
    ref.onDispose(subscription.cancel);
    return null;
  }

  void clear() => state = null;
}

@riverpod
bool isAudioBiblePlaying(Ref ref) => ref.watch(audioBiblePlayerStateProvider).value?.playing == true;

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

@riverpod
Future<void> loadedAudioBible(Ref ref) async {
  final target = ref.watch(audioBibleTargetProvider);
  final handler = ref.read(audioBibleHandlerProvider);

  if (target?.uri case final uri?) {
    final reference = target!.chapterReference;
    await handler.loadUrl(
      uri.toString(),
      MediaItem(
        id: reference.osisId(),
        album: target.translation.fullName(),
        title: reference.format(),
        artUri: (await ref.read(pathServiceProvider)?.getAssetAsFile('assets/images/lux-logo-full.png'))?.uri,
      ),
    );
  } else {
    await handler.pause();
  }
}

@riverpod
void audioBibleListeners(Ref ref) {
  ref.listen(
    userProvider.select(
      (user) => (reference: user.lastReference, translation: user.getTranslationFor(user.lastReference.book)),
    ),
    (_, source) {
      ref.read(audioBiblePlaybackErrorProvider.notifier).clear();
      if (ref.read(audioBibleTargetProvider)?.context == .bible) {
        ref
            .read(audioBibleTargetProvider.notifier)
            .update(.chapter(translation: source.translation, chapterReference: source.reference));
      }
    },
  );

  ref.listen(
    userProvider.select((user) => user.audio.speed),
    (prev, next) => ref.read(audioBibleHandlerProvider).setSpeed(next),
    fireImmediately: true,
  );

  ref.listen(audioBiblePlayerStateProvider, (_, next) async {
    final player = ref.read(audioBibleHandlerProvider).player;
    final playerState = next.value;
    if (playerState != null && playerState.processingState == .completed && playerState.playing) {
      switch (ref.read(audioBibleTargetProvider)?.context) {
        case .bible:
          final nextReference = ref.read(audioBibleTargetProvider)?.chapterReference.next;
          if (nextReference != null) {
            await ref
                .read(userProvider.notifier)
                .update((user) => user.withSoftNavigation(ChapterPosition(reference: nextReference)));
          } else {
            await player.pause();
          }
        case .readingPlan || null:
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
  FutureOr<AudioBibleState> build() async {
    ref.watch(audioBibleListenersProvider);
    ref.watch(loadedAudioBibleProvider).requireValue;

    final playbackError = ref.watch(audioBiblePlaybackErrorProvider);
    if (playbackError != null) {
      throw playbackError;
    }

    final position = ref.watch(audioBiblePositionProvider).requireValue;
    final duration = ref.watch(audioBibleDurationProvider).requireValue;

    return AudioBibleState(position: position, duration: duration);
  }

  Future<void> toggle() async {
    final user = ref.read(userProvider);
    final reference = user.lastReference;
    final target = AudioBiblePlaybackTarget.chapter(
      translation: user.getTranslationFor(reference.book),
      chapterReference: reference,
    );
    if (target.uri == null) return;

    if (ref.read(audioBibleTargetProvider) == target && player.playing) {
      await handler.pause();
      return;
    }

    await playTarget(target);
  }

  Future<void> playTarget(AudioBiblePlaybackTarget target) async {
    if (target.uri == null) return;

    if (ref.read(audioBibleTargetProvider) != target) {
      ref.read(audioBibleTargetProvider.notifier).update(target);
    }

    if (state.hasError) {
      await handler.pause();
      ref.read(audioBiblePlaybackErrorProvider.notifier).clear();
      ref.invalidate(loadedAudioBibleProvider);
    }
    try {
      await ref.read(loadedAudioBibleProvider.future);
    } catch (_) {
      return;
    }

    if (player.processingState == .completed) {
      await player.seek(.zero);
    }
    await handler.play();
  }

  Future<void> pause() => handler.pause();

  Future<void> seek(Duration position) => handler.seek(position.clamp(.zero, player.duration ?? .zero));

  Future<void> seekBy(Duration offset) => seek(player.position + offset);

  Future<void> close() async {
    await handler.stop();
    ref.read(audioBibleTargetProvider.notifier).clear();
  }
}
