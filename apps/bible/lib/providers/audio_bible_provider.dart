import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:bible/models/audio_bible_verse_timing.dart';
import 'package:bible/providers/audio_bible_timings_provider.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/services/audio_bible_handler.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lux/lux.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:utils_core/utils_core.dart';

part 'audio_bible_provider.freezed.dart';
part 'audio_bible_provider.g.dart';

enum AudioBibleContext { bible, plan }

@freezed
sealed class AudioBibleContextState with _$AudioBibleContextState {
  const AudioBibleContextState._();

  const factory AudioBibleContextState({
    required BibleTranslation translation,
    required VerseSelection passage,
    required Map<Reference, AudioBibleVerseTiming> timings,
  }) = _AudioBibleContextState;

  Uri? get uri => translation.getAudioAssetUri(passage.references.first.toChapterReference());

  Duration get startPosition => passage.getAudioStartPosition(timings);
  Duration? getEndPosition(Duration? duration) =>
      passage.isChapter ? duration : passage.getLastAudioTiming(timings)?.end ?? duration;

  Reference? getReferenceAtPosition(Duration position) =>
      timings.getReferenceAtPosition(passage: passage, position: position);
}

class AudioBibleState {
  final Map<AudioBibleContext, AudioBibleContextState> sessions;
  final AudioBibleContext? activeContext;
  final DateTime? timerEndTime;

  const AudioBibleState({this.sessions = const {}, this.activeContext, this.timerEndTime});

  AudioBibleContextState? getSessionFor(AudioBibleContext context) => sessions[context];

  AudioBibleState copyWith({
    Map<AudioBibleContext, AudioBibleContextState>? sessions,
    AudioBibleContext? activeContext,
    bool clearActiveContext = false,
    DateTime? timerEndTime,
    bool clearTimerEndTime = false,
  }) => AudioBibleState(
    sessions: sessions ?? this.sessions,
    activeContext: clearActiveContext ? null : activeContext ?? this.activeContext,
    timerEndTime: clearTimerEndTime ? null : timerEndTime ?? this.timerEndTime,
  );
}

@Riverpod(keepAlive: true)
AudioBibleHandler audioBibleHandler(Ref ref) =>
    throw UnimplementedError('AudioBibleHandler must be initialized in main');

@riverpod
Stream<Duration> audioBiblePosition(Ref ref) => ref
    .watch(audioBibleHandlerProvider)
    .player
    .createPositionStream(steps: 1, minPeriod: Duration(milliseconds: 16), maxPeriod: Duration(milliseconds: 16));

@riverpod
AudioBibleContextState? audioBible(Ref ref, {required AudioBibleContext context}) =>
    ref.watch(audioBibleControllerProvider.select((state) => state.getSessionFor(context)));

@Riverpod(keepAlive: true)
class AudioBibleController extends _$AudioBibleController {
  final positions = <AudioBibleContext, Duration>{};

  final spokenReferenceSubjects = AudioBibleContext.values.mapToMap(
    (context) => MapEntry(context, BehaviorSubject<Reference?>.seeded(null)),
  );
  final completionSubjects = AudioBibleContext.values.mapToMap(
    (context) => MapEntry(context, PublishSubject<VerseSelection>()),
  );
  final errorSubject = BehaviorSubject<PlayerException?>.seeded(null);

  StreamSubscription<PlayerState>? playerStateSubscription;
  StreamSubscription<PlayerException>? errorSubscription;
  StreamSubscription<Duration>? positionSubscription;

  Timer? timer;

  AudioBibleHandler get handler => ref.read(audioBibleHandlerProvider);
  AudioPlayer get player => handler.player;

  @override
  AudioBibleState build() {
    playerStateSubscription = player.playerStateStream.listen(handlePlayerState);
    errorSubscription = player.errorStream.listen(handleError);
    positionSubscription = player.positionStream.listen(handlePosition);

    ref.listen(
      userProvider.select((user) => user.audio.speed),
      (_, speed) => handler.setSpeed(speed),
      fireImmediately: true,
    );

    ref.onDispose(() {
      playerStateSubscription?.cancel();
      errorSubscription?.cancel();
      positionSubscription?.cancel();
      timer?.cancel();

      for (var subject in <Subject>[...spokenReferenceSubjects.values, ...completionSubjects.values]) {
        subject.close();
      }

      errorSubject.close();
    });

    return const AudioBibleState();
  }

