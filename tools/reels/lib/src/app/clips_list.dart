import 'package:flutter/material.dart';
import 'package:reels/src/model/clips.dart';

class ClipsList extends StatelessWidget {
  const ClipsList({
    required this.source,
    required this.focused,
    required this.selected,
    required this.onFocus,
    required this.onToggle,
    required this.onRename,
    super.key,
  });

  final Clips source;
  final String? focused;
  final Set<String> selected;
  final ValueChanged<SourceClip> onFocus;
  final ValueChanged<SourceClip> onToggle;
  final void Function(SourceClip clip, String name) onRename;

  @override
  Widget build(BuildContext context) => ListView.builder(
    itemCount: source.clips.length,
    itemBuilder: (context, index) {
      final clip = source.clips[index];
      return ClipRow(
        clip: clip,
        fps: source.fps,
        isFocused: clip.name == focused,
        isSelected: selected.contains(clip.name),
        onFocus: () => onFocus(clip),
        onToggle: () => onToggle(clip),
        onRename: (name) => onRename(clip, name),
      );
    },
  );
}

class SelectionSyncBar extends StatelessWidget {
  const SelectionSyncBar({
    required this.fileName,
    required this.added,
    required this.removed,
    required this.onCopy,
    super.key,
  });

  final String fileName;
  final int added;
  final int removed;
  final Function() onCopy;

  bool get isInSync => added == 0 && removed == 0;

  @override
  Widget build(BuildContext context) => Padding(
    padding: .all(8),
    child: isInSync
        ? Text(
            'Matches $fileName',
            textAlign: .center,
            style: Theme.of(context).textTheme.labelSmall
                ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
          )
        : Column(
            crossAxisAlignment: .stretch,
            spacing: 8,
            children: [
              Text(
                '${[if (added > 0) '$added added', if (removed > 0) '$removed removed'].join(', ')} since $fileName',
                textAlign: .center,
                style: Theme.of(context).textTheme.labelSmall,
              ),
              FilledButton.icon(onPressed: onCopy, icon: Icon(Icons.copy_all_outlined), label: Text('Copy clips list')),
            ],
          ),
  );
}

class ClipRow extends StatelessWidget {
  const ClipRow({
    required this.clip,
    required this.fps,
    required this.isFocused,
    required this.isSelected,
    required this.onFocus,
    required this.onToggle,
    required this.onRename,
    super.key,
  });

  final SourceClip clip;
  final int fps;
  final bool isFocused;
  final bool isSelected;
  final VoidCallback onFocus;
  final VoidCallback onToggle;
  final ValueChanged<String> onRename;

  @override
  Widget build(BuildContext context) => Material(
    color: isFocused ? Theme.of(context).colorScheme.primaryContainer : Colors.transparent,
    child: InkWell(
      onTap: onFocus,
      child: Padding(
        padding: .symmetric(horizontal: 8, vertical: 4),
        child: Row(
          spacing: 8,
          children: [
            Checkbox(value: isSelected, onChanged: (_) => onToggle()),
            Expanded(
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  TextFormField(
                    key: ValueKey(clip.name),
                    initialValue: clip.name,
                    style: Theme.of(context).textTheme.bodyMedium,
                    decoration: const InputDecoration(isDense: true, border: InputBorder.none),
                    onFieldSubmitted: onRename,
                  ),
                  Text(
                    clip.keeper.isSilent ? 'no speech' : clip.keeper.text ?? '…',
                    maxLines: 2,
                    overflow: .ellipsis,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      fontStyle: clip.keeper.isSilent ? .italic : null,
                    ),
                  ),
                ],
              ),
            ),
            if (clip.takes.length > 1)
              Tooltip(
                message: '${clip.takes.length} takes, last one kept',
                child: Badge(label: Text('${clip.takes.length}')),
              ),
            Text(
              '${(clip.keeper.frameCount / fps).toStringAsFixed(2)}s',
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ],
        ),
      ),
    ),
  );
}
