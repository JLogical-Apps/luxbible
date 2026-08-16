import 'package:animated_size_and_fade/animated_size_and_fade.dart';
import 'package:bible/providers/audio_bible_player_provider.dart';
import 'package:bible/providers/audio_bible_provider.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';
import 'package:utils_core/utils_core.dart';

class AudioBiblePanel extends ConsumerWidget {
  final bool showDragHandle;

  const AudioBiblePanel({super.key, required this.showDragHandle});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final session = ref.watch(audioBibleProvider(context: .bible));

    final chapterReference = session?.passage.references.first.toChapterReference() ?? user.lastReference;
    final translation = user.getTranslationFor(chapterReference.book);

    return StyledSheet(
      showDragHandle: showDragHandle,
      title: chapterReference.format().toText(),
      subtitle: t.labels.audioBible.toText(),
      leading: StyledCircleButton.md(
        child: Symbols.close.toIcon(),
        onPressed: () {
          ref.updateUser((user) => user.copyWith.audio(isOpen: false));
          ref.read(audioBibleControllerProvider.notifier).remove(context: .bible);
        },
      ),
      children: [
        translation.hasAudioBible
            ? AudioBiblePanelBody(context: .bible, passage: chapterReference.toVerseSelection())
            : Padding(
                padding: .all(16),
                child: Column(
                  spacing: 12,
                  children: [
                    StyledTile.message(
                      leading: Symbols.headset_off.toIcon(),
                      title: t.audio.unavailable.toText(),
                      subtitle: t.audio.chooseBible.toText(),
                    ),
                    StyledRectButton.secondary(
                      label: t.common.switchTo(translation: user.audioTranslation.title()).toText(),
                      onPressed: () => ref.updateUser((user) => user.withTranslation(user.audioTranslation)),
                    ),
                  ],
                ),
              ),
      ],
    );
  }
}

class AudioBiblePanelBody extends HookConsumerWidget {
  final AudioBibleContext context;
  final VerseSelection? passage;
  final EdgeInsets padding;

  const AudioBiblePanelBody({super.key, required this.context, this.passage, this.padding = const .all(16)});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final session = ref.watch(audioBibleProvider(context: this.context));
    final player = ref.watch(audioBiblePlayerProvider(context: this.context));
    final position = ref.watch(audioBiblePositionProvider).value ?? .zero;
    final timerEndTime = ref.watch(audioBibleControllerProvider.select((state) => state.timerEndTime));
    final audioBibleController = ref.read(audioBibleControllerProvider.notifier);

    final positionOverrideState = useState<double?>(null);
    usePostFrameEffect(() => positionOverrideState.value = null, [session?.passage]);

    useStream(useMemoized(() => timerEndTime == null ? .empty() : .periodic(Duration(seconds: 1)), [timerEndTime]));

    final duration = player.duration;
    final startPosition = this.context == .plan ? session?.startPosition ?? .zero : Duration.zero;
    final endPosition = this.context == .plan ? session?.getEndPosition(duration) ?? duration : duration;

    final minValue = startPosition.inMilliseconds.toDouble();
    final endValue = endPosition?.inMilliseconds.toDouble() ?? minValue;
    final maxValue = endValue > minValue ? endValue : minValue + 0.01;

    final previewPosition = positionOverrideState.value?.mapIfNonNull(
      (milliseconds) => Duration(milliseconds: milliseconds.round()),
    );

    final previewReference = session == null || previewPosition == null
        ? null
        : session.getReferenceAtPosition(previewPosition);

    final displayedPosition = (position - startPosition).clampZero;
    final displayedDuration = endPosition == null ? Duration.zero : (endPosition - startPosition).clampZero;