  ValueStream<Reference?> spokenReferences(AudioBibleContext context) => spokenReferenceSubjects[context]!;

  Stream<VerseSelection> completions(AudioBibleContext context) => completionSubjects[context]!;

  ValueStream<PlayerException?> get errors => errorSubject;
  PlayerException? get error => errorSubject.value;

  Future<bool> play({required AudioBibleContext context, required VerseSelection passage}) async {
    final translation = ref.read(userProvider).getTranslationFor(passage.references.first.book);
    final timings = getTimingsFor(translation, passage);
    final session = state.getSessionFor(context);
    final isSamePassage = session?.translation == translation && session?.passage == passage;

    if (translation.getAudioAssetUri(passage.references.first.toChapterReference()) == null) {
      return false;
    }

    if (state.activeContext == context && isSamePassage && session != null && error == null) {
      if (player.processingState == .completed || session.passage.hasReachedAudioEnd(player.position, timings)) {
        await seekTo(context: context, position: passage.getAudioStartPosition(timings));
      }
      await handler.play();
      return true;
    }

    final initialPosition = isSamePassage
        ? positions[context] ?? session?.startPosition ?? passage.getAudioStartPosition(timings)
        : passage.getAudioStartPosition(timings);

    await activate(
      context: context,
      session: AudioBibleContextState(translation: translation, passage: passage, timings: timings),
      initialPosition: initialPosition,
      shouldPlay: true,
    );

    return error == null;
  }

  Future<bool> toggle({required AudioBibleContext context, required VerseSelection passage}) async {
    final session = state.getSessionFor(context);
    if (state.activeContext == context && session?.passage == passage && player.playing) {
      await pause(context: context);
      return true;
    }

    return play(context: context, passage: passage);
  }

  Future<void> replacePassage({required AudioBibleContext context, required VerseSelection passage}) async {
    final session = state.getSessionFor(context);
    if (session == null) {
      return;
    }

    final translation = ref.read(userProvider).getTranslationFor(passage.references.first.book);
    if (session.translation == translation && session.passage == passage) {
      return;
    }

    final timings = getTimingsFor(translation, passage);
    final startPosition = passage.getAudioStartPosition(timings);
    final replacement = session.copyWith(translation: translation, passage: passage, timings: timings);

    positions[context] = startPosition;

    if (replacement.uri == null) {
      if (state.activeContext == context) {
        await handler.pause();
      }
      updateSession(context, (_) => replacement);
      return;
    }

    if (state.activeContext == context) {
      await activate(
        context: context,
        session: replacement,
        initialPosition: startPosition,
        shouldPlay: player.playing,
      );
    } else {
      updateSession(context, (_) => replacement);
    }
  }

  Future<void> pause({required AudioBibleContext context}) async {
    if (state.activeContext == context && state.getSessionFor(context) != null) {
      await handler.pause();
    }
  }

  Future<void> seekTo({required AudioBibleContext context, required Duration position}) async {
    final session = state.getSessionFor(context);
    if (state.activeContext != context || session == null) {
      return;
    }

    final clampedPosition = position.clamp(.zero, player.duration ?? .zero);
    final reference = session.getReferenceAtPosition(clampedPosition);
    await handler.seek(clampedPosition);
    if (reference != null) {
      emitSpokenReference(context: context, reference: reference, force: true);
    }
  }

  Future<void> seekToReference({required AudioBibleContext context, required Reference reference}) async {
    final session = state.getSessionFor(context);
    final timing = session?.timings[reference];
    if (timing != null) {
      await seekTo(context: context, position: timing.start);
    }
  }

  Future<void> seekBy({required AudioBibleContext context, required Duration offset}) =>
      seekTo(context: context, position: player.position + offset);

  Future<void> remove({required AudioBibleContext context}) async {
    final removedSession = state.getSessionFor(context);
    if (removedSession == null) {
      return;
    }

    final wasActive = state.activeContext == context;
    if (wasActive) {
      await handler.stop();
    }

    positions.remove(context);
    spokenReferenceSubjects[context]!.add(null);

    state = state.copyWith(sessions: {...state.sessions}..remove(context), clearActiveContext: wasActive);

    if (!wasActive) {
      return;
    }

    final nextContext = AudioBibleContext.values.firstWhereOrNull(
      (availableContext) => availableContext != context && state.getSessionFor(availableContext) != null,
    );
    final nextSession = nextContext == null ? null : state.getSessionFor(nextContext);
    if (nextContext == null || nextSession == null) {
      setTimer(null);
      return;
    }

    await activate(
      context: nextContext,
      session: nextSession,
      initialPosition: positions[nextContext] ?? nextSession.startPosition,
      shouldPlay: false,
    );
  }

