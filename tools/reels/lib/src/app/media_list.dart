import 'package:flutter/material.dart';
import 'package:reels/src/model/media.dart';

class MediaList extends StatelessWidget {
  const MediaList({
    required this.library,
    required this.fps,
    required this.focused,
    required this.hasFolder,
    required this.onFocus,
    super.key,
  });

  final MediaLibrary? library;
  final int fps;
  final String? focused;
  final bool hasFolder;
  final Function(MediaFile) onFocus;

  @override
  Widget build(BuildContext context) {
    if (!hasFolder) return MediaListHint(text: 'Link a folder of recordings with Video(media: ...).');
    final files = library?.files;
    if (files == null) return SizedBox.shrink();
    if (files.isEmpty) return MediaListHint(text: 'The media folder has no videos yet.');

    return ListView(
      children: files
          .map(
            (file) => MediaRow(
              file: file,
              fps: fps,
              tagCount: library!.tags[file.name]?.keys.where((tag) => tag != 'start' && tag != 'end').length ?? 0,
              isFocused: file.name == focused,
              onFocus: () => onFocus(file),
            ),
          )
          .toList(),
    );
  }
}

class MediaListHint extends StatelessWidget {
  const MediaListHint({required this.text, super.key});

  final String text;

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: .all(24),
      child: Text(text, textAlign: .center, style: Theme.of(context).textTheme.bodyMedium),
    ),
  );
}

class MediaRow extends StatelessWidget {
  const MediaRow({
    required this.file,
    required this.fps,
    required this.tagCount,
    required this.isFocused,
    required this.onFocus,
    super.key,
  });

  final MediaFile file;
  final int fps;
  final int tagCount;
  final bool isFocused;
  final Function() onFocus;

  @override
  Widget build(BuildContext context) => Material(
    color: isFocused ? Theme.of(context).colorScheme.primaryContainer : Colors.transparent,
    child: InkWell(
      onTap: onFocus,
      child: Padding(
        padding: .symmetric(horizontal: 16, vertical: 10),
        child: Row(
          spacing: 8,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Text(file.name, style: Theme.of(context).textTheme.bodyMedium),
                  Text(
                    tagCount == 1 ? '1 tag' : '$tagCount tags',
                    style: Theme.of(context).textTheme.labelSmall
                        ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
                  ),
                ],
              ),
            ),
            Text('${(file.frameCount / fps).toStringAsFixed(2)}s', style: Theme.of(context).textTheme.labelSmall),
          ],
        ),
      ),
    ),
  );
}
