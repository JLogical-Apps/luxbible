import 'package:animated_size_and_fade/animated_size_and_fade.dart';
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

class AudioBiblePanel extends HookConsumerWidget {
  final bool showDragHandle;

  const AudioBiblePanel({super.key, required this.showDragHandle});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final audioBible = ref.watch(audioBibleProvider);
    final isPlaying = ref.watch(isAudioBiblePlayingProvider);
    final timerEndTime = ref.watch(audioBibleTimerProvider);

    final showPlaybackControls = switch (audioBible) {
      AsyncValue(hasError: false) || AsyncValue(isLoading: true, retrying: false) => true,
      _ => false,
    };

    useStream(
      useMemoized(() => timerEndTime == null ? Stream.empty() : Stream.periodic(Duration(seconds: 1)), [timerEndTime]),
    );

    final chapterReference = user.lastReference;
    final translation = user.getTranslationFor(chapterReference.book);

    final positionOverrideState = useState<double?>(null);

    return StyledSheet(
      showDragHandle: showDragHandle,
      title: chapterReference.format().toText(),
      subtitle: t.labels.audioBible.toText(),
      leading: StyledCircleButton.md(
        child: Symbols.close.toIcon(),
        onPressed: () {
          ref.updateUser((user) => user.copyWith.audio(isOpen: false));
          ref.read(audioBibleProvider.notifier).close();
        },
      ),
      children: [
        translation.hasAudioBible
            ? AnimatedSizeAndFade(
                child: Padding(
                  key: ValueKey(showPlaybackControls),
                  padding: .all(16),
                  child: showPlaybackControls
                      ? () {
                          final value = audioBible.value;
                          final notifier = ref.read(audioBibleProvider.notifier);
                          final maxValue = value?.duration?.inMilliseconds.toDouble() ?? 0.01;
                          return Column(
                            children: [
                              gapH12,
                              StyledSlider(
                                value: (positionOverrideState.value ?? value?.position.inMilliseconds.toDouble() ?? 0)
                                    .clamp(0, maxValue),
                                bounds: (0, maxValue),
                                onChanged: value == null ? null : (value) => positionOverrideState.value = value,
                                onChangeEnd: value == null
                                    ? null
                                    : (value) {
                                        positionOverrideState.value = null;
                                        notifier.seek(Duration(milliseconds: value.round()));
                                      },
                              ),
                              gapH8,
                              Row(
                                mainAxisAlignment: .spaceBetween,
                                children: [
                                  Text((value?.position ?? .zero).format(), style: context.textStyle.labelSm.subtle()),
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
                                    Text(
                                      (value?.duration ?? .zero).format(),
                                      style: context.textStyle.labelSm.subtle(),
                                    ),
                                ],
                              ),
                              gapH24,
                              Row(
                                children: [
                                  StyledCircleButton.lg(
                                    child: getSpeedIcon(user.audio.speed).toIcon(),
                                    onPressed: () => ref.updateUser(
                                      (user) => user.copyWith.audio(
                                        speed: speeds.loopedElementAt(speeds.indexOf(user.audio.speed) + 1),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  StyledCircleButton.lg(
                                    child: Symbols.replay_10.toIcon(),
                                    onPressed: () => notifier.seekBy(Duration(seconds: -10)),
                                  ),
                                  gapW16,
                                  StyledCircleButton.lg(
                                    colorBuilder: .primary,
                                    child: (isPlaying ? Symbols.pause : Symbols.play_arrow).toIcon(),
                                    onPressed: () => notifier.toggle(),
                                  ),
                                  gapW16,
                                  StyledCircleButton.lg(
                                    child: Symbols.forward_10.toIcon(),
                                    onPressed: () => notifier.seekBy(Duration(seconds: 10)),
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
                                        ref.read(audioBibleTimerProvider.notifier).update(option.duration);
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ],
                          );
                        }()
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
                              onPressed: () => ref.read(audioBibleProvider.notifier).toggle(),
                            ),
                          ],
                        ),
                ),
              )
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

IconData getSpeedIcon(double speed) => switch (speed) {
  0.7 => Symbols.speed_0_7x,
  1 => Symbols.one_x_mobiledata,
  1.2 => Symbols.speed_1_2x,
  1.5 => Symbols.speed_1_5x,
  1.7 => Symbols.speed_1_7x,
  _ => Symbols.speed_2x,
};

List<double> get speeds => [0.7, 1, 1.2, 1.5, 1.7, 2];

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
