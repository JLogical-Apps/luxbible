import 'package:bible/providers/audio_bible_provider.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/style/style.dart';
import 'package:bible/utils/extensions/collection_extensions.dart';
import 'package:bible/utils/extensions/duration_extensions.dart';
import 'package:bible/utils/extensions/flutter_string_extensions.dart';
import 'package:bible/utils/extensions/icon_data_extensions.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class AudioBiblePanel extends HookConsumerWidget {
  final bool showDragHandle;

  const AudioBiblePanel({super.key, required this.showDragHandle});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final audioBible = ref.watch(audioBibleProvider);

    final chapterReference = user.lastReference;
    final translation = user.translationFor(chapterReference.book);

    final positionOverrideState = useState<double?>(null);

    return StyledSheet(
      showDragHandle: showDragHandle,
      title: chapterReference.format().toText(),
      subtitle: 'Audio Bible'.toText(),
      leading: StyledCircleButton.md(
        child: Symbols.close.toIcon(),
        onPressed: () {
          ref.updateUser((user) => user.copyWith.audio(isOpen: false));
          ref.read(audioBibleProvider.notifier).close();
        },
      ),
      children: [
        translation.hasAudioBible
            ? Padding(
                padding: .all(16),
                child: switch (audioBible) {
                  AsyncError() => Column(
                    spacing: 12,
                    children: [
                      StyledTile.message(
                        leading: Symbols.error.toIcon(),
                        title: 'The audio could not be loaded'.toText(),
                        subtitle: 'Check your internet connection or try again later.'.toText(),
                      ),
                      StyledRectButton.secondary(
                        label: 'Try Again'.toText(),
                        onPressed: () => ref.read(audioBibleProvider.notifier).toggle(),
                      ),
                    ],
                  ),
                  AsyncValue(:final value) => () {
                    final notifier = ref.read(audioBibleProvider.notifier);
                    final maxValue = value?.duration?.inMilliseconds.toDouble() ?? 0.01;
                    return Column(
                      children: [
                        gapH12,
                        StyledSlider(
                          value: (positionOverrideState.value ?? value?.position.inMilliseconds.toDouble() ?? 0).clamp(
                            0,
                            maxValue,
                          ),
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
                            Text((value?.duration ?? .zero).format(), style: context.textStyle.labelSm.subtle()),
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
                            gapW16,
                            StyledCircleButton.lg(
                              child: Symbols.replay_10.toIcon(),
                              onPressed: () => notifier.seekBy(Duration(seconds: -10)),
                            ),
                            gapW16,
                            StyledCircleButton.lg(
                              colorBuilder: .primary,
                              child: (value?.isPlaying == true ? Symbols.pause : Symbols.play_arrow).toIcon(),
                              onPressed: () => notifier.toggle(),
                            ),
                            gapW16,
                            StyledCircleButton.lg(
                              child: Symbols.forward_10.toIcon(),
                              onPressed: () => notifier.seekBy(Duration(seconds: 10)),
                            ),
                            Spacer(),
                            StyledCircleButton.lg(
                              child: Icon(Symbols.timer, fill: 0),
                              onPressed: () => notifier.seekBy(Duration(seconds: -10)),
                            ),
                          ],
                        ),
                      ],
                    );
                  }(),
                },
              )
            : Padding(
                padding: .all(16),
                child: Column(
                  spacing: 12,
                  children: [
                    StyledTile.message(
                      leading: Symbols.headset_off.toIcon(),
                      title: 'Audio is unavailable for this Bible'.toText(),
                      subtitle: 'Choose an audio-enabled Bible to listen to this chapter.'.toText(),
                    ),
                    StyledRectButton.secondary(
                      label: 'Switch to BSB'.toText(),
                      onPressed: () => ref.updateUser((user) => user.withTranslation(.bsb)),
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
