import 'package:bible/models/video.dart';
import 'package:bible/providers/audio_bible_provider.dart';
import 'package:bible/services/analytics_service.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:video_player/video_player.dart';

AsyncSnapshot<ChewieController?> useVideoPlayback(WidgetRef ref, {required Video video}) {
  final context = useContext();
  final videoPlayerController = useDisposable(
    useMemoized(() => VideoPlayerController.networkUrl(video.streamUri), [video]),
    (controller) => controller.dispose(),
  );

  // Chewie's own autoplay initializes without catching load failures, so it's only given a loaded controller.
  final snapshot = useMemoizedFuture(() async {
    await videoPlayerController.initialize();
    if (!context.mounted) return null;

    ref.read(audioBibleHandlerProvider)?.pause();
    videoPlayerController.play();
    AnalyticsEvent.videoPlayed.log();
    return ChewieController(
      videoPlayerController: videoPlayerController,
      aspectRatio: videoPlayerController.value.aspectRatio,
      allowedScreenSleep: false,
      optionsTranslation: OptionsTranslation(
        playbackSpeedButtonText: t.videos.playbackSpeed,
        cancelButtonText: t.common.cancel,
      ),
      materialProgressColors: progressColors,
      cupertinoProgressColors: progressColors,
      errorBuilder: (context, errorMessage) => Center(child: Icon(Icons.error_outline, color: Colors.white)),
    );
  }, [videoPlayerController]);
  useDisposable(snapshot.data, (controller) => controller?.dispose());

  return snapshot;
}

// Chewie's default played color is red, which clashes with Lux's monochrome palette.
final progressColors = ChewieProgressColors(
  playedColor: Colors.white,
  handleColor: Colors.white,
  bufferedColor: Colors.white38,
  backgroundColor: Colors.white24,
);
