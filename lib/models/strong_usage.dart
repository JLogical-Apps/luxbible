import 'package:bible/models/morphology.dart';
import 'package:bible/utils/markdown.dart';

extension StrongUsageMarkdownExtension on Markdown {
  Markdown get withMorphologyLinks => Markdown(
    text.replaceAllMapped(
      RegExp(r'\((qal passive|hithpael|nithpael|niphal|hiphil|hophal|piel|pual|qal)\)', caseSensitive: false),
      (match) {
        final stem = HebrewStem.fromDisplayName(match.group(1)!);
        if (stem == null) return match.group(0)!;
        return '[(${stem.displayName})](${stem.linkTarget})';
      },
    ),
  );
}