  void setTimer(Duration? duration) {
    timer?.cancel();
    timer = null;

    if (duration == null) {
      state = state.copyWith(clearTimerEndTime: true);
      return;
    }

    final endTime = DateTime.now().add(duration);
    state = state.copyWith(timerEndTime: endTime);
    timer = Timer(duration, () async {
      state = state.copyWith(clearTimerEndTime: true);
      await handler.stop();
    });
  }

  Future<void> activate({
    required AudioBibleContext context,
    required AudioBibleContextState session,
    required Duration initialPosition,
    required bool shouldPlay,
  }) async {
    if (state.activeContext case final activeContext? when activeContext != context) {
      positions[activeContext] = player.position;
      await handler.pause();
    } else if (state.activeContext == context) {
      await handler.pause();
    }

    spokenReferenceSubjects[context]!.add(null);
    state = state.copyWith(sessions: {...state.sessions, context: session}, activeContext: context);

    try {
      await handler.loadUrl(
        session.uri.toString(),
        MediaItem(
          id: session.passage.format(),
          album: session.translation.fullName(),
          title: session.passage.format(),
          artUri: (await ref.read(pathServiceProvider)?.getAssetAsFile('assets/images/lux-logo-full.png'))?.uri,
        ),
        clipEnd: session.passage.isChapter ? null : session.passage.getLastAudioTiming(session.timings)?.end,
      );
      await handler.seek(initialPosition.clamp(.zero, player.duration ?? .zero));
      positions[context] = initialPosition;
      errorSubject.add(null);

      if (session.getReferenceAtPosition(initialPosition) case final reference?) {
        emitSpokenReference(context: context, reference: reference, force: true);
      }

      if (shouldPlay) {
        await handler.play();
      }
    } on PlayerException catch (error) {
      handleError(error);
    }
  }

  void handlePlayerState(PlayerState playerState) {
    if (playerState.processingState == .completed && playerState.playing) {
      completeActivePassage();
    }
  }

  void handleError(PlayerException error) {
    final context = state.activeContext;
    if (context == null) {
      return;
    }
    handler.pause();
    errorSubject.add(error);
  }

  void handlePosition(Duration position) {
    final context = state.activeContext;
    final session = context == null ? null : state.getSessionFor(context);
    final reference = session?.getReferenceAtPosition(position);
    final canFollow = player.processingState != .loading && player.processingState != .buffering;
    if (context != null && session != null && canFollow && reference != null) {
      emitSpokenReference(context: context, reference: reference);
    }
    if (session != null && player.playing && session.passage.hasReachedAudioEnd(position, session.timings)) {
      completeActivePassage();
    }
  }

  Future<void> completeActivePassage() async {
    final context = state.activeContext;
    final session = context == null ? null : state.getSessionFor(context);
    if (context == null || session == null) {
      return;
    }

    await handler.pause();
    final isStillCurrent = state.activeContext == context && state.getSessionFor(context)?.passage == session.passage;
    if (isStillCurrent) {
      completionSubjects[context]!.add(session.passage);
    }
  }

  void emitSpokenReference({required AudioBibleContext context, required Reference reference, bool force = false}) {
    final subject = spokenReferenceSubjects[context]!;
    if (!force && subject.valueOrNull == reference) {
      return;
    }

    subject.add(reference);
  }

  Map<Reference, AudioBibleVerseTiming> getTimingsFor(BibleTranslation translation, VerseSelection passage) {
    final translationTimings = ref.read(audioBibleTimingsProvider)[translation] ?? {};
    return passage.references
        .mapToMap((reference) => MapEntry(reference, translationTimings[reference]))
        .withoutNullValues;
  }

  void updateSession(
    AudioBibleContext context,
    AudioBibleContextState Function(AudioBibleContextState session) update,
  ) {
    final session = state.getSessionFor(context);
    if (session == null) {
      return;
    }

    state = state.copyWith(sessions: {...state.sessions, context: update(session)});
  }
}
