import 'package:bible/models/video.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';

class VideoThumbnail extends StatelessWidget {
  final Video video;
  final int imageWidth;

  const VideoThumbnail({super.key, required this.video, required this.imageWidth});

  @override
  Widget build(BuildContext context) => ColoredBox(
    color: context.colors.surfaceTertiary,
    child: Image.network(
      video.getThumbnailUrl(width: imageWidth),
      fit: .cover,
      errorBuilder: (context, error, stackTrace) =>
          Center(child: Icon(Symbols.smart_display, color: context.colors.contentTertiary)),
    ),
  );
}
