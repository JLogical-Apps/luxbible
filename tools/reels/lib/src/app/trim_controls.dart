import 'package:flutter/material.dart';
import 'package:reels/src/model/clips.dart';

const nudgeSteps = [-5, -1, 1, 5];

class TrimControls extends StatelessWidget {
  const TrimControls({required this.clip, required this.fps, required this.onTrim, required this.onReplay, super.key});

  final SourceClip clip;
  final int fps;
  final void Function(SourceClip clip, {int start, int end}) onTrim;
  final VoidCallback onReplay;

  @override
  Widget build(BuildContext context) => Padding(
    padding: .all(16),
    child: Row(
      mainAxisAlignment: .center,
      spacing: 24,
      children: [
        NudgeGroup(
          label: 'Start',
          onNudge: (frames) => onTrim(clip, start: frames),
        ),
        Column(
          children: [
            Text(
              '${(clip.keeper.frameCount / fps).toStringAsFixed(2)}s',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text('${clip.keeper.start}–${clip.keeper.end}', style: Theme.of(context).textTheme.labelSmall),
          ],
        ),
        NudgeGroup(
          label: 'End',
          onNudge: (frames) => onTrim(clip, end: frames),
        ),
        IconButton.filledTonal(onPressed: onReplay, icon: const Icon(Icons.replay)),
      ],
    ),
  );
}

class NudgeGroup extends StatelessWidget {
  const NudgeGroup({required this.label, required this.onNudge, super.key});

  final String label;
  final ValueChanged<int> onNudge;

  @override
  Widget build(BuildContext context) => Column(
    spacing: 4,
    children: [
      Text(label, style: Theme.of(context).textTheme.labelSmall),
      Row(
        spacing: 4,
        children: nudgeSteps
            .map(
              (frames) => OutlinedButton(
                onPressed: () => onNudge(frames),
                style: OutlinedButton.styleFrom(padding: .symmetric(horizontal: 10), minimumSize: const Size(0, 32)),
                child: Text(frames > 0 ? '+$frames' : '$frames'),
              ),
            )
            .toList(),
      ),
    ],
  );
}
