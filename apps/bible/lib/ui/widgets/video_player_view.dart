import 'package:bible/models/video.dart';
import 'package:bible/ui/widgets/video_thumbnail.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';

class VideoPlayerView extends StatelessWidget {
  final Video video;
  final AsyncSnapshot<ChewieController?> player;

  const VideoPlayerView({super.key, required this.video, required this.player});

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Padding(
        padding: MediaQuery.viewPaddingOf(context).onlyHorizontal,
        child: Center(
          child: ConstrainedBox(
            // A full-width 16:9 player is taller than a landscape screen, so it's capped to leave the title in view.
            constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * 0.6),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: ColoredBox(
                color: Colors.black,
                child: switch (player.data) {
                  final chewieController? => Chewie(controller: chewieController),
                  _ => Stack(
                    fit: .expand,
                    children: [
                      VideoThumbnail(video: video, imageWidth: 1280),
                      if (!player.hasError) Center(child: CircularProgressIndicator(color: Colors.white)),
                    ],
                  ),
                },
              ),
            ),
          ),
        ),
      ),
      if (player.hasError)
        Padding(
          padding: .only(left: 16, right: 16, top: 16),
          child: StyledTile.message(
            leading: Symbols.error.toIcon(),
            title: t.videos.loadError.toText(),
            subtitle: t.errors.connection.toText(),
          ),
        ),
    ],
  );
}
