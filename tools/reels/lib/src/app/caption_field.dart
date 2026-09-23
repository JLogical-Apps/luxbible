import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reels/src/model/clips.dart';

class CaptionField extends StatelessWidget {
  const CaptionField({required this.clip, required this.onChanged, super.key});

  final SourceClip clip;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) => Padding(
    padding: .fromLTRB(16, 0, 16, 16),
    child: TextFormField(
      key: ValueKey(clip.name),
      initialValue: clip.keeper.text ?? '',
      minLines: 1,
      maxLines: 3,
      inputFormatters: [FilteringTextInputFormatter.deny('\n')],
      decoration: InputDecoration(
        labelText: 'Caption',
        helperText: 'Saved as you type. Corrected words keep the timing of the words they replace.',
        border: OutlineInputBorder(),
      ),
      onChanged: onChanged,
    ),
  );
}
