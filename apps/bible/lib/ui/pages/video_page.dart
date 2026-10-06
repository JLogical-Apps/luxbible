import 'package:bible/models/video.dart';
import 'package:bible/ui/hooks/video_playback.dart';
import 'package:bible/ui/sheets/preview_passage_sheet.dart';
import 'package:bible/ui/widgets/passage_list_item.dart';
import 'package:bible/ui/widgets/video_player_view.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:style/style.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoPage extends HookConsumerWidget implements StyledRoute<VerseSelection> {
  final Video video;

  const VideoPage({super.key, required this.video});

  @override
  String get path => '/video';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = useVideoPlayback(ref, video: video);

    // Keyed on the rotation rather than checked every build, so leaving fullscreen while sideways doesn't reopen it.
    final isLandscapePhone =
        MediaQuery.orientationOf(context) == .landscape && MediaQuery.sizeOf(context).shortestSide < 600;
    usePostFrameEffect(() {
      final chewieController = player.data;
      if (context.mounted && isLandscapePhone && chewieController != null && !chewieController.isFullScreen) {
        chewieController.enterFullScreen();
      }
    }, [isLandscapePhone, player.data]);

    return StyledPage(
      body: StyledScrollbar(
        child: StyledListView(
          padding: .only(bottom: MediaQuery.paddingOf(context).bottom),
          children: [
            VideoPlayerView(video: video, player: player),
            StyledSection.child(
              title: video.title.toText(),
              subtitle: Video.source.toText(),
              child: StyledRichText(
                style: context.textStyle.paragraphSm.subtle(),
                parts: [
                  StyledRichTextPart.text(t.videos.attributionPrefix),
                  StyledRichTextPart.link('bibleproject.com', onTap: () => launchUrl(video.pageUri)),
                  StyledRichTextPart.text(t.videos.attributionSuffix),
                ],
              ),
            ),
            if (video.passages.isNotEmpty)
              StyledSection(
                title: t.videos.passages.toText(),
                children: video.passages
                    .map(
                      (passage) => PassageListItem(
                        verseSelection: passage,
                        maxLines: 2,
                        onPressed: () => PreviewPassageSheet.show(
                          context,
                          verseSelection: passage,
                          onNavigateToVerseSelection: (verseSelection) => context.pop(verseSelection),
                        ),
                      ),
                    )
                    .toList(),
              ),
          ],
        ),
      ),
    );
  }
}
