import 'package:bible/providers/audio_bible_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lux/lux.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rxdart/rxdart.dart';

part 'audio_bible_player_provider.g.dart';

typedef AudioBibleNativePlayerState = ({PlayerState? playerState, Duration? duration, PlayerException? error});
typedef AudioBiblePlayerState = ({
  bool isActive,
  Duration? duration,
  bool isPlaying,
  bool isLoading,
  PlayerException? error,
});

@riverpod
Stream<AudioBibleNativePlayerState> audioBibleNativePlayer(Ref ref) {
  final player = ref.watch(audioBibleHandlerProvider)?.player;
  final audioBibleController = ref.watch(audioBibleControllerProvider.notifier);
  return Rx.combineLatest3(
    player == null ? .empty() : player.playerStateStream.startWith(player.playerState),
    player == null ? .empty() : player.durationStream.startWith(player.duration),
    audioBibleController.errors,
    (playerState, duration, error) => (playerState: playerState, duration: duration, error: error),
  );
}

@riverpod
AudioBiblePlayerState audioBiblePlayer(Ref ref, {required AudioBibleContext context}) {
  final isActive = ref.watch(audioBibleControllerProvider.select((state) => state.activeContext == context));
  final handler = ref.watch(audioBibleHandlerProvider);
  final audioBibleController = ref.watch(audioBibleControllerProvider.notifier);
  final nativePlayer =
      ref.watch(audioBibleNativePlayerProvider).value ??
      (playerState: handler?.player.playerState, duration: handler?.player.duration, error: audioBibleController.error);

  return (
    isActive: isActive,
    duration: isActive ? nativePlayer.duration : null,
    isPlaying: isActive && nativePlayer.playerState?.playing == true,
    isLoading:
        isActive &&
        (nativePlayer.playerState?.processingState == .loading ||
            nativePlayer.playerState?.processingState == .buffering),
    error: isActive ? nativePlayer.error : null,
  );
}

@riverpod
Reference? audioBibleSpokenReference(Ref ref, {required AudioBibleContext context}) {
  final session = ref.watch(audioBibleProvider(context: context));
  final player = ref.watch(audioBiblePlayerProvider(context: context));
  final position = ref.watch(audioBiblePositionProvider).value;
  return session == null || !player.isActive || player.isLoading || position == null
      ? null
      : session.getReferenceAtPosition(position);
}