    return AnimatedSizeAndFade(
      child: Padding(
        padding: padding,
        child: player.error == null
            ? Column(
                children: [
                  gapH12,
                  StyledSlider(
                    value: (positionOverrideState.value ?? position.inMilliseconds.toDouble()).clamp(
                      minValue,
                      maxValue,
                    ),
                    bounds: (minValue, maxValue),
                    label: previewReference?.verseNum.mapIfNonNull((verseNum) => ' $verseNum '),
                    onChanged: duration == null ? null : (value) => positionOverrideState.value = value,
                    onChangeEnd: duration == null
                        ? null
                        : (value) {
                            positionOverrideState.value = null;
                            audioBibleController.seekTo(
                              context: this.context,
                              position: Duration(milliseconds: value.round()),
                            );
                          },
                  ),
                  gapH8,
                  Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      Text(displayedPosition.format(), style: context.textStyle.labelSm.subtle()),
                      if (timerEndTime != null)
                        Row(
                          spacing: 4,
                          children: [
                            Icon(Symbols.timer, size: 14, color: context.colors.contentSecondary),
                            Text(
                              timerEndTime.difference(DateTime.now()).clampZero.format(),
                              style: context.textStyle.labelSm.subtle(),
                            ),
                          ],
                        )
                      else
                        Text(displayedDuration.format(), style: context.textStyle.labelSm.subtle()),
                    ],
                  ),
                  gapH24,
                  Row(
                    children: [
                      StyledCircleButton.lg(
                        child: switch (user.audio.speed) {
                          0.7 => Symbols.speed_0_7x,
                          1 => Symbols.one_x_mobiledata,
                          1.2 => Symbols.speed_1_2x,
                          1.5 => Symbols.speed_1_5x,
                          1.7 => Symbols.speed_1_7x,
                          _ => Symbols.speed_2x,
                        }.toIcon(),
                        onPressed: () => ref.updateUser((user) => user.copyWith.audio(speed: user.audio.nextSpeed)),
                      ),
                      Spacer(),
                      StyledCircleButton.lg(
                        child: Symbols.replay_10.toIcon(),
                        onPressed: session == null
                            ? null
                            : () => audioBibleController.seekBy(context: this.context, offset: Duration(seconds: -10)),
                      ),
                      gapW16,
                      StyledCircleButton.lg(
                        colorBuilder: .primary,
                        child: (player.isPlaying ? Symbols.pause : Symbols.play_arrow).toIcon(),
                        onPressed: () {
                          final targetPassage = session?.passage ?? passage;
                          if (targetPassage != null) {
                            audioBibleController.toggle(context: this.context, passage: targetPassage);
                          }
                        },
                      ),
                      gapW16,
                      StyledCircleButton.lg(
                        child: Symbols.forward_10.toIcon(),
                        onPressed: session == null
                            ? null
                            : () => audioBibleController.seekBy(context: this.context, offset: Duration(seconds: 10)),
                      ),
                      Spacer(),
                      StyledCircleButton.lg(
                        child: Icon(Symbols.timer, fill: timerEndTime == null ? 0 : 1),
                        onPressed: () async {
                          final option = await context.showStyledSheet<AudioBibleTimerOption>(
                            (context) => StyledSelectionSheet<AudioBibleTimerOption>(
                              title: t.audio.timer.toText(),
                              options: AudioBibleTimerOption.values,
                              initialOption: timerEndTime == null ? .off : null,
                              optionMapper: (option) => StyledSelectOption(title: option.title().toText()),
                            ),
                          );
                          if (option != null) {
                            audioBibleController.setTimer(option.duration);
                          }
                        },
                      ),
                    ],
                  ),
                ],
              )
            : Column(
                spacing: 12,
                children: [
                  StyledTile.message(
                    leading: Symbols.error.toIcon(),
                    title: t.audio.loadError.toText(),
                    subtitle: t.audio.connectionError.toText(),
                  ),
                  StyledRectButton.secondary(
                    label: t.common.tryAgain.toText(),
                    onPressed: session == null
                        ? null
                        : () => audioBibleController.play(context: this.context, passage: session.passage),
                  ),
                ],
              ),
      ),
    );
  }
}

enum AudioBibleTimerOption {
  off,
  fiveMinutes,
  tenMinutes,
  fifteenMinutes,
  thirtyMinutes,
  oneHour;

  String title() => switch (this) {
    off => t.common.off,
    fiveMinutes => t.audio.fiveMinutes,
    tenMinutes => t.audio.tenMinutes,
    fifteenMinutes => t.audio.fifteenMinutes,
    thirtyMinutes => t.audio.thirtyMinutes,
    oneHour => t.audio.oneHour,
  };

  Duration? get duration => switch (this) {
    off => null,
    fiveMinutes => Duration(minutes: 5),
    tenMinutes => Duration(minutes: 10),
    fifteenMinutes => Duration(minutes: 15),
    thirtyMinutes => Duration(minutes: 30),
    oneHour => Duration(hours: 1),
  };
}
