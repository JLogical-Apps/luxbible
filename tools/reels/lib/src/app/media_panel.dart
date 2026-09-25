import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:media_kit/media_kit.dart';
import 'package:reels/src/app/trim_controls.dart';
import 'package:reels/src/model/media.dart';

const implicitTags = {'start', 'end'};

class MediaPanel extends HookWidget {
  const MediaPanel({
    required this.player,
    required this.file,
    required this.library,
    required this.fps,
    required this.onChanged,
    super.key,
  });

  final Player player;
  final MediaFile file;
  final MediaLibrary library;
  final int fps;

  /// Receives the file's stored tags, which hold `start` and `end` only once they've moved.
  final Function(Map<String, int>) onChanged;

  @override
  Widget build(BuildContext context) {
    final position = useStream(player.stream.position, initialData: player.state.position).requireData;
    final isPlaying = useStream(player.stream.playing, initialData: player.state.playing).requireData;
    // Seeks aim a quarter frame in, so reading the position back lands on the same frame either way mpv reports it.
    final frame = (position.inMicroseconds * fps / 1000000 + 0.3).floor().clamp(0, file.frameCount - 1);

    final tags = library.getSortedTags(file.name);
    final stored = library.tags[file.name] ?? {};

    Future<void> seek(int target) async {
      await player.pause();
      final clamped = target.clamp(0, file.frameCount - 1);
      await player.seek(Duration(microseconds: ((clamped + 0.25) * 1000000 / fps).round()));
    }

    void setTag(String tag, int target) => onChanged({...stored, tag: target.clamp(0, file.frameCount - 1)});

    void renameTag(String tag, String name) {
      final renamed = getTagName(name);
      if (renamed.isEmpty || implicitTags.contains(tag) || tags.any((t) => t.key == renamed)) return;
      onChanged({for (final entry in stored.entries) entry.key == tag ? renamed : entry.key: entry.value});
    }

    return Padding(
      padding: .fromLTRB(16, 8, 16, 16),
      child: Column(
        spacing: 8,
        children: [
          Padding(
            padding: .symmetric(horizontal: 24),
            child: MediaTimeline(frameCount: file.frameCount, frame: frame, tags: tags, onSeek: seek),
          ),
          Row(
            mainAxisAlignment: .center,
            spacing: 24,
            children: [
              IconButton.filledTonal(
                onPressed: isPlaying ? player.pause : player.play,
                icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
              ),
              NudgeGroup(label: 'Step', onNudge: (frames) => seek(frame + frames)),
              Column(
                children: [
                  Text('Frame $frame', style: Theme.of(context).textTheme.titleMedium),
                  Text(
                    '${(frame / fps).toStringAsFixed(2)}s of ${(file.frameCount / fps).toStringAsFixed(2)}s',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ],
              ),
            ],
          ),
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 220),
            child: ListView(
              shrinkWrap: true,
              children: tags
                  .map(
                    (tag) => TagRow(
                      key: ValueKey(tag.key),
                      name: tag.key,
                      frame: tag.value,
                      isImplicit: implicitTags.contains(tag.key),
                      isMoved: stored.containsKey(tag.key),
                      isCurrent: tag.value == frame,
                      onSeek: () => seek(tag.value),
                      onNudge: (frames) => setTag(tag.key, tag.value + frames),
                      onSetHere: () => setTag(tag.key, frame),
                      onRename: (name) => renameTag(tag.key, name),
                      onRemove: () => onChanged({...stored}..remove(tag.key)),
                    ),
                  )
                  .toList(),
            ),
          ),
          AddTagField(
            frame: frame,
            onAdd: (name) {
              final added = getTagName(name);
              if (added.isEmpty || tags.any((t) => t.key == added)) return false;
              setTag(added, frame);
              return true;
            },
          ),
        ],
      ),
    );
  }

  String getTagName(String name) => name.trim().replaceAll(RegExp(r'\s+'), '_');
}

class MediaTimeline extends StatelessWidget {
  const MediaTimeline({
    required this.frameCount,
    required this.frame,
    required this.tags,
    required this.onSeek,
    super.key,
  });

  final int frameCount;
  final int frame;
  final List<MapEntry<String, int>> tags;
  final Function(int) onSeek;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final width = constraints.maxWidth;
      final colors = Theme.of(context).colorScheme;
      double getX(int target) => frameCount <= 1 ? 0 : target / (frameCount - 1) * width;
      int getFrame(double x) => (x / width * (frameCount - 1)).round().clamp(0, frameCount - 1);
      final start = tags.firstWhere((tag) => tag.key == 'start').value;
      final end = tags.firstWhere((tag) => tag.key == 'end').value;

