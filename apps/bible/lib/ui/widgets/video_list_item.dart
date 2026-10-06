import 'package:bible/models/video.dart';
import 'package:bible/ui/pages/video_page.dart';
import 'package:bible/ui/widgets/video_thumbnail.dart';
import 'package:flutter/material.dart';
import 'package:lux/lux.dart';
import 'package:style/style.dart';

class VideoListItem extends StatelessWidget {
  final Video video;
  final Function(VerseSelection) onNavigateToVerseSelection;

  const VideoListItem({super.key, required this.video, required this.onNavigateToVerseSelection});

  @override
  Widget build(BuildContext context) => StyledListItem.navigation(
    size: .lg,
    leadingWidth: 104,
    leading: ClipRRect(
      borderRadius: .circular(8),
      child: SizedBox(width: 88, height: 50, child: VideoThumbnail(video: video, imageWidth: 320)),
    ),
    title: video.title.toText(),
    subtitle: video.duration.format().toText(),
    onPressed: () async {
      final result = await context.push(VideoPage(video: video));
      if (result != null && context.mounted) onNavigateToVerseSelection(result);
    },
  );
}