      return GestureDetector(
        behavior: .opaque,
        onTapDown: (details) => onSeek(getFrame(details.localPosition.dx)),
        onHorizontalDragUpdate: (details) => onSeek(getFrame(details.localPosition.dx)),
        child: SizedBox(
          height: 64,
          child: Stack(
            clipBehavior: .none,
            children: [
              Positioned(
                left: 0,
                right: 0,
                top: 40,
                height: 6,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: colors.surfaceContainerHighest, borderRadius: .circular(3)),
                ),
              ),
              Positioned(
                left: getX(start),
                width: getX(end) - getX(start),
                top: 40,
                height: 6,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: colors.primary.withValues(alpha: 0.5), borderRadius: .circular(3)),
                ),
              ),
              ...tags.indexed.expand(
                (entry) => [
                  Positioned(
                    left: getX(entry.$2.value) - 50,
                    width: 100,
                    // Alternating rows keep neighbouring labels from overlapping.
                    top: entry.$1.isEven ? 0 : 14,
                    child: Text(
                      entry.$2.key,
                      textAlign: .center,
                      maxLines: 1,
                      overflow: .ellipsis,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                  Positioned(
                    left: getX(entry.$2.value) - 1,
                    width: 2,
                    top: entry.$1.isEven ? 14 : 28,
                    bottom: 18,
                    child: ColoredBox(color: colors.tertiary),
                  ),
                ],
              ),
              Positioned(
                left: getX(frame) - 1.5,
                width: 3,
                top: 30,
                bottom: 8,
                child: ColoredBox(color: colors.onSurface),
              ),
            ],
          ),
        ),
      );
    },
  );
}

class TagRow extends StatelessWidget {
  const TagRow({
    required this.name,
    required this.frame,
    required this.isImplicit,
    required this.isMoved,
    required this.isCurrent,
    required this.onSeek,
    required this.onNudge,
    required this.onSetHere,
    required this.onRename,
    required this.onRemove,
    super.key,
  });

  final String name;
  final int frame;
  final bool isImplicit;
  final bool isMoved;
  final bool isCurrent;
  final Function() onSeek;
  final Function(int) onNudge;
  final Function() onSetHere;
  final Function(String) onRename;
  final Function() onRemove;

  @override
  Widget build(BuildContext context) => Material(
    color: isCurrent ? Theme.of(context).colorScheme.primaryContainer : Colors.transparent,
    child: InkWell(
      onTap: onSeek,
      child: Padding(
        padding: .symmetric(horizontal: 8, vertical: 2),
        child: Row(
          spacing: 4,
          children: [
            Expanded(
              child: TextFormField(
                key: ValueKey(name),
                initialValue: name,
                readOnly: isImplicit,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontStyle: isImplicit ? .italic : null),
                decoration: InputDecoration(isDense: true, border: InputBorder.none),
                onFieldSubmitted: onRename,
              ),
            ),
            SizedBox(width: 56, child: Text('$frame', textAlign: .end)),
            IconButton(onPressed: () => onNudge(-1), icon: Icon(Icons.chevron_left), tooltip: 'Earlier'),
            IconButton(onPressed: () => onNudge(1), icon: Icon(Icons.chevron_right), tooltip: 'Later'),
            IconButton(onPressed: onSetHere, icon: Icon(Icons.my_location), tooltip: 'Move to the current frame'),
            if (!isImplicit)
              IconButton(onPressed: onRemove, icon: Icon(Icons.delete_outline), tooltip: 'Remove')
            else
              IconButton(
                onPressed: isMoved ? onRemove : null,
                icon: Icon(Icons.restart_alt),
                tooltip: 'Reset to $mediaEdgeTrim frames from the edge',
              ),
          ],
        ),
      ),
    ),
  );
}

class AddTagField extends HookWidget {
  const AddTagField({required this.frame, required this.onAdd, super.key});

  final int frame;

  /// Returns whether the tag was added, which clears the field.
  final bool Function(String) onAdd;

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();

    void add() {
      if (onAdd(controller.text)) controller.clear();
    }

    return Row(
      spacing: 12,
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(labelText: 'New tag', hintText: 'study_start', isDense: true),
            onSubmitted: (_) => add(),
          ),
        ),
        FilledButton.icon(onPressed: add, icon: Icon(Icons.bookmark_add_outlined), label: Text('Tag frame $frame')),
      ],
    );
  }
}
